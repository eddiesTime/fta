import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foosball_tournament_app/data/shared_prefs_game_result_repository.dart';
import 'package:foosball_tournament_app/domain/models/game_result.dart';
import 'package:foosball_tournament_app/presentation/add_or_edit_game_result/cubit/add_or_edit_game_result_cubit.dart';
import 'package:foosball_tournament_app/presentation/util/widgets/app_snack_bars.dart';

class AddOrEditGameResultPage extends StatelessWidget {
  final GameResult? initialGameResult;
  const AddOrEditGameResultPage({super.key, this.initialGameResult});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AddOrEditGameResultCubit(
        resultRepository: context.read<SharedPrefsGameResultRepository>(),
        result: initialGameResult,
      ),
      child: _AddOrEditGameResultView(),
    );
  }
}

class _AddOrEditGameResultView extends StatefulWidget {
  const _AddOrEditGameResultView();

  @override
  State<_AddOrEditGameResultView> createState() =>
      _AddOrEditGameResultViewState();
}

class _AddOrEditGameResultViewState extends State<_AddOrEditGameResultView> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController player1NameController;
  late final TextEditingController player2NameController;
  late final TextEditingController player1GoalsController;
  late final TextEditingController player2GoalsController;
  late final GameResult? initialGameResult;

  @override
  void initState() {
    super.initState();
    final cubit = context.read<AddOrEditGameResultCubit>();
    initialGameResult = cubit.state is AddOrEditGameResultInitial
        ? cubit.result
        : null;
    player1NameController = TextEditingController(
      text: initialGameResult?.player1Name ?? '',
    );
    player2NameController = TextEditingController(
      text: initialGameResult?.player2Name ?? '',
    );
    player1GoalsController = TextEditingController(
      text: initialGameResult?.player1GoalsStr ?? '',
    );
    player2GoalsController = TextEditingController(
      text: initialGameResult?.player2GoalsStr ?? '',
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

  void _onButtonTapped() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final cubit = context.read<AddOrEditGameResultCubit>();
    final result = GameResult(
      player1Name: player1NameController.text,
      player2Name: player2NameController.text,
      player1Goals: int.tryParse(player1GoalsController.text) ?? 0,
      player2Goals: int.tryParse(player2GoalsController.text) ?? 0,
    );

    if (initialGameResult == null) {
      cubit.addGameResult(result);
    } else {
      cubit.editGameResult(result);
    }
    FocusScope.of(context).unfocus();
  }

  void _clearFields() {
    player1NameController.text = '';
    player2NameController.text = '';
    player1GoalsController.text = '';
    player2GoalsController.text = '';
    _formKey.currentState?.reset();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddOrEditGameResultCubit, AddOrEditGameResultState>(
      listener: (context, state) {
        if (state is AddOrEditGameResultSuccess) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(AppSnackBars.success('Game saved successfully!'));
        } else if (state is AddOrEditGameResultError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(AppSnackBars.error('Error: ${state.errorStr}'));
        }
      },
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: player1NameController,
                  decoration: const InputDecoration(labelText: 'Player 1 Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Cannot be empty';
                    }
                    if (value == player2NameController.text) {
                      return 'It has to be two different players!';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: player2NameController,
                  decoration: const InputDecoration(labelText: 'Player 2 Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Cannot be empty';
                    }
                    if (value == player1NameController.text) {
                      return 'It has to be two different players!';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: player1GoalsController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Player 1 Goals',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Cannot be empty';
                    }

                    try {
                      final val = int.parse(value);
                      if (val < 0) {
                        return 'Negative score is not allowed!';
                      }
                      if (val == int.tryParse(player2GoalsController.text)) {
                        return 'Tie not allowed. There has to be a winner!';
                      }
                    } catch (e) {
                      return 'Value has to be integer';
                    }

                    return null;
                  },
                ),
                TextFormField(
                  controller: player2GoalsController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Player 2 Goals',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Cannot be empty';
                    }

                    try {
                      final val = int.parse(value);
                      if (val < 0) {
                        return 'Negative score is not allowed!';
                      }
                      if (val == int.tryParse(player1GoalsController.text)) {
                        return 'Tie not allowed. There has to be a winner!';
                      }
                    } catch (e) {
                      return 'Value has to be integer';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _onButtonTapped,
                  child: Text(initialGameResult == null ? 'Save' : 'Update'),
                ),
                ElevatedButton(onPressed: _clearFields, child: Text('Clear')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
