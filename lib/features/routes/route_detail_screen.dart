import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../data/models/route_model.dart';
import '../../data/repositories/favorites_repository.dart';
import '../../data/repositories/route_progress_repository.dart';
import 'route_player_screen.dart';

class RouteDetailScreen extends StatefulWidget {
  final RouteModel route;

  const RouteDetailScreen({
    super.key,
    required this.route,
  });

  @override
  State<RouteDetailScreen> createState() => _RouteDetailScreenState();
}

class _RouteDetailScreenState extends State<RouteDetailScreen> {
  final RouteProgressRepository progressRepo = RouteProgressRepository();
  final FavoritesRepository favoritesRepo = FavoritesRepository();

  int savedIndex = 0;
  bool isCompleted = false;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadProgress();
  }

  Future<void> _loadProgress() async {
    final index = await progressRepo.getSavedIndex(widget.route.id);
    final completed = await progressRepo.isCompleted(widget.route.id);

    if (!mounted) return;

    setState(() {
      savedIndex = index;
      isCompleted = completed;
      isLoading = false;
    });
  }

  Future<void> _shareRoute() async {
    final shareText =
        'Spurenwege – ${widget.route.title}\n${widget.route.city} • ${widget.route.durationLabel}\n${widget.route.shortDescription}';

    await Clipboard.setData(ClipboardData(text: shareText));

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Routeninfo zu "${widget.route.title}" kopiert.'),
      ),
    );
  }

  void _toggleFavorite() {
    setState(() {
      favoritesRepo.toggleRouteFavorite(widget.route.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool hasProgress = savedIndex > 0 || isCompleted;
    final isFavorite = favoritesRepo.isRouteFavorite(widget.route.id);

    return Scaffold(
      backgroundColor: const Color(0xFF0B0F14),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              children: [
                Stack(
                  children: [
                    Image.asset(
                      widget.route.startImage,
                      height: 280,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    Container(
                      height: 280,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.black.withOpacity(0.15),
                            Colors.black.withOpacity(0.82),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                    SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 10,
                        ),
                        child: Row(
                          children: [
                            _HeaderCircleButton(
                              icon: Icons.arrow_back,
                              onTap: () => Navigator.pop(context),
                            ),
                            const Spacer(),
                            _HeaderCircleButton(
                              icon: isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              iconColor:
                                  isFavorite ? Colors.redAccent : Colors.white,
                              onTap: _toggleFavorite,
                            ),
                            const SizedBox(width: 8),
                            _HeaderCircleButton(
                              icon: Icons.ios_share,
                              onTap: _shareRoute,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.route.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.w800,
                          height: 1.1,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        widget.route.shortDescription,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 15,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          _DetailBadge(label: widget.route.city),
                          _DetailBadge(label: widget.route.durationLabel),
                          _DetailBadge(label: widget.route.difficulty),
                          _DetailBadge(label: widget.route.focus),
                          _DetailBadge(label: widget.route.tierLabel),
                        ],
                      ),
                      const SizedBox(height: 14),
                      Text(
                        'Stimmung: ${widget.route.mood}',
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      const SizedBox(height: 22),
                      Container(
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: const Color(0xFF121821),
                          borderRadius: BorderRadius.circular(22),
                          border: Border.all(color: const Color(0xFF1C2430)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Worum es geht',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              widget.route.longDescription,
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                                height: 1.6,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 18),
                      Container(
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: const Color(0xFF121821),
                          borderRadius: BorderRadius.circular(22),
                          border: Border.all(color: const Color(0xFF1C2430)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Hinweis zur Route',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 12),
                            const Text(
                              'Die Route zeigt dir ihre Stationen nicht im Voraus. Du bekommst nur den Einstieg – den Rest musst du dir über Rätsel und Hinweise erschließen.',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                                height: 1.6,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              isCompleted
                                  ? 'Du hast diese Route bereits abgeschlossen.'
                                  : hasProgress
                                      ? 'Du kannst deine Spur später wieder aufnehmen.'
                                      : 'Du startest ohne Spoiler – nur mit dem ersten Impuls.',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 28),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF4F8CFF),
                            padding: const EdgeInsets.symmetric(vertical: 15),
                          ),
                          onPressed: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => RoutePlayerScreen(
                                  route: widget.route,
                                  initialIndex: hasProgress ? savedIndex : 0,
                                ),
                              ),
                            );
                            await _loadProgress();
                          },
                          child: Text(
                            hasProgress ? 'Spur fortsetzen' : 'Spur beginnen',
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}

class _HeaderCircleButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final Color iconColor;

  const _HeaderCircleButton({
    required this.icon,
    required this.onTap,
    this.iconColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black.withOpacity(0.35),
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: SizedBox(
          width: 44,
          height: 44,
          child: Icon(
            icon,
            color: iconColor,
            size: 22,
          ),
        ),
      ),
    );
  }
}

class _DetailBadge extends StatelessWidget {
  final String label;

  const _DetailBadge({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFF1B2633),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}