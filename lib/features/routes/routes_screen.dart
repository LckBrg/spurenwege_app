import 'package:flutter/material.dart';

import '../../data/demo/demo_routes.dart';
import '../../data/models/route_model.dart';
import '../../data/repositories/route_progress_repository.dart';
import 'route_detail_screen.dart';

class RoutesScreen extends StatefulWidget {
  const RoutesScreen({super.key});

  @override
  State<RoutesScreen> createState() => _RoutesScreenState();
}

class _RoutesScreenState extends State<RoutesScreen> {
  final repo = RouteProgressRepository();

  final Map<String, int> saved = {};
  final Map<String, bool> completed = {};
  final Map<String, bool> started = {};

  bool loading = true;

  @override
  void initState() {
    super.initState();
    load();
  }

  Future<void> load() async {
    for (final r in demoRoutes) {
      saved[r.id] = await repo.getSavedIndex(r.id);
      completed[r.id] = await repo.isCompleted(r.id);
      started[r.id] = await repo.isStarted(r.id);
    }

    setState(() => loading = false);
  }

  Future<void> open(RouteModel r) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => RouteDetailScreen(route: r),
      ),
    );

    await load();
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Center(child: CircularProgressIndicator());
    }

    return ListView(
      padding: const EdgeInsets.all(16),
      children: demoRoutes.map((r) {
        final s = saved[r.id] ?? 0;
        final c = completed[r.id] ?? false;
        final st = started[r.id] ?? false;

        String label;
        double progress;

        if (c) {
          label = 'Abgeschlossen';
          progress = 1;
        } else if (st) {
          label = 'Station ${s + 1}';
          progress = (s + 1) / r.spotCount;
        } else {
          label = 'Neu';
          progress = 0;
        }

        return Card(
          color: const Color(0xFF121821),
          child: ListTile(
            title: Text(r.title,
                style: const TextStyle(color: Colors.white)),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style:
                        const TextStyle(color: Colors.white70)),
                LinearProgressIndicator(value: progress),
              ],
            ),
            onTap: () => open(r),
          ),
        );
      }).toList(),
    );
  }
}