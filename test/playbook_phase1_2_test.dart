import 'package:flutter_test/flutter_test.dart';
import 'package:gymmane/catalog/exercise_catalog.dart';
import 'package:gymmane/catalog/program_templates.dart';
import 'package:gymmane/l10n/l10n.dart';
import 'package:gymmane/services/local_store.dart';
import 'package:gymmane/state/fit_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await Store.instance.init();
    fit.resetAllData();
    fit.onboarded = true;
  });

  test('all Calisthenics Playbook exercise names resolve in catalog', () {
    const playbookNames = [
      'Plank Hold',
      'Scapula Push-Ups',
      'Negative Push-Ups',
      'Normal Push-ups',
      'Wide Push-Ups',
      'Diamond Push-Ups',
      'Tricep Extensions',
      'Explosive Push-Ups',
      'Archer Push-Ups',
      'One-Arm Push-Ups',
      'Banded Overhead Pull-Aparts',
      'Banded Horizontal Pull-Aparts',
      'Banded Pull-Downs',
      'Bent Over Barbell Rows',
      'Passive Hang',
      'Scapula Pull-Ups',
      'Australian Pull-Ups',
      'Negative Pull-Ups',
      'Band Assisted Pull-Ups',
      'Pull-Ups',
      'Bodyweight Squats',
      'Narrow Stance Squats',
      'Deep Squats',
      'Bulgarian Split Squats',
      'Cossack Squats',
      'Box Pistol Squats',
      'Eccentric Pistol Squat',
      'Assisted Pistol Squat',
      'Pistol Squats',
    ];

    final missing = [
      for (final name in playbookNames)
        if (fit.matchExerciseByName(name) == null) name,
    ];
    expect(missing, isEmpty, reason: 'Unresolved playbook exercises: $missing');
  });

  test('applyTemplate populates planned reps, sec, rest, supersets, notes and ladders', () {
    const template = ProgramTemplate('pb-test', 'Playbook Test', [
      ProgramDay(
        'Pull Level 5',
        [],
        weekday: 1,
        details: [
          ProgramExercise('Pull-Ups', 5, reps: 2, rest: 180, note: 'Tempo 2010'),
          ProgramExercise('Band Assisted Pull-Ups', 3, reps: 8, repsMax: 10, rest: 180, note: 'Tempo 2010'),
          ProgramExercise('Australian Pull-Ups', 3, reps: 8, repsMax: 10, superset: true, note: 'Tempo 2010'),
          ProgramExercise('Scapula Pull-Ups', 3, reps: 8, repsMax: 10, superset: true, note: 'Tempo 2010'),
          ProgramExercise('Passive Hang', 3, sec: 45, rest: 180),
        ],
        ladders: [
          ['incline-row', 'kiJ4Z2K', 'negative-pull-up', 'lBDjFxJ'],
        ],
      ),
    ]);

    final made = fit.applyTemplate(template);
    expect(made, 1);
    final r = fit.routines.single;
    expect(r.group, 'Playbook Test');
    expect(r.exerciseIds, ['lBDjFxJ', 'kiJ4Z2K', 'incline-row', 'uTBt1HV', 'dead-hang-hold']);
    expect(r.plan['lBDjFxJ']!.length, 5);
    expect(r.plan['lBDjFxJ']!.first.reps, 2);
    expect(r.plan['kiJ4Z2K']!.length, 3);
    expect(r.plan['kiJ4Z2K']!.first.repsLabel, '8-10');
    expect(r.plan['dead-hang-hold']!.first.sec, 45);
    expect(r.rest['lBDjFxJ'], 180);
    expect(r.rest['dead-hang-hold'], 180);
    expect(r.chained, {'incline-row', 'uTBt1HV'});
    expect(r.exerciseNotes['lBDjFxJ'], 'Tempo 2010');
    expect(r.ladders.single, ['incline-row', 'kiJ4Z2K', 'negative-pull-up', 'lBDjFxJ']);
  });

  test('all 3 Playbook templates (warm-up + 15 levels) are first and non-playbook calis templates are removed', () {
    expect(kProgramTemplates.any((p) => p.id == 'calis-skills' || p.id == 'calis-ppl' || p.id == 'street-weighted'),
        isFalse);
    final pbTemplates = kProgramTemplates.take(3).toList();
    expect(pbTemplates.map((p) => p.id).toList(), ['pb-push', 'pb-pull', 'pb-squat']);
    for (final tpl in pbTemplates) {
      fit.resetAllData();
      fit.onboarded = true;
      final made = fit.applyTemplate(tpl);
      final expected = tpl.id == 'pb-push' ? 5 : 6;
      expect(made, expected, reason: '${tpl.id} should create $expected routines');
      expect(fit.routines.length, expected);
      expect(tpl.days.any((d) => d.name == 'Push-Ups · Warm-up'), isFalse);
      for (var i = 0; i < expected; i++) {
        expect(fit.routines[i].exerciseIds.length, tpl.days[i].entries.length,
            reason: 'Missing exercise in ${tpl.days[i].name}');
      }
    }
  });

  test('Calisthenics skill catalog, progressions, templates and outdoors preset are registered', () {
    expect(fit.modeOf('tuck-planche'), 'time');
    expect(fit.modeOf('tuck-front-lever'), 'time');
    expect(fit.modeOf('full-back-lever'), 'time');
    expect(fit.modeOf('freestanding-handstand'), 'time');
    expect(fit.modeOf('human-flag-hold'), 'time');

    final plancheChain = fit.builtInLadder('tuck-planche');
    expect(plancheChain, [
      'planche-lean',
      'frog-stand',
      'tuck-planche',
      'adv-tuck-planche',
      'straddle-planche',
      'full-planche',
    ]);
    expect(kFilterEquipment.take(4), ['Bodyweight', 'Rings', 'Weighted', 'Band']);
    expect(kPlacePresets.first, 'outdoors');
    expect(kProgramTemplates.first.id, 'pb-push');
  });

  test('playbookLevelUpHint suggests next level when progression gate is met', () {
    setAppLanguage('vi');
    addTearDown(() => setAppLanguage('en'));
    fit.applyTemplate(kProgramTemplates.firstWhere((p) => p.id == 'pb-push'));
    final l1 = fit.routines.firstWhere((r) => r.name == 'Push-Ups · Level 1');
    fit.startRoutine(l1);
    for (final s in fit.session!.exercises.first.sets) {
      s.reps = 8;
      s.done = true;
    }
    fit.finishSession();
    final hint = fit.playbookLevelUpHint();
    expect(hint, isNotNull);
    expect(hint!.title, contains('Level 2'));
    fit.saveAndExit();
  });
}
