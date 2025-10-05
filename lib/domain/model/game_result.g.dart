// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GameResult _$GameResultFromJson(Map<String, dynamic> json) => GameResult(
  id: json['id'] as String?,
  player1Name: json['player1Name'] as String,
  player2Name: json['player2Name'] as String,
  player1Goals: (json['player1Goals'] as num).toInt(),
  player2Goals: (json['player2Goals'] as num).toInt(),
);

Map<String, dynamic> _$GameResultToJson(GameResult instance) =>
    <String, dynamic>{
      'id': instance.id,
      'player1Name': instance.player1Name,
      'player2Name': instance.player2Name,
      'player1Goals': instance.player1Goals,
      'player2Goals': instance.player2Goals,
    };
