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
    final isFav = repo.isFavorite(widget.spot);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.spot.title),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                repo.toggleFavorite(widget.spot);
              });
            },
            icon: Icon(isFav ? Icons.bookmark : Icons.bookmark_border),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                color: Theme.of(context).colorScheme.secondaryContainer,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.spot.title,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text('${widget.spot.city} • ${widget.spot.category}'),
                  const SizedBox(height: 8),
                  Text('Dauer: ${widget.spot.estimatedDuration.inMinutes} min'),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Text('Details', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Text(widget.spot.longDescription),
          ],
        ),
      ),
    );
  }
}
