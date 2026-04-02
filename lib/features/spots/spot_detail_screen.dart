import 'package:flutter/material.dart';

import '../../data/demo/demo_routes.dart';
import '../../data/models/route_model.dart';
import '../../data/models/spot.dart';
import '../routes/route_player_screen.dart';

class SpotDetailScreen extends StatelessWidget {
  final Spot spot;

  const SpotDetailScreen({
    super.key,
    required this.spot,
  });

  RouteModel? _findRouteForSpot() {
    for (final route in demoRoutes) {
      final match = route.spots.any((routeSpot) => routeSpot.id == spot.id);
      if (match) {
        return route;
      }
    }
    return null;
  }

  int _findSpotIndexInRoute(RouteModel route) {
    return route.spots.indexWhere((routeSpot) => routeSpot.id == spot.id);
  }

  @override
  Widget build(BuildContext context) {
    final matchingRoute = _findRouteForSpot();

    return Scaffold(
      backgroundColor: const Color(0xFF0B0F14),
      body: ListView(
        children: [
          Stack(
            children: [
              SizedBox(
                height: 320,
                width: double.infinity,
                child: Image.asset(
                  spot.imagePath,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 48,
                left: 16,
                child: CircleAvatar(
                  backgroundColor: Colors.black54,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
              Positioned(
                top: 48,
                right: 16,
                child: CircleAvatar(
                  backgroundColor: Colors.black54,
                  child: IconButton(
                    icon: const Icon(Icons.bookmark_border, color: Colors.white),
                    onPressed: () {},
                  ),
                ),
              ),
              Positioned(
                left: 24,
                right: 24,
                bottom: 20,
                child: Text(
                  spot.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          Container(
            color: const Color(0xFF0B0F14),
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    _InfoChip(label: spot.city),
                    _InfoChip(label: spot.category),
                    _InfoChip(
                      label: '${spot.estimatedDuration.inMinutes} Minuten',
                    ),
                  ],
                ),
                const SizedBox(height: 28),
                const Text(
                  'Über diesen Ort',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  spot.shortDescription,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 15,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 28),
                const Text(
                  'Geschichte & Details',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  spot.longDescription,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 15,
                    height: 1.7,
                  ),
                ),
                const SizedBox(height: 28),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: matchingRoute == null
                        ? null
                        : () {
                            final startIndex =
                                _findSpotIndexInRoute(matchingRoute);

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => RoutePlayerScreen(
                                  route: matchingRoute,
                                  initialIndex: startIndex < 0 ? 0 : startIndex,
                                ),
                              ),
                            );
                          },
                    icon: const Icon(Icons.route),
                    label: Text(
                      matchingRoute == null
                          ? 'Keine Route verfügbar'
                          : 'Route starten',
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

class _InfoChip extends StatelessWidget {
  final String label;

  const _InfoChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF2B3140),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}