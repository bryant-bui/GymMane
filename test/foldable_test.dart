import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gymmane/app/gymmane_app.dart';
import 'package:gymmane/catalog/program_templates.dart';
import 'package:gymmane/l10n/l10n.dart';
import 'package:gymmane/screens/routines_screen.dart';
import 'package:gymmane/services/local_store.dart';
import 'package:gymmane/state/fit_state.dart';
import 'package:gymmane/widgets/routine_folder.dart';
import 'package:gymmane/widgets/ui_kit.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await Store.instance.init();
    fit.resetAllData();
    fit.onboarded = true;
    setAppLanguage('en');
  });

  tearDown(() {
    if (fit.session != null) {
      fit.saveAndExit();
    }
    fit.resetAllData();
  });

  testWidgets(
    'Z Fold 3 Cover (280x653): bottom taskbar icons stay inside pill and switch tabs cleanly',
    (WidgetTester tester) async {
      tester.view.physicalSize = const Size(280, 653);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.reset);

      fit.applyTemplate(kProgramTemplates.first);
      fit.route = 'home';

      await tester.pumpWidget(const GymManeApp());
      await tester.pump(const Duration(milliseconds: 500));
      final firstErr = tester.takeException();
      expect(firstErr, isNull, reason: 'Initial 280px frame error: $firstErr');

      final barFinder = find.byWidgetPredicate(
        (w) => w.runtimeType.toString() == '_NavBar',
      );
      expect(barFinder, findsOneWidget);
      final Rect barRect = tester.getRect(barFinder);
      expect(barRect.left, greaterThanOrEqualTo(0.0));
      expect(barRect.right, lessThanOrEqualTo(280.0));

      final pillFinder = find.byWidgetPredicate(
        (w) => w.runtimeType.toString() == '_LiquidPill',
      );
      expect(pillFinder, findsOneWidget);
      final Rect pillContainerRect = tester.getRect(pillFinder);
      expect(pillContainerRect.left, greaterThanOrEqualTo(barRect.left));
      expect(pillContainerRect.right, lessThanOrEqualTo(barRect.right));

      for (final (label, expectedRoute) in [
        (t.progress, 'progress'),
        (t.exercises, 'exercises'),
        (t.profile.toUpperCase(), 'settings'),
        (t.home, 'home'),
      ]) {
        final tab = find.bySemanticsLabel(label);
        expect(tab, findsOneWidget);
        final Rect tabRect = tester.getRect(tab);
        expect(tabRect.left, greaterThanOrEqualTo(barRect.left));
        expect(tabRect.right, lessThanOrEqualTo(barRect.right));

        await tester.tap(tab);
        await tester.pump(const Duration(milliseconds: 500));
        expect(fit.route, expectedRoute);
        expect(tester.takeException(), isNull);
      }
    },
  );

  testWidgets(
    'Z Fold 3 Unfolded (673x841): Home 2-column & Session 2-pane layout',
    (WidgetTester tester) async {
      tester.view.physicalSize = const Size(673, 841);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.reset);

      final rId = fit.createRoutine('Foldable Session');
      fit.toggleRoutineExercise(rId, 'VBAWRPG');
      fit.route = 'home';

      await tester.pumpWidget(const GymManeApp());
      await tester.pump(const Duration(milliseconds: 500));
      final firstErr = tester.takeException();
      expect(firstErr, isNull, reason: 'Initial unfolded frame error: $firstErr');

      final routine = fit.routines.firstWhere((r) => r.id == rId);
      fit.startRoutine(routine);
      await tester.pump(const Duration(milliseconds: 500));
      expect(fit.route, 'session');
      expect(tester.takeException(), isNull);

      final addExBtn = find.text(titleCase(t.addExercise));
      expect(addExBtn, findsOneWidget);
      final Rect rightPaneRect = tester.getRect(addExBtn);
      expect(rightPaneRect.left, greaterThan(300.0));
      final unfoldedErr = tester.takeException();
      expect(unfoldedErr, isNull, reason: 'Unfolded session error: $unfoldedErr');
      fit.saveAndExit();
      await tester.pump();
    },
  );

  testWidgets(
    'Z Fold 3 Cover (280x653): live session renders without overflow',
    (WidgetTester tester) async {
      tester.view.physicalSize = const Size(280, 653);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.reset);

      final rId = fit.createRoutine('Cover Session');
      fit.toggleRoutineExercise(rId, 'VBAWRPG');
      fit.startRoutine(fit.routines.firstWhere((r) => r.id == rId));

      await tester.pumpWidget(const GymManeApp());
      await tester.pump(const Duration(milliseconds: 500));
      expect(fit.route, 'session');
      final sessionErr = tester.takeException();
      fit.saveAndExit();
      await tester.pump();
      expect(sessionErr, isNull, reason: 'Cover 280px session error: $sessionErr');
    },
  );

  testWidgets(
    'Z Fold 3 Cover (280x653): Routines folders stack in 1 column without cramped cards',
    (WidgetTester tester) async {
      tester.view.physicalSize = const Size(280, 653);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.reset);

      final r1Id = fit.createRoutine('Day A');
      fit.toggleRoutineExercise(r1Id, 'plank-hold');
      final r2Id = fit.createRoutine('Day B');
      fit.toggleRoutineExercise(r2Id, 'plank-hold');

      await tester.pumpWidget(const GymManeApp());
      await tester.pump(const Duration(milliseconds: 300));
      fit.goRoutines();
      await tester.pump(const Duration(milliseconds: 500));
      expect(tester.takeException(), isNull);

      final folders = find.descendant(
        of: find.byType(RoutinesScreen),
        matching: find.byType(RoutineFolder),
      );
      expect(folders, findsNWidgets(2));
      final r0 = tester.getRect(folders.at(0));
      final r1 = tester.getRect(folders.at(1));
      expect(r0.width, greaterThan(200.0));
      expect(r1.top, greaterThan(r0.bottom));
    },
  );

  testWidgets(
    'Z Fold 3 Unfolded Landscape (841x673): moves navbar to left sidebar without overflow',
    (WidgetTester tester) async {
      tester.view.physicalSize = const Size(841, 673);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.reset);

      fit.applyTemplate(kProgramTemplates.first);
      fit.route = 'home';

      await tester.pumpWidget(const GymManeApp());
      await tester.pump(const Duration(milliseconds: 500));
      expect(tester.takeException(), isNull);

      final sidebar = find.byWidgetPredicate((w) => w.runtimeType.toString() == '_Sidebar');
      final bottomBar = find.byWidgetPredicate((w) => w.runtimeType.toString() == '_NavBar');
      expect(sidebar, findsOneWidget);
      expect(bottomBar, findsNothing);
      expect(tester.getRect(sidebar).left, lessThan(40.0));
      expect(tester.getRect(sidebar).width, closeTo(220.0, 1.0));

      await tester.tap(find.byKey(const Key('sidebar-toggle')));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
      expect(tester.getRect(sidebar).width, closeTo(56.0, 1.0));

      await tester.tap(find.byKey(const Key('sidebar-toggle')));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
      expect(tester.getRect(sidebar).width, closeTo(220.0, 1.0));

      await tester.pump(const Duration(seconds: 3));
    },
  );
}
