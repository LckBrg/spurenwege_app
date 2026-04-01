import 'package:flutter/material.dart';

import '../../data/models/spot.dart';
import '../../data/repositories/favorites_repository.dart';

class SpotDetailScreen extends StatefulWidget {
  final Spot spot;

  const SpotDetailScreen({super.key, required this.spot});

  @override
  State<SpotDetailScreen> createState() => _SpotDetailScreenState();
}

class _SpotDetailScreenState extends State<SpotDetailScreen> {
  final repo = FavoritesRepository();

  String getHeaderImage() {
    switch (widget.spot.title) {
      case 'Gasserplatz':
        return 'assets/images/spots/gasserplatz.jpg';
      case 'Schattenburg':
        return 'assets/images/spots/schattenburg.jpg';
      case 'Altstadt Bludenz':
        return 'assets/images/spots/bludenz.jpg';
      default:
        return 'assets/images/spots/schattenburg.jpg';
    }
  }

  @override
  Widget build(BuildContext context) {
    final spot = widget.spot;
    final isFav = repo.isFavorite(spot);
    final theme = Theme.of(context);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 280,
            pinned: true,
            backgroundColor: const Color(0xFF171A22),
            actions: [
              IconButton(
                onPressed: () {
                  setState(() {
                    repo.toggleFavorite(spot);
                  });
                },
                icon: Icon(isFav ? Icons.bookmark : Icons.bookmark_border),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.only(
                left: 16,
                right: 16,
                bottom: 16,
              ),
              title: Text(
                spot.title,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  shadows: [Shadow(blurRadius: 8, color: Colors.black54)],
                ),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(getHeaderImage(), fit: BoxFit.cover),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.black.withOpacity(0.15),
                          Colors.black.withOpacity(0.35),
                          Colors.black.withOpacity(0.72),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              color: const Color(0xFF171A22),
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _InfoTag(label: spot.city),
                      _InfoTag(label: spot.category),
                      _InfoTag(
                        label: '${spot.estimatedDuration.inMinutes} Minuten',
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text('Über diesen Ort', style: theme.textTheme.titleLarge),
                  const SizedBox(height: 8),
                  Text(spot.shortDescription, style: theme.textTheme.bodyLarge),
                  const SizedBox(height: 24),
                  Text(
                    'Geschichte & Details',
                    style: theme.textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(spot.longDescription, style: theme.textTheme.bodyLarge),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.route),
                      label: const Text('Route starten (später)'),
                      style: FilledButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoTag extends StatelessWidget {
  final String label;

  const _InfoTag({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.10),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
