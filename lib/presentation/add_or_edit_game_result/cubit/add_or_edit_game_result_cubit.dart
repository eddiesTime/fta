import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:foosball_tournament_app/domain/interfaces/game_result_repository.dart';
import 'package:foosball_tournament_app/domain/models/game_result.dart';
import 'package:meta/meta.dart';

part 'add_or_edit_game_result_state.dart';

class AddOrEditGameResultCubit extends Cubit<AddOrEditGameResultState> {
  final GameResultRepository resultRepository;
  final GameResult? result;

  AddOrEditGameResultCubit({required this.resultRepository, this.result})
    : super(AddOrEditGameResultInitial(result: result));

  Future<void> addGameResult(GameResult result) async {
    emit(AddOrEditGameResultInProgress());

    try {
      await resultRepository.saveGameResult(result);
      emit(AddOrEditGameResultSuccess(result: result));
    } catch (_) {
      emit(
        AddOrEditGameResultError(
          errorStr: 'Failed to save the game result! Please try again',
        ),
      );
    }
  }

  Future<void> editGameResult(GameResult result) async {
    emit(AddOrEditGameResultInProgress());

    try {
      await resultRepository.updateGameResult(result);
      emit(AddOrEditGameResultSuccess(result: result));
    } catch (_) {
      emit(
        AddOrEditGameResultError(
          errorStr: 'Failed to save the game result! Please try again',
        ),
      );
    }
  }
}
