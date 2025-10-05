import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:foosball_tournament_app/domain/interfaces/game_result_repository.dart';
import 'package:foosball_tournament_app/domain/models/game_result.dart';
import 'package:meta/meta.dart';

part 'game_results_list_state.dart';

class GameResultsListCubit extends Cubit<GameResultsListState> {
  final GameResultRepository resultRepository;

  GameResultsListCubit({required this.resultRepository})
    : super(GameResultsListInitial());

  // Not managed to implement in time :)
  // void openDetailsFor(GameResult result) {
  //   emit(GameResultsListOpenDetail(result: result));
  // }

  Future<void> loadResults() async {
    emit(GameResultsListLoading());

    try {
      final results = await resultRepository.getAllGameResults();
      emit(GameResultsListLoadingSuccess(results: results));
    } catch (_) {
      emit(
        GameResultsListLoadingError(
          errorStr: 'Failed loading all results. Try again later!',
        ),
      );
    }
  }

  Future<void> deleteResult(GameResult result) async {
    try {
      await resultRepository.deleteGameResult(result);
      emit(GameResultsListItemDeletionSuccess());
      loadResults();
    } catch (_) {
      emit(
        GameResultsListItemDeletionError(
          errorStr: 'Failed deletion of game result! Please try again!',
        ),
      );
    }
  }
}
