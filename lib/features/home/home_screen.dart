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
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(title: const Text('Spurenwege')),
      body: Stack(
        children: [
          /// Fester Hintergrund
          Positioned.fill(
            child: Image.asset(
              'assets/images/spots/schattenburg.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withOpacity(0.72),
                    Colors.black.withOpacity(0.55),
                    const Color(0xFF171A22).withOpacity(0.88),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),

          /// Scrollbarer Inhalt
          ListView(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
            children: [
              Container(
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.10),
                  borderRadius: BorderRadius.circular(28),
                  border: Border.all(color: Colors.white.withOpacity(0.10)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: const Text(
                        'Entdecken • Erleben • Erinnern',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),
                    Text(
                      'Vorarlberg neu entdecken.',
                      style: theme.textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Geschichten, besondere Orte und spätere Erlebnisrouten in einer App.',
                      style: theme.textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(22),
                  border: Border.all(color: Colors.white.withOpacity(0.08)),
                ),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      searchText = value;
                    });
                  },
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    hintText: 'Spots, Städte oder Kategorien suchen',
                    prefixIcon: Icon(Icons.search),
                  ),
                ),
              ),
              const SizedBox(height: 18),
              Row(
                children: [
                  Text('Empfohlene Spots', style: theme.textTheme.titleLarge),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.10),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text(
                      '${spots.length} gefunden',
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              if (spots.isEmpty)
                const Padding(
                  padding: EdgeInsets.only(top: 40),
                  child: Center(
                    child: Text(
                      'Keine Spots gefunden.',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                )
              else
                ...spots.map(
                  (spot) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: SpotCard(
                      spot: spot,
                      onTap: () => openSpotDetail(spot),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
