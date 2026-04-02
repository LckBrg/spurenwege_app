import 'package:flutter/material.dart';

import '../../data/models/route_model.dart';
import '../../data/models/route_step_model.dart';
import '../../data/repositories/route_progress_repository.dart';

class RoutePlayerScreen extends StatefulWidget {
  final RouteModel route;
  final int? initialIndex;

  const RoutePlayerScreen({
    super.key,
    required this.route,
    this.initialIndex,
  });

  @override
  State<RoutePlayerScreen> createState() => _RoutePlayerScreenState();
}

class _RoutePlayerScreenState extends State<RoutePlayerScreen> {
  final RouteProgressRepository repo = RouteProgressRepository();
  final TextEditingController answerController = TextEditingController();

  int currentIndex = 0;
  int revealedHints = 0;
  bool isLoading = true;
  bool isCompleted = false;
  bool answerSolved = false;
  String? feedbackMessage;

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  void dispose() {
    answerController.dispose();
    super.dispose();
  }

  Future<void> _init() async {
    final savedIndex = await repo.getSavedIndex(widget.route.id);
    final completed = await repo.isCompleted(widget.route.id);
    final startIndex = widget.initialIndex ?? savedIndex;

    await repo.setStarted(widget.route.id, true);
    await repo.saveIndex(widget.route.id, startIndex);

    final stationSolved = await repo.isStationSolved(widget.route.id, startIndex);

    if (!mounted) return;

    setState(() {
      currentIndex = startIndex;
      isCompleted = completed;
      answerSolved = stationSolved;
      isLoading = false;
      revealedHints = 0;
      feedbackMessage =
          stationSolved ? 'Dieser Schritt wurde bereits gelöst.' : null;
    });
  }

  Future<void> _refreshCurrentStepState() async {
    final solved = await repo.isStationSolved(widget.route.id, currentIndex);

    if (!mounted) return;

    setState(() {
      answerSolved = solved;
      feedbackMessage = solved ? 'Dieser Schritt wurde bereits gelöst.' : null;
      revealedHints = 0;
      answerController.clear();
    });
  }

  Future<void> _updateCompletionState() async {
    final solvedStations = await repo.getSolvedStations(widget.route.id);
    final done = solvedStations.length >= widget.route.steps.length;

    await repo.setCompleted(widget.route.id, done);

    if (!mounted) return;

    setState(() {
      isCompleted = done;
    });
  }

  Future<void> _checkAnswer() async {
    final RouteStepModel step = widget.route.steps[currentIndex];
    final input = answerController.text.trim();

    if (input.isEmpty) {
      setState(() {
        feedbackMessage = 'Bitte gib zuerst eine Antwort ein.';
      });
      return;
    }

    final correct = step.matchesAnswer(input);

    if (!correct) {
      setState(() {
        feedbackMessage =
            'Das passt noch nicht. Nutze bei Bedarf einen Hinweis.';
      });
      return;
    }

    await repo.markStationSolved(widget.route.id, currentIndex);
    await repo.saveIndex(widget.route.id, currentIndex);
    await _updateCompletionState();

    if (!mounted) return;

    setState(() {
      answerSolved = true;
      feedbackMessage =
          'Richtig. Das nächste Ziel wurde freigeschaltet.';
    });
  }

  void _showNextHint() {
    final step = widget.route.steps[currentIndex];

    if (revealedHints >= step.hints.length) {
      return;
    }

    setState(() {
      revealedHints++;
    });
  }

  Future<void> _next() async {
    if (!answerSolved) {
      setState(() {
        feedbackMessage = 'Löse zuerst das Rätsel, bevor du weitergehst.';
      });
      return;
    }

    if (currentIndex < widget.route.steps.length - 1) {
      final nextIndex = currentIndex + 1;
      await repo.saveIndex(widget.route.id, nextIndex);

      if (!mounted) return;

      setState(() {
        currentIndex = nextIndex;
      });

      await _refreshCurrentStepState();
      await _updateCompletionState();
      return;
    }

    await _updateCompletionState();

    if (!mounted) return;

    setState(() {
      feedbackMessage = 'Route abgeschlossen.';
    });
  }

  Future<void> _back() async {
    if (currentIndex == 0) {
      return;
    }

    final previousIndex = currentIndex - 1;
    await repo.saveIndex(widget.route.id, previousIndex);

    if (!mounted) return;

    setState(() {
      currentIndex = previousIndex;
    });

    await _refreshCurrentStepState();
    await _updateCompletionState();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        backgroundColor: Color(0xFF0B0F14),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final RouteStepModel step = widget.route.steps[currentIndex];
    final progress = (currentIndex + 1) / widget.route.steps.length;
    final isLastStep = currentIndex == widget.route.steps.length - 1;

    return Scaffold(
      backgroundColor: const Color(0xFF0B0F14),
      appBar: AppBar(
        title: Text(widget.route.title),
        backgroundColor: const Color(0xFF0B0F14),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          LinearProgressIndicator(value: progress),
          const SizedBox(height: 10),
          Text(
            'Schritt ${currentIndex + 1}/${widget.route.steps.length}',
            style: const TextStyle(color: Colors.white70),
          ),
          const SizedBox(height: 22),
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: const Color(0xFF121821),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0xFF1C2430)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Spur',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  step.storyText,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                    height: 1.55,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: const Color(0xFF121821),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0xFF1C2430)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Rätsel',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  step.riddleQuestion,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                    height: 1.55,
                  ),
                ),
                const SizedBox(height: 14),
                TextField(
                  controller: answerController,
                  enabled: !answerSolved,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Antwort eingeben',
                    hintStyle: const TextStyle(color: Colors.white38),
                    filled: true,
                    fillColor: const Color(0xFF1B2633),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: answerSolved ? null : _checkAnswer,
                    child: Text(
                      answerSolved ? 'Bereits gelöst' : 'Antwort prüfen',
                    ),
                  ),
                ),
                if (feedbackMessage != null) ...[
                  const SizedBox(height: 10),
                  Text(
                    feedbackMessage!,
                    style: TextStyle(
                      color: answerSolved ? Colors.greenAccent : Colors.white70,
                      fontSize: 13,
                    ),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 16),
          if (!answerSolved)
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: const Color(0xFF121821),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFF1C2430)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Hinweise',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 12),
                  if (revealedHints == 0)
                    const Text(
                      'Noch keine Hinweise geöffnet.',
                      style: TextStyle(color: Colors.white70),
                    ),
                  ...List.generate(revealedHints, (index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Text(
                        '${index + 1}. ${step.hints[index]}',
                        style: const TextStyle(
                          color: Colors.white70,
                          height: 1.4,
                        ),
                      ),
                    );
                  }),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed:
                          revealedHints < step.hints.length ? _showNextHint : null,
                      child: Text(
                        revealedHints < step.hints.length
                            ? 'Nächsten Hinweis anzeigen'
                            : 'Alle Hinweise geöffnet',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          if (answerSolved)
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: const Color(0xFF102117),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFF1D4730)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Freigeschaltet',
                    style: TextStyle(
                      color: Colors.greenAccent,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    step.revealedLocationTitle,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    step.revealedLocationDescription,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: currentIndex == 0 ? null : _back,
                  child: const Text('Zurück'),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  onPressed: _next,
                  child: Text(
                    isLastStep
                        ? (answerSolved ? 'Route abschließen' : 'Erst Rätsel lösen')
                        : (answerSolved ? 'Weiter' : 'Erst Rätsel lösen'),
                  ),
                ),
              ),
            ],
          ),
          if (isCompleted) ...[
            const SizedBox(height: 16),
            const Text(
              'Diese Route ist abgeschlossen.',
              style: TextStyle(
                color: Colors.greenAccent,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ],
      ),
    );
  }
}