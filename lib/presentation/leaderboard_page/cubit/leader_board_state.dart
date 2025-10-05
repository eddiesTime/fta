part of 'leader_board_cubit.dart';

sealed class LeaderBoardState extends Equatable {
  const LeaderBoardState();

  @override
  List<Object> get props => [];
}

final class LeaderBoardInitial extends LeaderBoardState {}

final class LeaderBoardIsLoading extends LeaderBoardState {}

final class LeaderBoardLoaded extends LeaderBoardState {
  final List<PlayerStatistics> leaderboard;
  const LeaderBoardLoaded({required this.leaderboard});

  @override
  List<Object> get props => [leaderboard];
}
