import 'package:foosball_tournament_app/domain/models/game_result.dart';

abstract class GameResultRepository {
  Future<GameResult> getGameResultFor(String resultId);
  Future<List<GameResult>> getAllGameResults();
  Future<void> saveGameResult(GameResult result);
  Future<void> updateGameResult(GameResult result);
  Future<void> deleteGameResult(GameResult result);
}
