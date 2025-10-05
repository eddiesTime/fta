part of 'game_results_list_cubit.dart';

@immutable
sealed class GameResultsListState extends Equatable {
  const GameResultsListState();

  @override
  List<Object?> get props => [];
}

final class GameResultsListInitial extends GameResultsListState {
  const GameResultsListInitial();

  @override
  List<Object?> get props => [];
}

final class GameResultsListLoading extends GameResultsListState {
  const GameResultsListLoading();

  @override
  List<Object?> get props => [];
}

final class GameResultsListLoadingSuccess extends GameResultsListState {
  const GameResultsListLoadingSuccess({required this.results});
  final List<GameResult> results;

  @override
  List<Object?> get props => [results];
}

final class GameResultsListLoadingError extends GameResultsListState {
  const GameResultsListLoadingError({required this.errorStr});
  final String errorStr;

  @override
  List<Object?> get props => [errorStr];
}
