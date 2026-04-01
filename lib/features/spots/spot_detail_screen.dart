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

  @override
  Widget build(BuildContext context) {
    final spot = widget.spot;
    final isFav = repo.isFavorite(spot);
    final theme = Theme.of(context);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 240,
            pinned: true,
            backgroundColor: Colors.transparent,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.only(left: 16, bottom: 16),
              title: Text(
                spot.title,
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF355C7D), Color(0xFF6C5B7B)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: const Center(
                  child: Icon(
                    Icons.place_rounded,
                    size: 80,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
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
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Meta Infos
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

                  /// Einleitung
                  Text('Über diesen Ort', style: theme.textTheme.titleLarge),
                  const SizedBox(height: 8),
                  Text(spot.shortDescription, style: theme.textTheme.bodyLarge),

                  const SizedBox(height: 24),

                  /// Details
                  Text(
                    'Geschichte & Details',
                    style: theme.textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(spot.longDescription, style: theme.textTheme.bodyLarge),

                  const SizedBox(height: 32),

                  /// CTA Button
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.route),
                      label: const Text('Route starten (später)'),
                      style: FilledButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
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
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFF2F4F7),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: Theme.of(
          context,
        ).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600),
      ),
    );
  }
}
