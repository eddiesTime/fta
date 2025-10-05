import 'package:collection/collection.dart';

import 'package:foosball_tournament_app/domain/interfaces/leaderboard_calculation_service.dart';
import 'package:foosball_tournament_app/domain/models/game_result.dart';
import 'package:foosball_tournament_app/domain/models/player_statistics.dart';

class DefaultLeaderboardCalculationService
    implements LeaderboardCalculationService {
  List<GameResult> _cachedResults = [];
  List<PlayerStatistics> _cachedStatistics = [];
  final DeepCollectionEquality _deepEq = const DeepCollectionEquality();

  DefaultLeaderboardCalculationService();

  @override
  List<PlayerStatistics> calculateLeaderboard({
    required List<GameResult> gameResults,
  }) {
    if (_deepEq.equals(gameResults, _cachedResults)) {
      return _cachedStatistics;
    }

    final Map<String, PlayerStatistics> statsMap = {};

    for (final result in gameResults) {
      final p1 = result.player1Name;
      final p2 = result.player2Name;
      final p1Goals = result.player1Goals;
      final p2Goals = result.player2Goals;

      final p1Wins = p1Goals > p2Goals ? 1 : 0;
      final p2Wins = p2Goals > p1Goals ? 1 : 0;

      statsMap[p1] =
          (statsMap[p1] ??
                  const PlayerStatistics(
                    playerName: '',
                    wins: 0,
                    scoredGoals: 0,
                    receivedGoals: 0,
                  ))
              .copyWith(
                playerName: p1,
                wins: (statsMap[p1]?.wins ?? 0) + p1Wins,
                scoredGoals: (statsMap[p1]?.scoredGoals ?? 0) + p1Goals,
                receivedGoals: (statsMap[p1]?.receivedGoals ?? 0) + p2Goals,
              );

      statsMap[p2] =
          (statsMap[p2] ??
                  const PlayerStatistics(
                    playerName: '',
                    wins: 0,
                    scoredGoals: 0,
                    receivedGoals: 0,
                  ))
              .copyWith(
                playerName: p2,
                wins: (statsMap[p2]?.wins ?? 0) + p2Wins,
                scoredGoals: (statsMap[p2]?.scoredGoals ?? 0) + p2Goals,
                receivedGoals: (statsMap[p2]?.receivedGoals ?? 0) + p1Goals,
              );
    }

    final calculated = statsMap.values.toList()
      ..sort((a, b) {
        final winComparison = b.wins.compareTo(a.wins);
        if (winComparison != 0) return winComparison;
        return a.playerName.toLowerCase().compareTo(b.playerName.toLowerCase());
      });

    _cachedResults = List.unmodifiable(gameResults);
    _cachedStatistics = List.unmodifiable(calculated);

    return _cachedStatistics;
  }
}
