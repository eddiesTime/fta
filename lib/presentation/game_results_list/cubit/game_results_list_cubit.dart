import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:foosball_tournament_app/domain/interface/game_result_repository.dart';
import 'package:foosball_tournament_app/domain/model/game_result.dart';
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
}
