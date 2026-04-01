import '../models/spot.dart';

class FavoritesRepository {
  static final FavoritesRepository _instance = FavoritesRepository._internal();

  factory FavoritesRepository() => _instance;

  FavoritesRepository._internal();

  final List<Spot> _favorites = [];

  List<Spot> getFavorites() {
    return List.unmodifiable(_favorites);
  }

  bool isFavorite(Spot spot) {
    return _favorites.any((s) => s.id == spot.id);
  }

  void toggleFavorite(Spot spot) {
    if (isFavorite(spot)) {
      _favorites.removeWhere((s) => s.id == spot.id);
    } else {
      _favorites.add(spot);
    }
  }
}
