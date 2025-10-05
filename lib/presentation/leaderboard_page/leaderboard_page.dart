import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foosball_tournament_app/data/shared_prefs_game_result_repository.dart';
import 'package:foosball_tournament_app/domain/services/leaderboard_calculation_service.dart';
import 'package:foosball_tournament_app/presentation/game_results_list/cubit/game_results_list_cubit.dart';
import 'package:foosball_tournament_app/presentation/leaderboard_page/cubit/leader_board_cubit.dart';

class LeaderboardPage extends StatelessWidget {
  const LeaderboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => GameResultsListCubit(
            resultRepository: context.read<SharedPrefsGameResultRepository>(),
          )..loadResults(),
        ),
        BlocProvider(
          create: (_) => LeaderBoardCubit(
            leaderboardCalculationService:
                DefaultLeaderboardCalculationService(),
          ),
        ),
      ],
      child: _LeaderboardView(),
    );
  }
}

class _LeaderboardView extends StatelessWidget {
  const _LeaderboardView();

  @override
  Widget build(BuildContext context) {
    return BlocListener<GameResultsListCubit, GameResultsListState>(
      listener: (context, state) {
        if (state is GameResultsListLoadingSuccess) {
          context.read<LeaderBoardCubit>().loadLeaderBoard(state.results);
        }
      },
      child: BlocBuilder<LeaderBoardCubit, LeaderBoardState>(
        builder: (context, state) {
          if (state is LeaderBoardIsLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is LeaderBoardLoaded) {
            if (state.leaderboard.isEmpty) {
              return Center(
                child: Text(
                  'There are no game results for a leaderboard. Add games first!',
                ),
              );
            }
            return ListView.builder(
              itemCount: state.leaderboard.length,
              itemBuilder: (context, index) {
                final player = state.leaderboard[index];
                return Card(
                  child: ListTile(
                    leading: Text('${index + 1}'),
                    title: Text(player.playerName),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('W'),
                            SizedBox(height: 4),
                            Text(player.winsStr),
                          ],
                        ),
                        SizedBox(width: 4),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('T'),
                            SizedBox(height: 4),
                            Text(player.goals),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
          return Center(child: SizedBox());
        },
      ),
    );
  }
}
