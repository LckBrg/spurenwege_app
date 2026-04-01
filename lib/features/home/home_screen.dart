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
      appBar: AppBar(title: const Text('Spurenwege')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28),
              gradient: const LinearGradient(
                colors: [Color(0xFF355C7D), Color(0xFF6C5B7B)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(26),
                  blurRadius: 18,
                  offset: const Offset(0, 8),
                ),
              ],
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
                    color: Colors.white.withAlpha(40),
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
                const Text(
                  'Vorarlberg neu entdecken.',
                  style: TextStyle(
                    fontSize: 30,
                    height: 1.1,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Geschichten, besondere Orte und spätere Erlebnisrouten in einer App.',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: Colors.white.withAlpha(230),
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 18),
                Row(
                  children: [
                    _HeroStat(
                      icon: Icons.place_outlined,
                      value: '${demoSpots.length}',
                      label: 'Spots',
                    ),
                    const SizedBox(width: 10),
                    const _HeroStat(
                      icon: Icons.route_outlined,
                      value: '0',
                      label: 'Routen',
                    ),
                    const SizedBox(width: 10),
                    const Expanded(child: SizedBox()),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(22),
            ),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  searchText = value;
                });
              },
              decoration: const InputDecoration(
                hintText: 'Spots, Städte oder Kategorien suchen',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          const SizedBox(height: 18),
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF8E8),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: const Color(0xFFF3E2A9)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 46,
                  height: 46,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFE7A3),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Icon(Icons.auto_stories_outlined),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Spurenwege wächst gerade',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Später findest du hier Geschichten, Audiostationen, Rätsel und komplette Erlebnisrouten.',
                        style: theme.textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ],
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
                  color: Colors.white,
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
              padding: EdgeInsets.only(top: 50),
              child: Center(child: Text('Keine Spots gefunden.')),
            )
          else
            ...spots.map(
              (spot) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: SpotCard(spot: spot, onTap: () => openSpotDetail(spot)),
              ),
            ),
        ],
      ),
    );
  }
}

class _HeroStat extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;

  const _HeroStat({
    required this.icon,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(34),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white, size: 18),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 15,
                ),
              ),
              Text(
                label,
                style: const TextStyle(color: Colors.white70, fontSize: 11),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
