import 'dart:convert';

import 'package:foosball_tournament_app/domain/interfaces/game_result_repository.dart';
import 'package:foosball_tournament_app/domain/models/game_result.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsGameResultRepository implements GameResultRepository {
  static const _key = 'game_results';
  final SharedPreferences prefs;

  List<GameResult>? _cachedResults;

  SharedPrefsGameResultRepository({required this.prefs});

  // MARK: Repository interface implementation

  @override
  Future<void> deleteGameResult(GameResult result) async {
    final results = await getAllGameResults();
    results.removeWhere((r) => r.id == result.id);
    await _persistAndRefreshCache(results);
  }

  @override
  Future<List<GameResult>> getAllGameResults() async {
    if (_cachedResults != null) return _cachedResults!;

    final jsonGameResultsStr = prefs.getString(_key);
    if (jsonGameResultsStr == null) {
      _cachedResults = [];
      return _cachedResults!;
    }

    final List<dynamic> jsonGameResults = jsonDecode(jsonGameResultsStr);
    _cachedResults = jsonGameResults
        .map((e) => GameResult.fromJson(e))
        .toList();
    return _cachedResults!;
  }

  @override
  Future<GameResult> getGameResultFor(String resultId) async {
    final results = await getAllGameResults();
    final result = results.firstWhere(
      (r) => r.id == resultId,
      orElse: () => throw Exception('GameResult with id $resultId not found'),
    );
    return result;
  }

  @override
  Future<void> saveGameResult(GameResult result) async {
    final results = await getAllGameResults();
    results.add(result);
    await _persistAndRefreshCache(results);
  }

  @override
  Future<void> updateGameResult(GameResult result) async {
    final results = await getAllGameResults();
    final index = results.indexWhere((r) => r.id == result.id);
    if (index == -1) throw Exception('GameResult not found for update');
    results[index] = result;
    await _persistAndRefreshCache(results);
  }

  // MARK: Helper

  Future<void> _persistAndRefreshCache(List<GameResult> results) async {
    final resultsJson = results.map((r) => r.toJson()).toList();
    await prefs.setString(_key, jsonEncode(resultsJson));

    _cachedResults = List<GameResult>.from(results);
  }
}
