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
    final List<Spot> favorites = repo.getFavorites();

    return Scaffold(
      appBar: AppBar(title: const Text('Merkliste')),
      body: favorites.isEmpty
          ? const Center(child: Text('Noch keine gespeicherten Spots.'))
          : ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final spot = favorites[index];

                return ListTile(
                  title: Text(spot.title),
                  subtitle: Text('${spot.city} • ${spot.category}'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => SpotDetailScreen(spot: spot),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
