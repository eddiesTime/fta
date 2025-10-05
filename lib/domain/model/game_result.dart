import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

part 'game_result.g.dart';

@JsonSerializable()
class GameResult {
  final String id;
  final String player1Name;
  final String player2Name;
  final int player1Goals;
  final int player2Goals;

  String get winner {
    return player1Goals > player2Goals ? player1Name : player2Name;
  }

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
}
