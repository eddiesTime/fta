import 'package:foosball_tournament_app/domain/models/game_result.dart';
import 'package:foosball_tournament_app/domain/models/player_statistics.dart';

abstract class LeaderboardCalculationService {
  List<PlayerStatistics> calculateLeaderboard({
    required List<GameResult> gameResults,
  });
}
