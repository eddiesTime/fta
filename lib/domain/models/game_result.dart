import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

part 'game_result.g.dart';

@JsonSerializable()
class GameResult extends Equatable {
  final String id;
  final String player1Name;
  final String player2Name;
  final int player1Goals;
  final int player2Goals;

  String get winner {
    return player1Goals > player2Goals ? player1Name : player2Name;
  }

  String get player1GoalsStr => player1Goals.toString();
  String get player2GoalsStr => player2Goals.toString();

  GameResult({
    String? id,
    required this.player1Name,
    required this.player2Name,
    required this.player1Goals,
    required this.player2Goals,
  }) : id = id ?? const Uuid().v4();

  factory GameResult.fromJson(Map<String, dynamic> json) =>
      _$GameResultFromJson(json);

  Map<String, dynamic> toJson() => _$GameResultToJson(this);

  GameResult copyWith({
    String? id,
    String? player1Name,
    String? player2Name,
    int? player1Goals,
    int? player2Goals,
  }) {
    return GameResult(
      id: id ?? this.id,
      player1Name: player1Name ?? this.player1Name,
      player2Name: player2Name ?? this.player2Name,
      player1Goals: player1Goals ?? this.player1Goals,
      player2Goals: player2Goals ?? this.player2Goals,
    );
  }

  @override
  List<Object?> get props => [
    id,
    player1Name,
    player2Name,
    player1Goals,
    player2Goals,
  ];
}
