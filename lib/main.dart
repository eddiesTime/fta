import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foosball_tournament_app/data/shared_prefs_game_result_repository.dart';
import 'package:foosball_tournament_app/presentation/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // For simplification has been done here. Ideally use DI tool like get_it and
  // let it handle this.
  final sharedPrefs = await SharedPreferences.getInstance();
  final repository = SharedPrefsGameResultRepository(prefs: sharedPrefs);

  runApp(MyApp(repository: repository));
}

class MyApp extends StatelessWidget {
  final SharedPrefsGameResultRepository repository;

  const MyApp({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: repository,
      child: MaterialApp(
        title: 'Foosball Tournament Tracker',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: const HomePage(),
      ),
    );
  }
}
