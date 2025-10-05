import 'package:flutter/material.dart';
import 'package:foosball_tournament_app/presentation/add_or_edit_game_result/add_or_edit_game_result_page.dart';
import 'package:foosball_tournament_app/presentation/game_results_list/game_results_list_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    AddOrEditGameResultPage(),
    GameResultsListPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_selectedIndex == 0 ? 'Add Game' : 'Results')),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Add Game'),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Results'),
        ],
      ),
    );
  }
}
