import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:foosball_tournament_app/data/shared_prefs_game_result_repository.dart';
import 'package:foosball_tournament_app/domain/model/game_result.dart';

void main() {
  late SharedPrefsGameResultRepository repository;
  late SharedPreferences prefs;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    prefs = await SharedPreferences.getInstance();
    repository = SharedPrefsGameResultRepository(prefs: prefs);
  });

  test('initially returns empty list', () async {
    final results = await repository.getAllGameResults();
    expect(results, isEmpty);
  });

  test('can save a GameResult', () async {
    final result = GameResult(
      player1Name: 'Spiderman',
      player2Name: 'Ironman',
      player1Goals: 3,
      player2Goals: 2,
    );

    await repository.saveGameResult(result);
    final results = await repository.getAllGameResults();
    expect(results.length, 1);
    expect(results.first.player1Name, 'Spiderman');
  });

  test('can update a GameResult', () async {
    final result = GameResult(
      player1Name: 'Hulk',
      player2Name: 'Thor',
      player1Goals: 3,
      player2Goals: 2,
    );
    await repository.saveGameResult(result);

    final updated = GameResult(
      id: result.id,
      player1Name: 'Hulk Updated',
      player2Name: 'Thor',
      player1Goals: 4,
      player2Goals: 2,
    );

    await repository.updateGameResult(updated);
    final results = await repository.getAllGameResults();
    expect(results.first.player1Name, 'Hulk Updated');
    expect(results.first.player1Goals, 4);
  });

  test('can delete a GameResult', () async {
    final result = GameResult(
      player1Name: 'Loki',
      player2Name: 'Thor',
      player1Goals: 3,
      player2Goals: 2,
    );
    await repository.saveGameResult(result);
    await repository.deleteGameResult(result);

    final results = await repository.getAllGameResults();
    expect(results, isEmpty);
  });
}
