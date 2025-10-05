import 'package:foosball_tournament_app/domain/interfaces/game_result_repository.dart';
import 'package:foosball_tournament_app/domain/models/game_result.dart';

/// This can be used to retrieve the game result data from a remote server.
/// The purpose of this repository is to show how the logic can be abstracted
/// so that the presentation layer does not need to be updated when the
/// source of the data changes and the domain layer only needs to update the
/// repository instantiation.
class RemoteApiGameResultsRepository implements GameResultRepository {
  // Add a service that communicates with the remote API and is used by this
  // repository for more abstraction.

  @override
  Future<void> deleteGameResult(GameResult result) {
    throw UnimplementedError();
  }

  @override
  Future<List<GameResult>> getAllGameResults() {
    throw UnimplementedError();
  }

  @override
  Future<GameResult> getGameResultFor(String resultId) {
    throw UnimplementedError();
  }

  @override
  Future<void> saveGameResult(GameResult result) {
    throw UnimplementedError();
  }

  @override
  Future<void> updateGameResult(GameResult result) {
    throw UnimplementedError();
  }
}
