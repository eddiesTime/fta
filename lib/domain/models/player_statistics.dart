import 'package:equatable/equatable.dart';

class PlayerStatistics extends Equatable {
  final String playerName;
  final int wins;
  final int scoredGoals;
  final int receivedGoals;

  const PlayerStatistics({
    required this.playerName,
    required this.wins,
    required this.scoredGoals,
    required this.receivedGoals,
  });

  String get goals => '${scoredGoals.toString()}:${receivedGoals.toString()}';
  String get winsStr => wins.toString();

  PlayerStatistics copyWith({
    String? playerName,
    int? wins,
    int? scoredGoals,
    int? receivedGoals,
  }) {
    return PlayerStatistics(
      playerName: playerName ?? this.playerName,
      wins: wins ?? this.wins,
      scoredGoals: scoredGoals ?? this.scoredGoals,
      receivedGoals: receivedGoals ?? this.receivedGoals,
    );
  }

  @override
  List<Object?> get props => [playerName, wins, scoredGoals, receivedGoals];
}
