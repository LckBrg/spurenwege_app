import 'package:flutter/material.dart';

import '../../data/demo/demo_spots.dart';
import '../../data/models/spot.dart';
import '../spots/spot_detail_screen.dart';
import 'widgets/spot_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String searchText = '';

  List<Spot> get filteredSpots {
    if (searchText.trim().isEmpty) {
      return demoSpots;
    }

    final query = searchText.toLowerCase().trim();

    return demoSpots.where((spot) {
      return spot.title.toLowerCase().contains(query) ||
          spot.city.toLowerCase().contains(query) ||
          spot.category.toLowerCase().contains(query) ||
          spot.shortDescription.toLowerCase().contains(query);
    }).toList();
  }

  void openSpotDetail(Spot spot) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => SpotDetailScreen(spot: spot)));
  }

  @override
  Widget build(BuildContext context) {
    final spots = filteredSpots;

    return Scaffold(
      appBar: AppBar(title: const Text('Spurenwege')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                color: Theme.of(context).colorScheme.primaryContainer,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Vorarlberg entdecken',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Erste Demo-Struktur für Spots, Geschichten und spätere Routen.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              onChanged: (value) {
                setState(() {
                  searchText = value;
                });
              },
              decoration: const InputDecoration(
                hintText: 'Spots suchen...',
                prefixIcon: Icon(Icons.search),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Text(
                  'Spots',
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                Text(
                  '${spots.length} gefunden',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
            const SizedBox(height: 12),
            Expanded(
              child: spots.isEmpty
                  ? const Center(child: Text('Keine Spots gefunden.'))
                  : ListView.separated(
                      itemCount: spots.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final spot = spots[index];
                        return SpotCard(
                          spot: spot,
                          onTap: () => openSpotDetail(spot),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
