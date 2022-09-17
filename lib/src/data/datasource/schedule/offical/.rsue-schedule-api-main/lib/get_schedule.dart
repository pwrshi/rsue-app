import 'schedule_type.dart';
import 'get_schedule_raw_data.dart';

/// Получить **готовое** расписание в формате
/// ```dart
/// {
///   "Четная/Нечетная неделя": {
///     "День недели": [
///       {
///         "name": "Дисциплина",
///         "teacher": "Преподаватель",
///         "time": "Время занятия",
///         "room": "Кабинет",
///         "type": "Лабораторная/Практика/Лекция",
///       }
///     ]
///   }
/// }
/// ```
Future<Schedule?> getSchedule(int faculty, int course, int group) async {
  var scheduleRaw = await getScheduleRawData(faculty, course, group);
  if (scheduleRaw != null) {
    return Schedule(scheduleRaw,
        faculty: faculty, course: course, group: group);
  }
  return null;
}
