import 'package:shared_preferences/shared_preferences.dart';

class RouteProgressRepository {
  static const String _progressPrefix = 'route_progress_';
  static const String _completedPrefix = 'route_completed_';
  static const String _startedPrefix = 'route_started_';
  static const String _solvedPrefix = 'route_solved_';

  Future<int> getSavedIndex(String routeId) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('$_progressPrefix$routeId') ?? 0;
  }

  Future<void> saveIndex(String routeId, int index) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('$_progressPrefix$routeId', index);
  }

  Future<bool> isCompleted(String routeId) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('$_completedPrefix$routeId') ?? false;
  }

  Future<void> setCompleted(String routeId, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('$_completedPrefix$routeId', value);
  }

  Future<bool> isStarted(String routeId) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('$_startedPrefix$routeId') ?? false;
  }

  Future<void> setStarted(String routeId, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('$_startedPrefix$routeId', value);
  }

  Future<List<int>> getSolvedStations(String routeId) async {
    final prefs = await SharedPreferences.getInstance();
    final values = prefs.getStringList('$_solvedPrefix$routeId') ?? [];
    return values
        .map(int.tryParse)
        .whereType<int>()
        .toList()
      ..sort();
  }

  Future<bool> isStationSolved(String routeId, int stationIndex) async {
    final solved = await getSolvedStations(routeId);
    return solved.contains(stationIndex);
  }

  Future<void> markStationSolved(String routeId, int stationIndex) async {
    final prefs = await SharedPreferences.getInstance();
    final solved = await getSolvedStations(routeId);

    if (!solved.contains(stationIndex)) {
      solved.add(stationIndex);
      solved.sort();
    }

    await prefs.setStringList(
      '$_solvedPrefix$routeId',
      solved.map((e) => e.toString()).toList(),
    );
  }

  Future<void> resetSolvedStations(String routeId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('$_solvedPrefix$routeId');
  }

  Future<void> resetRoute(String routeId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('$_progressPrefix$routeId');
    await prefs.remove('$_completedPrefix$routeId');
    await prefs.remove('$_startedPrefix$routeId');
    await prefs.remove('$_solvedPrefix$routeId');
  }
}