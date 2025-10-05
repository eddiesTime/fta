import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foosball_tournament_app/data/shared_prefs_game_result_repository.dart';
import 'package:foosball_tournament_app/domain/model/game_result.dart';
import 'package:foosball_tournament_app/presentation/add_or_edit_game_result/add_or_edit_game_result_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  late SharedPrefsGameResultRepository repository;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    repository = SharedPrefsGameResultRepository(prefs: prefs);
  });

  Widget wrapWithProviders(Widget child) {
    return MaterialApp(
      home: RepositoryProvider.value(
        value: repository,
        child: Scaffold(body: child),
      ),
    );
  }

  group('AddOrEditGameResultPage', () {
    testWidgets('renders all text fields and buttons', (tester) async {
      await tester.pumpWidget(
        wrapWithProviders(const AddOrEditGameResultPage()),
      );
      await tester.pumpAndSettle();

      expect(find.byType(TextField), findsNWidgets(4));
      expect(find.text('Save'), findsOneWidget);
      expect(find.text('Clear'), findsOneWidget);
    });

    testWidgets('can enter text and save a new game', (tester) async {
      await tester.pumpWidget(
        wrapWithProviders(const AddOrEditGameResultPage()),
      );
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField).at(0), 'Tony');
      await tester.enterText(find.byType(TextField).at(1), 'Peter');
      await tester.enterText(find.byType(TextField).at(2), '9');
      await tester.enterText(find.byType(TextField).at(3), '0');

      await tester.tap(find.text('Save'));
      await tester.pumpAndSettle();

      expect(find.byType(SnackBar), findsOneWidget);
      expect(find.text('Game saved successfully!'), findsOneWidget);
    });

    testWidgets('clear button empties all text fields', (tester) async {
      await tester.pumpWidget(
        wrapWithProviders(const AddOrEditGameResultPage()),
      );
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField).at(0), 'Stephen');
      await tester.enterText(find.byType(TextField).at(1), 'Wong');
      await tester.enterText(find.byType(TextField).at(2), '10');
      await tester.enterText(find.byType(TextField).at(3), '1');

      await tester.tap(find.text('Clear'));
      await tester.pumpAndSettle();

      expect(find.text('Stephen'), findsNothing);
      expect(find.text('Wong'), findsNothing);
      expect(find.text('10'), findsNothing);
      expect(find.text('1'), findsNothing);
    });

    testWidgets('renders in edit mode with initial GameResult', (tester) async {
      final game = GameResult(
        player1Name: 'Steve',
        player2Name: 'Bucky',
        player1Goals: 8,
        player2Goals: 7,
      );

      await tester.pumpWidget(
        wrapWithProviders(AddOrEditGameResultPage(initialGameResult: game)),
      );
      await tester.pumpAndSettle();

      expect(find.widgetWithText(TextField, 'Steve'), findsOneWidget);
      expect(find.widgetWithText(TextField, 'Bucky'), findsOneWidget);
      expect(find.widgetWithText(TextField, '8'), findsOneWidget);
      expect(find.widgetWithText(TextField, '7'), findsOneWidget);

      expect(find.text('Update'), findsOneWidget);
    });
  });
}
