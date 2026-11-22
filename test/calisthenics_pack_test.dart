import 'package:flutter_test/flutter_test.dart';
import 'package:gymmane/catalog/exercise_aliases.dart';
import 'package:gymmane/catalog/exercise_catalog.dart';
import 'package:gymmane/catalog/program_templates.dart';
import 'package:gymmane/l10n/l10n.dart';
import 'package:gymmane/models/exercise.dart';
import 'package:gymmane/services/exercise_match.dart';

void main() {
  final byId = {for (final e in kExercises) e.id: e};
  final byName = {for (final e in kExercises) e.name: e};

  test('every progression chain references real exercises with unique steps', () {
    expect(kProgressions, isNotEmpty);
    for (final chain in kProgressions) {
      expect(chain.length, greaterThanOrEqualTo(2));
      expect(chain.toSet().length, chain.length, reason: 'duplicate step in $chain');
      for (final id in chain) {
        expect(byId.containsKey(id), isTrue, reason: 'unknown progression id: $id');
      }
    }
    expect(nextStepOf('planche-lean'), 'frog-stand');
    expect(nextStepOf('full-planche'), isNull);
  });

  test('calisthenics kinds, equipment, slow reps and timed skills are registered', () {
    expect(kExerciseKinds, contains('calisthenics'));
    expect(kCalisthenicsEquipment, containsAll(['Bodyweight', 'Rings', 'Weighted']));
    for (final id in kSlowReps) {
      expect(byId.containsKey(id), isTrue, reason: 'unknown slow-rep id: $id');
    }
    for (final id in [
      'planche-lean',
      'full-planche',
      'full-front-lever',
      'full-back-lever',
      'human-flag-hold',
      'wall-handstand-hold',
      'freestanding-handstand',
    ]) {
      expect(kExerciseModes[id], 'time', reason: '$id should use time mode');
    }
  });

  test('calisthenics skill aliases match exact catalog names and resolve in search', () {
    setAppLanguage('en');
    for (final name in [
      'Adv. Tuck Back Lever',
      'Adv. Tuck Front Lever',
      'Adv. Tuck Planche',
      'Bar Muscle-up',
      'Dead Hang',
      'Explosive High Pull-up',
      'Freestanding Handstand Hold',
      'Frog Stand',
      'Full Back Lever',
      'Full Front Lever',
      'Full Planche',
      'Human Flag Hold',
      'Wall Handstand Hold',
      'Weighted Tricep Dips',
    ]) {
      expect(byName.containsKey(name), isTrue, reason: 'missing catalog name: $name');
      expect(kExerciseAliases.containsKey(name), isTrue, reason: 'missing alias entry: $name');
    }

    List<String> search(String q) => kExercises.where(exerciseSearch(q)).map((e) => e.name).toList();
    expect(search('Planche'), contains('Full Planche'));
    expect(search('Front Lever'), contains('Full Front Lever'));
    expect(search('Back Lever'), contains('Full Back Lever'));
    expect(search('Back Lever'), isNot(contains('Dead Hang')));
    expect(search('Human Flag'), contains('Human Flag Hold'));
    expect(search('Muscle Up'), contains('Bar Muscle-up'));
    expect(search('Weighted Dip'), contains('Weighted Tricep Dips'));
  });

  test('weighted tricep dips describes parallel bar dips matching its art', () {
    final dip = byId['bZq4bwK']!;
    expect(dip.art, 'weighted-dip');
    final joined = dip.steps.join(' ').toLowerCase();
    expect(joined, contains('parallel bars'));
    expect(joined, isNot(contains('bench')));
  });

  test('every playbook entry resolves, ladders exist and notes are clean English', () {
    setAppLanguage('en');
    final playbooks = kProgramTemplates.where((p) => p.id.startsWith('pb-')).toList();
    expect(playbooks.map((p) => p.id), containsAll(['pb-push', 'pb-pull', 'pb-squat']));
    final viChars = RegExp(
      r'[àáạảãâầấậẩẫăằắặẳẵèéẹẻẽêềếệểễìíịỉĩòóọỏõôồốộổỗơờớợởỡùúụủũưừứựửữỳýỵỷỹđ]',
      caseSensitive: false,
    );
    for (final template in playbooks) {
      for (final day in template.days) {
        expect(day.entries, isNotEmpty, reason: '${template.id}/${day.name} has no entries');
        for (final entry in day.entries) {
          expect(
            matchExercise(entry.name, kExercises),
            isNotNull,
            reason: 'unmatched playbook exercise "${entry.name}" in ${day.name}',
          );
          expect(
            viChars.hasMatch(entry.note),
            isFalse,
            reason: 'non-English note in ${day.name}: "${entry.note}"',
          );
        }
        for (final ladder in day.ladders) {
          for (final id in ladder) {
            expect(byId.containsKey(id), isTrue, reason: 'unknown ladder id "$id" in ${day.name}');
          }
        }
      }
    }
  });
}
