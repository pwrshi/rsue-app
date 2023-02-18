import 'package:freezed_annotation/freezed_annotation.dart';
part 'lesson_entity.freezed.dart';
part 'lesson_entity.g.dart';

@freezed
class AbstractLesson with _$AbstractLesson {
  const factory AbstractLesson(
      {required String name,
      required String teachersname,
      required String room,
      required LessonType type,
      required String time,
      String? subgroup}) = _AbstractLesson;
  factory AbstractLesson.fromJson(Map<String, Object?> json) =>
      _$AbstractLessonFromJson(json);
}

@freezed
class ConcreteLesson with _$ConcreteLesson {
  const factory ConcreteLesson(
      {required String name,
      required String teachersname,
      required DateTime startTime,
      required DateTime endTime,
      required String room,
      required LessonType type,
      String? subgroup}) = _ConcreteLesson;
  factory ConcreteLesson.fromJson(Map<String, Object?> json) =>
      _$ConcreteLessonFromJson(json);
}

enum LessonType { lab, lection, practice }

ConcreteLesson generateConcreteLessonFromAbstract(
    DateTime date, AbstractLesson abstractLesson) {
  DateTime end, start;
  switch (abstractLesson.time) {
    case "8:30 — 10:00 ":
      start = DateTime(date.year, date.month, date.day, 8, 30);
      end = DateTime(date.year, date.month, date.day, 10, 00);
      break;
    case "10:10 — 11:40 ":
      start = DateTime(date.year, date.month, date.day, 10, 10);
      end = DateTime(date.year, date.month, date.day, 11, 40);
      break;
    case "11:50 — 13:20 ":
      start = DateTime(date.year, date.month, date.day, 11, 50);
      end = DateTime(date.year, date.month, date.day, 13, 20);
      break;
    case "13:50 — 15:20 ":
      start = DateTime(date.year, date.month, date.day, 13, 50);
      end = DateTime(date.year, date.month, date.day, 15, 20);
      break;
    case "15:30 — 17:00 ":
      start = DateTime(date.year, date.month, date.day, 15, 30);
      end = DateTime(date.year, date.month, date.day, 17, 00);
      break;
    default:
      start = DateTime(date.year, date.month, date.day, 0, 0);
      end = DateTime(date.year, date.month, date.day, 0, 0);
  }
  return ConcreteLesson(
      name: abstractLesson.name,
      teachersname: abstractLesson.teachersname,
      startTime: start,
      endTime: end,
      room: abstractLesson.room,
      type: abstractLesson.type);
}
