import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:foosball_tournament_app/domain/interfaces/leaderboard_calculation_service.dart';
import 'package:foosball_tournament_app/domain/models/game_result.dart';
import 'package:foosball_tournament_app/domain/models/player_statistics.dart';

part 'leader_board_state.dart';

class LeaderBoardCubit extends Cubit<LeaderBoardState> {
  final LeaderboardCalculationService leaderboardCalculationService;
  LeaderBoardCubit({required this.leaderboardCalculationService})
    : super(LeaderBoardInitial());

  void loadLeaderBoard(List<GameResult> gameResults) {
    emit(LeaderBoardIsLoading());

    final leaderboard = leaderboardCalculationService.calculateLeaderboard(
      gameResults: gameResults,
    );
    emit(LeaderBoardLoaded(leaderboard: leaderboard));
  }
}
