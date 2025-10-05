import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foosball_tournament_app/domain/models/game_result.dart';
import 'package:foosball_tournament_app/data/shared_prefs_game_result_repository.dart';
import 'package:foosball_tournament_app/presentation/add_or_edit_game_result/cubit/add_or_edit_game_result_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  late SharedPrefsGameResultRepository repository;
  late AddOrEditGameResultCubit cubit;
  late GameResult initialGameResult;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    repository = SharedPrefsGameResultRepository(prefs: prefs);
    cubit = AddOrEditGameResultCubit(resultRepository: repository);
    initialGameResult = GameResult(
      player1Name: 'Peter',
      player2Name: 'Tony',
      player1Goals: 7,
      player2Goals: 2,
    );
  });

  group('AddOrEditGameResultCubit', () {
    blocTest<AddOrEditGameResultCubit, AddOrEditGameResultState>(
      'emits [InProgress, Success] when saving a new game',
      build: () => cubit,
      act: (cubit) => cubit.addGameResult(
        GameResult(
          player1Name: 'Peter',
          player2Name: 'Tony',
          player1Goals: 7,
          player2Goals: 2,
        ),
      ),
      expect: () => [
        const AddOrEditGameResultInProgress(),
        isA<AddOrEditGameResultSuccess>(),
      ],
    );

    blocTest<AddOrEditGameResultCubit, AddOrEditGameResultState>(
      'emits [InProgress, Success] when updating a game',
      setUp: () async => await repository.saveGameResult(initialGameResult),
      build: () {
        return AddOrEditGameResultCubit(
          resultRepository: repository,
          result: initialGameResult,
        );
      },
      seed: () => AddOrEditGameResultInitial(result: initialGameResult),

      act: (cubit) {
        final result = (cubit.state as AddOrEditGameResultInitial).result!;
        final updateResult = result.copyWith(
          player1Name: 'Parker',
          player2Name: 'Stark',
          player2Goals: 4,
        );
        return cubit.editGameResult(updateResult);
      },
      expect: () => [
        const AddOrEditGameResultInProgress(),
        isA<AddOrEditGameResultSuccess>()
            .having((s) => s.result.player1Name, 'player1Name', 'Parker')
            .having((s) => s.result.player2Name, 'player2Name', 'Stark')
            .having((s) => s.result.player1Goals, 'player1Goals', 7)
            .having((s) => s.result.player2Goals, 'player2Goals', 4),
      ],
    );
  });
}
