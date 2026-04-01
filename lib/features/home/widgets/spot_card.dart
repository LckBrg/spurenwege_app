import 'package:flutter/material.dart';

import '../../../data/models/spot.dart';

class SpotCard extends StatelessWidget {
  final Spot spot;
  final VoidCallback onTap;

  const SpotCard({super.key, required this.spot, required this.onTap});

  String getImagePath() {
    switch (spot.title) {
      case 'Gasserplatz':
        return 'assets/images/spots/gasserplatz.jpg';
      case 'Schattenburg':
        return 'assets/images/spots/schattenburg.jpg';
      case 'Altstadt Bludenz':
        return 'assets/images/spots/bludenz.jpg';
      default:
        return 'assets/images/spots/bludenz.jpg';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 140,
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
            image: AssetImage(getImagePath()),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              colors: [
                Colors.black.withOpacity(0.60),
                Colors.black.withOpacity(0.20),
              ],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
            ),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                spot.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '${spot.city} • ${spot.category}',
                style: const TextStyle(color: Colors.white70, fontSize: 13),
              ),
              const SizedBox(height: 4),
              Text(
                spot.shortDescription,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: Colors.white70, fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
