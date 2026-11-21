class ProgramExercise {
  const ProgramExercise(
    this.name,
    this.sets, {
    this.reps,
    this.repsMax,
    this.sec,
    this.rest,
    this.superset = false,
    this.note = '',
  });

  final String name;
  final int sets;
  final int? reps;
  final int? repsMax;
  final int? sec;
  final int? rest;
  final bool superset;
  final String note;

  bool get hasPlan => reps != null || repsMax != null || sec != null;
}

class ProgramDay {
  const ProgramDay(
    this.name,
    this.exercises, {
    this.weekday,
    this.details = const [],
    this.ladders = const [],
  });

  final String name;
  final List<(String, int)> exercises;
  final int? weekday;
  final List<ProgramExercise> details;
  final List<List<String>> ladders;

  List<ProgramExercise> get entries => details.isNotEmpty
      ? details
      : [for (final (name, sets) in exercises) ProgramExercise(name, sets)];
}

class ProgramTemplate {
  const ProgramTemplate(this.id, this.name, this.days);

  final String id;
  final String name;
  final List<ProgramDay> days;
}

const List<ProgramTemplate> kProgramTemplates = [
  ProgramTemplate('pb-push', 'Playbook · One-Arm Push-Ups', [
    ProgramDay('Push-Ups · Level 1', [], details: [
      ProgramExercise('Negative Push-Ups', 3, reps: 6, repsMax: 8, rest: 120, note: 'Tempo 4s eccentric · Lên L2 khi đạt đủ 3×8'),
      ProgramExercise('Scapula Push-Ups', 4, reps: 8, rest: 120, note: 'Tempo 2010'),
      ProgramExercise('Plank Hold', 4, sec: 60, rest: 120),
    ], ladders: [
      ['scapular-push-up', 'negative-push-up', 'I4hDWkc', 'wide-push-up', 'x6KpKpq', 'bodyweight-tricep-extension', 'wigSg76', 'A9qxk2F', 'one-arm-push-up'],
    ]),
    ProgramDay('Push-Ups · Level 2', [], details: [
      ProgramExercise('Normal Push-ups', 3, reps: 8, repsMax: 12, rest: 120, note: 'Tempo 2010 · Lên L3 khi đạt 12 reps'),
      ProgramExercise('Negative Push-Ups', 3, reps: 6, repsMax: 8, rest: 120, note: 'Tempo 4s eccentric'),
      ProgramExercise('Scapula Push-Ups', 4, reps: 8, superset: true, note: 'Tempo 2010'),
      ProgramExercise('Plank Hold', 4, sec: 60, rest: 180),
    ], ladders: [
      ['scapular-push-up', 'negative-push-up', 'I4hDWkc', 'wide-push-up', 'x6KpKpq', 'bodyweight-tricep-extension', 'wigSg76', 'A9qxk2F', 'one-arm-push-up'],
    ]),
    ProgramDay('Push-Ups · Level 3', [], details: [
      ProgramExercise('Tricep Extensions', 3, reps: 8, rest: 120, note: 'Tempo 2010 · Khởi động kỹ cổ tay'),
      ProgramExercise('Diamond Push-Ups', 3, reps: 12, repsMax: 15, rest: 120, note: 'Tempo 2010'),
      ProgramExercise('Wide Push-Ups', 3, reps: 6, rest: 90, note: 'Tempo 2010'),
      ProgramExercise('Normal Push-ups', 3, reps: 8, superset: true, note: 'Tempo 2010'),
      ProgramExercise('Negative Push-Ups', 3, reps: 4, rest: 180, note: 'Tempo 4s eccentric'),
    ], ladders: [
      ['scapular-push-up', 'negative-push-up', 'I4hDWkc', 'wide-push-up', 'x6KpKpq', 'bodyweight-tricep-extension', 'wigSg76', 'A9qxk2F', 'one-arm-push-up'],
    ]),
    ProgramDay('Push-Ups · Level 4', [], details: [
      ProgramExercise('Archer Push-Ups', 5, reps: 2, rest: 120, note: 'Tempo 2010 · mỗi tay (each arm)'),
      ProgramExercise('Explosive Push-Ups', 3, reps: 6, rest: 120, note: 'Tempo 1010'),
      ProgramExercise('Diamond Push-Ups', 3, reps: 10, rest: 120, note: 'Tempo 2010'),
      ProgramExercise('Normal Push-ups', 5, reps: 10, superset: true, note: 'Tempo 2010'),
      ProgramExercise('Plank Hold', 5, sec: 60, rest: 180, note: 'Giữ chuẩn 60s để lên L5'),
    ], ladders: [
      ['scapular-push-up', 'negative-push-up', 'I4hDWkc', 'wide-push-up', 'x6KpKpq', 'bodyweight-tricep-extension', 'wigSg76', 'A9qxk2F', 'one-arm-push-up'],
    ]),
    ProgramDay('Push-Ups · Level 5', [], details: [
      ProgramExercise('One-Arm Push-Ups', 3, reps: 1, rest: 120, note: 'Tempo 2010 · mỗi tay (each arm)'),
      ProgramExercise('Archer Push-Ups', 5, reps: 4, superset: true, note: 'Tempo 2010 · mỗi tay (each arm)'),
      ProgramExercise('Normal Push-ups', 5, reps: 6, rest: 120, note: 'Tempo 2010'),
      ProgramExercise('Diamond Push-Ups', 4, reps: 5, superset: true, note: 'Tempo 2010'),
      ProgramExercise('Wide Push-Ups', 4, reps: 5, rest: 180, note: 'Tempo 2010'),
    ], ladders: [
      ['scapular-push-up', 'negative-push-up', 'I4hDWkc', 'wide-push-up', 'x6KpKpq', 'bodyweight-tricep-extension', 'wigSg76', 'A9qxk2F', 'one-arm-push-up'],
    ]),
  ]),
  ProgramTemplate('pb-pull', 'Playbook · Pull-Ups', [
    ProgramDay('Pull-Ups · Warm-up', [], details: [
      ProgramExercise('Banded Overhead Pull-Aparts', 2, reps: 12, repsMax: 15, rest: 60, note: 'Khởi động dây kháng lực · Giữ tay thẳng, không nhún vai'),
      ProgramExercise('Banded Horizontal Pull-Aparts', 2, reps: 12, repsMax: 15, rest: 60, note: 'Kéo ngang ngực, siết bả vai'),
      ProgramExercise('Banded Pull-Downs', 2, reps: 12, repsMax: 15, rest: 60, note: 'Kích hoạt cơ xô trước khi vào bài chính'),
    ]),
    ProgramDay('Pull-Ups · Level 1', [], details: [
      ProgramExercise('Bent Over Barbell Rows', 3, reps: 12, repsMax: 15, superset: true, note: 'Tempo 2010 · Lên L2 khi đạt 30–40 kg & hang 60s'),
      ProgramExercise('Passive Hang', 3, sec: 60, rest: 180, note: '30–60s'),
    ], ladders: [
      ['eZyBC3j', 'dead-hang-hold', 'uTBt1HV', 'incline-row', 'kiJ4Z2K', 'negative-pull-up', 'lBDjFxJ'],
    ]),
    ProgramDay('Pull-Ups · Level 2', [], details: [
      ProgramExercise('Australian Pull-Ups', 3, reps: 10, repsMax: 12, superset: true, note: 'Tempo 2010 · Hạ xà gần ngang để lên L3'),
      ProgramExercise('Scapula Pull-Ups', 3, reps: 10, repsMax: 12, rest: 180, note: 'Tempo 2010'),
    ], ladders: [
      ['eZyBC3j', 'dead-hang-hold', 'uTBt1HV', 'incline-row', 'kiJ4Z2K', 'negative-pull-up', 'lBDjFxJ'],
    ]),
    ProgramDay('Pull-Ups · Level 3', [], details: [
      ProgramExercise('Band Assisted Pull-Ups', 3, reps: 4, repsMax: 6, rest: 180, note: 'Tempo 2010 · Dây mỏng ~10 kg để lên L4'),
      ProgramExercise('Australian Pull-Ups', 4, reps: 10, repsMax: 12, superset: true, note: 'Tempo 2010'),
      ProgramExercise('Scapula Pull-Ups', 4, reps: 10, repsMax: 12, rest: 180, note: 'Tempo 2010'),
    ], ladders: [
      ['eZyBC3j', 'dead-hang-hold', 'uTBt1HV', 'incline-row', 'kiJ4Z2K', 'negative-pull-up', 'lBDjFxJ'],
    ]),
    ProgramDay('Pull-Ups · Level 4', [], details: [
      ProgramExercise('Negative Pull-Ups', 5, reps: 1, rest: 60, note: 'Tempo 5–10s eccentric · Đạt 5×1×10s để lên L5'),
      ProgramExercise('Band Assisted Pull-Ups', 3, reps: 4, repsMax: 6, rest: 180, note: 'Tempo 2010'),
      ProgramExercise('Australian Pull-Ups', 3, reps: 8, repsMax: 10, superset: true, note: 'Tempo 2010'),
      ProgramExercise('Passive Hang', 3, sec: 30, superset: true),
      ProgramExercise('Scapula Pull-Ups', 3, reps: 8, repsMax: 10, rest: 180, note: 'Tempo 2010'),
    ], ladders: [
      ['eZyBC3j', 'dead-hang-hold', 'uTBt1HV', 'incline-row', 'kiJ4Z2K', 'negative-pull-up', 'lBDjFxJ'],
    ]),
    ProgramDay('Pull-Ups · Level 5', [], details: [
      ProgramExercise('Pull-Ups', 5, reps: 2, rest: 180, note: 'Tempo 2010 · Tăng dần lên 5×3+'),
      ProgramExercise('Band Assisted Pull-Ups', 3, reps: 8, repsMax: 10, rest: 180, note: 'Tempo 2010'),
      ProgramExercise('Australian Pull-Ups', 3, reps: 8, repsMax: 10, superset: true, note: 'Tempo 2010'),
      ProgramExercise('Scapula Pull-Ups', 3, reps: 8, repsMax: 10, superset: true, note: 'Tempo 2010'),
      ProgramExercise('Passive Hang', 3, sec: 45, rest: 180, note: '30–45s'),
    ], ladders: [
      ['eZyBC3j', 'dead-hang-hold', 'uTBt1HV', 'incline-row', 'kiJ4Z2K', 'negative-pull-up', 'lBDjFxJ'],
    ]),
  ]),
  ProgramTemplate('pb-squat', 'Playbook · Pistol Squats', [
    ProgramDay('Squats · Warm-up', [], details: [
      ProgramExercise('Bodyweight Squats', 2, reps: 10, rest: 60, note: 'Khởi động khớp gối & hông'),
      ProgramExercise('Deep Squats', 2, reps: 8, rest: 60, note: 'Mở biên độ cổ chân & hông trước bài chính'),
      ProgramExercise('Cossack Squats', 2, reps: 5, rest: 60, note: 'mỗi chân (each leg) · Giãn đùi sau & háng'),
    ]),
    ProgramDay('Squats · Level 1', [], details: [
      ProgramExercise('Deep Squats', 3, reps: 10, repsMax: 12, rest: 120, note: 'Tempo 2010 · Nếu khó hãy tập mobility trước'),
      ProgramExercise('Narrow Stance Squats', 3, reps: 10, repsMax: 12, rest: 120, note: 'Tempo 2010'),
      ProgramExercise('Bodyweight Squats', 3, reps: 12, repsMax: 15, rest: 120, note: 'Tempo 2010'),
    ], ladders: [
      ['6YUfHPL', 'narrow-stance-squat', 'deep-squat', 'bulgarian-split-squat', 'cossack-squat', 'single-leg-box-squat', 'eccentric-pistol-squat', 'assisted-pistol-squat', 'pistol-squat'],
    ]),
    ProgramDay('Squats · Level 2', [], details: [
      ProgramExercise('Bulgarian Split Squats', 3, reps: 4, repsMax: 6, rest: 180, note: 'Tempo 3010 · mỗi chân (each leg) · Đạt 6 reps để lên L3'),
      ProgramExercise('Narrow Stance Squats', 3, reps: 8, repsMax: 10, superset: true, note: 'Tempo 2010'),
      ProgramExercise('Deep Squats', 3, reps: 8, repsMax: 10, rest: 180, note: 'Tempo 3010'),
    ], ladders: [
      ['6YUfHPL', 'narrow-stance-squat', 'deep-squat', 'bulgarian-split-squat', 'cossack-squat', 'single-leg-box-squat', 'eccentric-pistol-squat', 'assisted-pistol-squat', 'pistol-squat'],
    ]),
    ProgramDay('Squats · Level 3', [], details: [
      ProgramExercise('Cossack Squats', 3, reps: 4, repsMax: 6, rest: 120, note: 'Tempo 2010 · mỗi chân (each leg) · Đạt 6 reps để lên L4'),
      ProgramExercise('Bulgarian Split Squats', 3, reps: 6, repsMax: 8, rest: 120, note: 'Tempo 2010 · mỗi chân (each leg)'),
      ProgramExercise('Narrow Stance Squats', 3, reps: 6, repsMax: 8, superset: true, note: 'Tempo 2010'),
      ProgramExercise('Deep Squats', 3, reps: 6, repsMax: 8, rest: 180, note: 'Tempo 3010'),
    ], ladders: [
      ['6YUfHPL', 'narrow-stance-squat', 'deep-squat', 'bulgarian-split-squat', 'cossack-squat', 'single-leg-box-squat', 'eccentric-pistol-squat', 'assisted-pistol-squat', 'pistol-squat'],
    ]),
    ProgramDay('Squats · Level 4', [], details: [
      ProgramExercise('Box Pistol Squats', 3, reps: 6, repsMax: 10, rest: 120, note: 'Tempo 3010 · mỗi chân (hoặc Eccentric / Assisted Pistol) · Đạt 10 reps để lên L5'),
      ProgramExercise('Cossack Squats', 3, reps: 6, repsMax: 8, rest: 120, note: 'Tempo 2010 · mỗi chân (each leg)'),
      ProgramExercise('Bulgarian Split Squats', 3, reps: 8, repsMax: 10, rest: 120, note: 'Tempo 2010 · mỗi chân (each leg)'),
      ProgramExercise('Deep Squats', 3, reps: 10, repsMax: 12, rest: 120, note: 'Tempo 3010'),
    ], ladders: [
      ['6YUfHPL', 'narrow-stance-squat', 'deep-squat', 'bulgarian-split-squat', 'cossack-squat', 'single-leg-box-squat', 'eccentric-pistol-squat', 'assisted-pistol-squat', 'pistol-squat'],
    ]),
    ProgramDay('Squats · Level 5', [], details: [
      ProgramExercise('Pistol Squats', 5, reps: 2, rest: 120, note: 'Tempo 2020 · mỗi chân (each leg) · Tăng dần lên 8 reps'),
      ProgramExercise('Box Pistol Squats', 3, reps: 4, repsMax: 6, rest: 120, note: 'Tempo 3010 · mỗi chân (hoặc Eccentric / Assisted Pistol)'),
      ProgramExercise('Cossack Squats', 3, reps: 6, repsMax: 8, rest: 120, note: 'Tempo 2010 · mỗi chân (each leg)'),
      ProgramExercise('Bulgarian Split Squats', 3, reps: 8, repsMax: 10, superset: true, note: 'Tempo 2010 · mỗi chân (each leg)'),
      ProgramExercise('Deep Squats', 3, reps: 8, repsMax: 10, rest: 180, note: 'Tempo 3010'),
    ], ladders: [
      ['6YUfHPL', 'narrow-stance-squat', 'deep-squat', 'bulgarian-split-squat', 'cossack-squat', 'single-leg-box-squat', 'eccentric-pistol-squat', 'assisted-pistol-squat', 'pistol-squat'],
    ]),
  ]),
  ProgramTemplate('fullbody', 'Full Body', [
    ProgramDay('Full Body', [
      ('Barbell Squat', 3),
      ('Barbell Bench Press', 3),
      ('Barbell Row', 3),
      ('Overhead Press', 3),
      ('Romanian Deadlift', 3),
      ('Plank', 3),
    ], weekday: 1),
    ProgramDay('Full Body', [
      ('Barbell Squat', 3),
      ('Barbell Bench Press', 3),
      ('Barbell Row', 3),
      ('Overhead Press', 3),
      ('Romanian Deadlift', 3),
      ('Plank', 3),
    ], weekday: 3),
    ProgramDay('Full Body', [
      ('Barbell Squat', 3),
      ('Barbell Bench Press', 3),
      ('Barbell Row', 3),
      ('Overhead Press', 3),
      ('Romanian Deadlift', 3),
      ('Plank', 3),
    ], weekday: 5),
  ]),
  ProgramTemplate('ppl', 'Push Pull Legs', [
    ProgramDay('Push', [
      ('Barbell Bench Press', 4),
      ('Incline Dumbbell Press', 3),
      ('Overhead Press', 3),
      ('Lateral Raise', 3),
      ('Triceps Pushdown', 3),
    ], weekday: 1),
    ProgramDay('Pull', [
      ('Pull Up', 4),
      ('Barbell Row', 4),
      ('Lat Pulldown', 3),
      ('Face Pull', 3),
      ('Barbell Curl', 3),
    ], weekday: 3),
    ProgramDay('Legs', [
      ('Barbell Squat', 4),
      ('Romanian Deadlift', 3),
      ('Leg Press', 3),
      ('Leg Curl', 3),
      ('Standing Calf Raise', 4),
    ], weekday: 5),
  ]),
  ProgramTemplate('arnold', 'Arnold Split', [
    ProgramDay('Chest & Back', [
      ('Barbell Bench Press', 4),
      ('Incline Dumbbell Press', 3),
      ('Cable Fly', 3),
      ('Pull Up', 4),
      ('Barbell Row', 4),
      ('Seated Cable Row', 3),
    ], weekday: 1),
    ProgramDay('Shoulders & Arms', [
      ('Overhead Press', 4),
      ('Lateral Raise', 4),
      ('Face Pull', 3),
      ('Barbell Curl', 3),
      ('Hammer Curl', 3),
      ('Skull Crushers', 3),
      ('Triceps Pushdown', 3),
    ], weekday: 2),
    ProgramDay('Legs', [
      ('Barbell Squat', 4),
      ('Romanian Deadlift', 3),
      ('Leg Press', 3),
      ('Leg Extension', 3),
      ('Leg Curl', 3),
      ('Standing Calf Raise', 4),
    ], weekday: 3),
    ProgramDay('Chest & Back', [
      ('Barbell Bench Press', 4),
      ('Incline Dumbbell Press', 3),
      ('Cable Fly', 3),
      ('Pull Up', 4),
      ('Barbell Row', 4),
      ('Seated Cable Row', 3),
    ], weekday: 4),
    ProgramDay('Shoulders & Arms', [
      ('Overhead Press', 4),
      ('Lateral Raise', 4),
      ('Face Pull', 3),
      ('Barbell Curl', 3),
      ('Hammer Curl', 3),
      ('Skull Crushers', 3),
      ('Triceps Pushdown', 3),
    ], weekday: 5),
    ProgramDay('Legs', [
      ('Barbell Squat', 4),
      ('Romanian Deadlift', 3),
      ('Leg Press', 3),
      ('Leg Extension', 3),
      ('Leg Curl', 3),
      ('Standing Calf Raise', 4),
    ], weekday: 6),
  ]),
  ProgramTemplate('upperlower', 'Upper Lower', [
    ProgramDay('Upper', [
      ('Barbell Bench Press', 4),
      ('Barbell Row', 4),
      ('Overhead Press', 3),
      ('Lat Pulldown', 3),
      ('Barbell Curl', 3),
      ('Triceps Pushdown', 3),
    ], weekday: 1),
    ProgramDay('Lower', [
      ('Barbell Squat', 4),
      ('Romanian Deadlift', 3),
      ('Leg Press', 3),
      ('Leg Curl', 3),
      ('Standing Calf Raise', 4),
    ], weekday: 2),
    ProgramDay('Upper', [
      ('Incline Dumbbell Press', 4),
      ('Pull Up', 4),
      ('Dumbbell Standing Overhead Press', 3),
      ('Seated Cable Row', 3),
      ('Hammer Curl', 3),
      ('Triceps Dip', 3),
    ], weekday: 4),
    ProgramDay('Lower', [
      ('Deadlift', 3),
      ('Front Squat', 3),
      ('Leg Extension', 3),
      ('Leg Curl', 3),
      ('Standing Calf Raise', 4),
    ], weekday: 5),
  ]),
  ProgramTemplate('abcd', 'ABCD Split', [
    ProgramDay('A · Chest & Triceps', [
      ('Barbell Bench Press', 4),
      ('Incline Dumbbell Press', 3),
      ('Cable Fly', 3),
      ('Triceps Pushdown', 3),
      ('Skull Crushers', 3),
    ], weekday: 1),
    ProgramDay('B · Back & Biceps', [
      ('Pull Up', 4),
      ('Barbell Row', 4),
      ('Lat Pulldown', 3),
      ('Barbell Curl', 3),
      ('Hammer Curl', 3),
    ], weekday: 2),
    ProgramDay('C · Legs', [
      ('Barbell Squat', 4),
      ('Romanian Deadlift', 3),
      ('Leg Press', 3),
      ('Leg Curl', 3),
      ('Standing Calf Raise', 4),
    ], weekday: 4),
    ProgramDay('D · Shoulders & Abs', [
      ('Overhead Press', 4),
      ('Lateral Raise', 3),
      ('Face Pull', 3),
      ('Hanging Leg Raise', 3),
      ('Plank', 3),
    ], weekday: 5),
  ]),
  ProgramTemplate('abcde', 'ABCDE Split', [
    ProgramDay('A · Chest', [
      ('Barbell Bench Press', 4),
      ('Incline Dumbbell Press', 4),
      ('Cable Fly', 3),
      ('Triceps Dip', 3),
    ], weekday: 1),
    ProgramDay('B · Back', [
      ('Deadlift', 3),
      ('Pull Up', 4),
      ('Barbell Row', 4),
      ('Seated Cable Row', 3),
    ], weekday: 2),
    ProgramDay('C · Legs', [
      ('Barbell Squat', 4),
      ('Leg Press', 4),
      ('Leg Extension', 3),
      ('Leg Curl', 3),
      ('Standing Calf Raise', 4),
    ], weekday: 3),
    ProgramDay('D · Shoulders', [
      ('Overhead Press', 4),
      ('Dumbbell Standing Overhead Press', 3),
      ('Lateral Raise', 4),
      ('Face Pull', 3),
    ], weekday: 4),
    ProgramDay('E · Arms', [
      ('Barbell Curl', 4),
      ('Skull Crushers', 4),
      ('Hammer Curl', 3),
      ('Triceps Pushdown', 3),
    ], weekday: 5),
  ]),
  ProgramTemplate('stronglifts', 'StrongLifts 5×5', [
    ProgramDay('Workout A', [
      ('Barbell Squat', 5),
      ('Barbell Bench Press', 5),
      ('Barbell Row', 5),
    ], weekday: 1),
    ProgramDay('Workout B', [
      ('Barbell Squat', 5),
      ('Overhead Press', 5),
      ('Deadlift', 1),
    ], weekday: 3),
  ]),
  ProgramTemplate('startingstrength', 'Starting Strength', [
    ProgramDay('Workout A', [
      ('Barbell Squat', 3),
      ('Barbell Bench Press', 3),
      ('Deadlift', 1),
    ], weekday: 1),
    ProgramDay('Workout B', [
      ('Barbell Squat', 3),
      ('Overhead Press', 3),
      ('Barbell Row', 3),
    ], weekday: 3),
  ]),
  ProgramTemplate('rr', 'Recommended Routine', [
    ProgramDay('Recommended Routine', [
      ('Negative Pull-up', 3),
      ('Bodyweight Squat', 3),
      ('Negative Dip', 3),
      ('Bodyweight Romanian Deadlift', 3),
      ('Incline Row', 3),
      ('Incline Push-up', 3),
      ('Plank', 3),
      ('Banded Pallof Press', 3),
      ('Reverse Hyperextension', 3),
    ], weekday: 1),
    ProgramDay('Recommended Routine', [
      ('Negative Pull-up', 3),
      ('Bodyweight Squat', 3),
      ('Negative Dip', 3),
      ('Bodyweight Romanian Deadlift', 3),
      ('Incline Row', 3),
      ('Incline Push-up', 3),
      ('Plank', 3),
      ('Banded Pallof Press', 3),
      ('Reverse Hyperextension', 3),
    ], weekday: 3),
    ProgramDay('Recommended Routine', [
      ('Negative Pull-up', 3),
      ('Bodyweight Squat', 3),
      ('Negative Dip', 3),
      ('Bodyweight Romanian Deadlift', 3),
      ('Incline Row', 3),
      ('Incline Push-up', 3),
      ('Plank', 3),
      ('Banded Pallof Press', 3),
      ('Reverse Hyperextension', 3),
    ], weekday: 5),
  ]),
  ProgramTemplate('home', 'No Kit', [
    ProgramDay('Home A', [
      ('Push Up', 3),
      ('Pull Up', 3),
      ('Bodyweight Squat', 3),
      ('Plank', 3),
    ], weekday: 2),
    ProgramDay('Home B', [
      ('Triceps Dip', 3),
      ('Chin Up', 3),
      ('Lunge', 3),
      ('Hanging Leg Raise', 3),
    ], weekday: 5),
  ]),
];
