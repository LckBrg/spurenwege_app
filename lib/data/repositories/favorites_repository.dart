import '../models/spot.dart';

class FavoritesRepository {
  static final FavoritesRepository _instance = FavoritesRepository._internal();

  factory FavoritesRepository() => _instance;

  FavoritesRepository._internal();

  final List<Spot> _favoriteSpots = [];
  final List<String> _favoriteRouteIds = [];

  // ----------------------------
  // Spot-Favoriten (alte Screens)
  // ----------------------------
  List<Spot> getFavorites() {
    return List.unmodifiable(_favoriteSpots);
  }

  bool isFavorite(Spot spot) {
    return _favoriteSpots.any((s) => s.id == spot.id);
  }

  void toggleFavorite(Spot spot) {
    if (isFavorite(spot)) {
      _favoriteSpots.removeWhere((s) => s.id == spot.id);
    } else {
      _favoriteSpots.add(spot);
    }
  }

  // ----------------------------
  // Routen-Favoriten (neuer Homescreen)
  // ----------------------------
  List<String> getFavoriteRouteIds() {
    return List.unmodifiable(_favoriteRouteIds);
  }

  bool isRouteFavorite(String routeId) {
    return _favoriteRouteIds.contains(routeId);
  }

  void toggleRouteFavorite(String routeId) {
    if (isRouteFavorite(routeId)) {
      _favoriteRouteIds.remove(routeId);
    } else {
      _favoriteRouteIds.add(routeId);
    }
  }
}