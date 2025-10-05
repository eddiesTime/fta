part of 'add_or_edit_game_result_cubit.dart';

@immutable
sealed class AddOrEditGameResultState extends Equatable {
  const AddOrEditGameResultState();

  @override
  List<Object?> get props => [];
}

final class AddOrEditGameResultInitial extends AddOrEditGameResultState {
  final GameResult? result;
  const AddOrEditGameResultInitial({this.result});

  @override
  List<Object?> get props => [result];
}

final class AddOrEditGameResultInProgress extends AddOrEditGameResultState {
  const AddOrEditGameResultInProgress();
}

final class AddOrEditGameResultError extends AddOrEditGameResultState {
  final String errorStr;
  const AddOrEditGameResultError({required this.errorStr});

  @override
  List<Object?> get props => [errorStr];
}

final class AddOrEditGameResultSuccess extends AddOrEditGameResultState {
  final GameResult result;

  const AddOrEditGameResultSuccess({required this.result});

  @override
  List<Object?> get props => [result];
}
