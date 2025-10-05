import 'package:flutter/material.dart';
import 'package:foosball_tournament_app/domain/models/game_result.dart';

class GameResultDetailPage extends StatelessWidget {
  final GameResult result;

  const GameResultDetailPage({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Game Details')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPlayerRow(
              result.player1Name,
              result.player1Goals,
              result.winner == result.player1Name,
            ),
            const SizedBox(height: 8),
            _buildPlayerRow(
              result.player2Name,
              result.player2Goals,
              result.winner == result.player2Name,
            ),
            const SizedBox(height: 16),
            Text(
              'Winner: ${result.winner}',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlayerRow(String name, int goals, bool isWinner) {
    return Row(
      children: [
        Expanded(child: Text(name, style: const TextStyle(fontSize: 16))),
        Text('Goals: $goals'),
        if (isWinner) ...[
          const SizedBox(width: 8),
          const Icon(Icons.emoji_events, color: Colors.amber),
        ],
      ],
    );
  }
}
