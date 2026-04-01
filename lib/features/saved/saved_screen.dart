import 'package:flutter/material.dart';

import '../../data/repositories/favorites_repository.dart';
import '../../data/models/spot.dart';
import '../spots/spot_detail_screen.dart';

class SavedScreen extends StatefulWidget {
  const SavedScreen({super.key});

  @override
  State<SavedScreen> createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  final repo = FavoritesRepository();

  @override
  Widget build(BuildContext context) {
    final favorites = repo.getFavorites();

    return Scaffold(
      appBar: AppBar(title: const Text('Merkliste')),
      body: favorites.isEmpty
          ? const _EmptyState()
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final spot = favorites[index];
                return _SpotCard(
                  spot: spot,
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => SpotDetailScreen(spot: spot),
                      ),
                    );
                    setState(() {});
                  },
                );
              },
            ),
    );
  }
}

class _SpotCard extends StatelessWidget {
  final Spot spot;
  final VoidCallback onTap;

  const _SpotCard({required this.spot, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        elevation: 1,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                /// Icon Box
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE6EAF2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.place),
                ),

                const SizedBox(width: 12),

                /// Text
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        spot.title,
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${spot.city} • ${spot.category}',
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        spot.shortDescription,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),

                /// Dauer
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Icon(Icons.chevron_right),
                    const SizedBox(height: 8),
                    Text(
                      '${spot.estimatedDuration.inMinutes} min',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(Icons.bookmark_border, size: 64),
            SizedBox(height: 16),
            Text(
              'Noch nichts gespeichert',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 8),
            Text(
              'Speichere Orte, um sie später wiederzufinden.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
