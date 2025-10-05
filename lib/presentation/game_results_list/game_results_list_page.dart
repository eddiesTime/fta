import 'package:flutter/material.dart';
import 'package:foosball_tournament_app/domain/model/game_result.dart';

class GameResultsListPage extends StatelessWidget {
  const GameResultsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: mockGameResults.length,
      itemBuilder: (context, index) =>
          GameResultsListItem(result: mockGameResults[index]),
    );
  }
}

class GameResultsListItem extends StatelessWidget {
  const GameResultsListItem({super.key, required this.result});
  final GameResult result;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    result.player1Name,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  result.winner == result.player1Name
                      ? Icon(Icons.emoji_events)
                      : SizedBox(),
                ],
              ),
            ),
            SizedBox(width: 4),
            Text('vs', style: TextStyle(fontWeight: FontWeight.w500)),
            SizedBox(width: 4),
            Expanded(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    result.player2Name,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.end,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  result.winner == result.player2Name
                      ? Icon(Icons.emoji_events)
                      : SizedBox(),
                ],
              ),
            ),
          ],
        ),
        onTap: () => print('pressed result ${result.player1Name}'),
      ),
    );
  }
}

final List<GameResult> mockGameResults = [
  GameResult(
    player1Name: 'Alice',
    player2Name: 'Bob',
    player1Goals: 5,
    player2Goals: 3,
  ),
  GameResult(
    player1Name: 'Charlie',
    player2Name: 'David',
    player1Goals: 2,
    player2Goals: 2,
  ),
  GameResult(
    player1Name: 'Eve',
    player2Name: 'Frank',
    player1Goals: 4,
    player2Goals: 6,
  ),
  GameResult(
    player1Name: 'Grace',
    player2Name: 'Heidi',
    player1Goals: 3,
    player2Goals: 1,
  ),
  GameResult(
    player1Name: 'Ivan',
    player2Name: 'Judy',
    player1Goals: 0,
    player2Goals: 3,
  ),
  GameResult(
    player1Name: 'Mallory',
    player2Name: 'Niaj',
    player1Goals: 2,
    player2Goals: 5,
  ),
  GameResult(
    player1Name: 'Olivia',
    player2Name: 'Peggy',
    player1Goals: 6,
    player2Goals: 4,
  ),
  GameResult(
    player1Name: 'Quentin',
    player2Name: 'Rupert',
    player1Goals: 3,
    player2Goals: 3,
  ),
  GameResult(
    player1Name: 'Sybil',
    player2Name: 'Trent',
    player1Goals: 1,
    player2Goals: 2,
  ),
  GameResult(
    player1Name: 'Uma',
    player2Name: 'Victor',
    player1Goals: 4,
    player2Goals: 4,
  ),
  GameResult(
    player1Name: 'Wendy',
    player2Name: 'Xavier',
    player1Goals: 5,
    player2Goals: 2,
  ),
  GameResult(
    player1Name: 'Yasmine',
    player2Name: 'Zach',
    player1Goals: 3,
    player2Goals: 1,
  ),
  GameResult(
    player1Name: 'Alice',
    player2Name: 'Charlie',
    player1Goals: 2,
    player2Goals: 0,
  ),
  GameResult(
    player1Name: 'Bob',
    player2Name: 'David',
    player1Goals: 1,
    player2Goals: 3,
  ),
  GameResult(
    player1Name: 'Eve',
    player2Name: 'Grace',
    player1Goals: 4,
    player2Goals: 5,
  ),
  GameResult(
    player1Name: 'Heidi',
    player2Name: 'Ivan',
    player1Goals: 0,
    player2Goals: 1,
  ),
  GameResult(
    player1Name: 'Judy',
    player2Name: 'Mallory',
    player1Goals: 2,
    player2Goals: 2,
  ),
  GameResult(
    player1Name: 'Niaj',
    player2Name: 'Olivia',
    player1Goals: 5,
    player2Goals: 4,
  ),
  GameResult(
    player1Name: 'Peggy',
    player2Name: 'Quentin',
    player1Goals: 3,
    player2Goals: 6,
  ),
  GameResult(
    player1Name: 'Rupert',
    player2Name: 'Sybil',
    player1Goals: 4,
    player2Goals: 3,
  ),
];
