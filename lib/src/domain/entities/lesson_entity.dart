import 'package:equatable/equatable.dart';

class AbstractLesson extends Equatable {
  const AbstractLesson(
      {required this.name,
      required this.teachersname,
      required this.room,
      required this.type,
      required this.time,
      this.subgroup});
  final String? subgroup;
  final String name;
  final String teachersname;
  final String time;
  final String room;
  final LessonType type;

  @override
  List<Object?> get props => [name, teachersname, time, room, type, subgroup];
}

class ConcreteLesson extends Equatable {
  const ConcreteLesson(
      {required this.name,
      required this.teachersname,
      required this.startTime,
      required this.endTime,
      required this.room,
      required this.type,
      this.subgroup});
  final String? subgroup;
  final String name;
  final String teachersname;
  final DateTime startTime;
  final DateTime endTime;
  final String room;
  final LessonType type;
  @override
  List<Object?> get props =>
      [name, teachersname, startTime, endTime, room, type, subgroup];
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
