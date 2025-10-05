import 'package:flutter/material.dart';
import 'package:foosball_tournament_app/domain/models/game_result.dart';
import 'package:foosball_tournament_app/presentation/add_or_edit_game_result/add_or_edit_game_result_page.dart';

class GameResultDetailPage extends StatefulWidget {
  final GameResult result;

  const GameResultDetailPage({super.key, required this.result});

  @override
  State<GameResultDetailPage> createState() => _GameResultDetailPageState();
}

class _GameResultDetailPageState extends State<GameResultDetailPage> {
  bool _editMode = false;
  void _toggleEditMode() {
    setState(() {
      _editMode = !_editMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Game Details'),
        actions: [
          IconButton(onPressed: _toggleEditMode, icon: Icon(Icons.edit)),
        ],
      ),
      body: AddOrEditGameResultPage(
        initialGameResult: widget.result,
        isEditMode: _editMode,
      ),
    );
  }
}
