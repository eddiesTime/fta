import 'package:flutter/material.dart';
import 'package:foosball_tournament_app/domain/model/game_result.dart';

class AddOrEditGameResultPage extends StatefulWidget {
  const AddOrEditGameResultPage({super.key, this.gameResult});

  final GameResult? gameResult;

  @override
  State<AddOrEditGameResultPage> createState() =>
      _AddOrEditGameResultPageState();
}

class _AddOrEditGameResultPageState extends State<AddOrEditGameResultPage> {
  late final TextEditingController player1NameController;
  late final TextEditingController player2NameController;
  late final TextEditingController player1GoalsController;
  late final TextEditingController player2GoalsController;

  @override
  void initState() {
    super.initState();
    player1NameController = TextEditingController(
      text: widget.gameResult?.player1Name ?? '',
    );
    player2NameController = TextEditingController(
      text: widget.gameResult?.player2Name ?? '',
    );
    player1GoalsController = TextEditingController(
      text: widget.gameResult?.player1GoalsStr ?? '',
    );
    player2GoalsController = TextEditingController(
      text: widget.gameResult?.player2GoalsStr ?? '',
    );
  }

  @override
  void dispose() {
    player1NameController.dispose();
    player2NameController.dispose();
    player1GoalsController.dispose();
    player2GoalsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: player1NameController,
            decoration: const InputDecoration(labelText: 'Player 1 Name'),
          ),
          TextField(
            controller: player2NameController,
            decoration: const InputDecoration(labelText: 'Player 2 Name'),
          ),
          TextField(
            controller: player1GoalsController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Player 1 Goals'),
          ),
          TextField(
            controller: player2GoalsController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Player 2 Goals'),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              print('Pressed save');
              FocusScope.of(context).unfocus();
            },
            child: Text(widget.gameResult == null ? 'Save' : 'Update'),
          ),
        ],
      ),
    );
  }
}
