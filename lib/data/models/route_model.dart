import 'spot.dart';
import 'route_step_model.dart';

enum RouteTier {
  teaser,
  standard,
  premium,
}

class RouteModel {
  final String id;
  final String title;
  final String city;
  final String shortDescription;
  final String longDescription;
  final String durationLabel;
  final String difficulty;
  final String focus;
  final bool isPremium;
  final String startImage;
  final RouteTier tier;
  final String mood;
  final List<RouteStepModel> steps;

  // Für Kompatibilität mit älteren Screens
  final List<Spot> spots;

  const RouteModel({
    required this.id,
    required this.title,
    required this.city,
    required this.shortDescription,
    required this.longDescription,
    required this.durationLabel,
    required this.difficulty,
    required this.focus,
    required this.isPremium,
    required this.startImage,
    required this.tier,
    required this.mood,
    required this.steps,
    this.spots = const [],
  });

  int get stepCount => steps.length;

  // Für ältere Screens wie routes_screen.dart
  int get spotCount => steps.length;

  String get tierLabel {
    switch (tier) {
      case RouteTier.teaser:
        return 'Teaser';
      case RouteTier.standard:
        return 'Standard';
      case RouteTier.premium:
        return 'Premium';
    }
  }

  bool matchesQuery(String query) {
    final q = query.trim().toLowerCase();

    if (q.isEmpty) {
      return true;
    }

    return title.toLowerCase().contains(q) ||
        city.toLowerCase().contains(q) ||
        focus.toLowerCase().contains(q) ||
        difficulty.toLowerCase().contains(q) ||
        mood.toLowerCase().contains(q) ||
        durationLabel.toLowerCase().contains(q) ||
        shortDescription.toLowerCase().contains(q);
  }
}