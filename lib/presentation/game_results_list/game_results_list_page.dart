import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foosball_tournament_app/data/shared_prefs_game_result_repository.dart';
import 'package:foosball_tournament_app/domain/models/game_result.dart';
import 'package:foosball_tournament_app/presentation/game_results_list/cubit/game_results_list_cubit.dart';
import 'package:foosball_tournament_app/presentation/game_results_list/game_result_detail/game_result_detail_page.dart';
import 'package:foosball_tournament_app/presentation/util/widgets/app_snack_bars.dart';

class GameResultsListPage extends StatelessWidget {
  const GameResultsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GameResultsListCubit(
        resultRepository: context.read<SharedPrefsGameResultRepository>(),
      )..loadResults(), // immediately load results
      child: const _GameResultsListView(),
    );
  }
}

class _GameResultsListView extends StatelessWidget {
  const _GameResultsListView();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GameResultsListCubit, GameResultsListState>(
      listener: (context, state) async {
        if (state is GameResultsListLoadingError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(AppSnackBars.error('Error: ${state.errorStr}'));
        } else if (state is GameResultsListItemDeletionSuccess) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(AppSnackBars.success('Successfully deleted result!'));
        } else if (state is GameResultsListLoadingError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(AppSnackBars.error('Error: ${state.errorStr}'));
        }
      },
      builder: (context, state) {
        if (state is GameResultsListLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is GameResultsListLoadingSuccess) {
          if (state.results.isEmpty) {
            return Center(
              child: Text('No results yet. Please add games first!'),
            );
          }
          return ListView.builder(
            itemCount: state.results.length,
            itemBuilder: (context, index) =>
                GameResultsListItem(result: state.results[index]),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}

class GameResultsListItem extends StatelessWidget {
  const GameResultsListItem({super.key, required this.result});
  final GameResult result;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(result.id),
      background: Container(color: Colors.redAccent, child: Icon(Icons.delete)),
      onDismissed: (_) =>
          context.read<GameResultsListCubit>().deleteResult(result),
      child: Card(
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
                        ? Icon(Icons.emoji_events, color: Colors.amber)
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
                        ? Icon(Icons.emoji_events, color: Colors.amber)
                        : SizedBox(),
                  ],
                ),
              ),
            ],
          ),
          onTap: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => GameResultDetailPage(result: result),
              ),
            );
            BlocProvider.of<GameResultsListCubit>(context).loadResults();
          },
        ),
      ),
    );
  }
}
