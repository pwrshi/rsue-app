import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:week_of_year/week_of_year.dart';

part 'schedule_type.g.dart';

@JsonSerializable()
class Subject {
  late Map<String, String> raw;
  late String subgroup;
  late int numberOfLesson;
  late String name;
  late String teacher;
  late String time;
  late String room;
  late String type;

  Subject(this.raw) {
    room = raw["room"] ?? ":(";
    teacher = raw["teacher"] ?? ":(";
    time = raw["time"] ?? ":(";
    name = raw["name"] ?? ":(";
    type = raw["type"] ?? ":(";
    subgroup = raw["subgroup"] ?? ":(";
    // const time = {
    //   1: "8:30 — 10:00",
    //   2: "10:10 — 11:40",
    //   3: "11.50 — 13:20",
    //   4: "13:50 — 15:20",
    //   5: "15.30 — 17:00",
    // };
    switch (time) {
      case "8:30 — 10:00 ":
        numberOfLesson = 1;
        break;
      case "10:10 — 11:40 ":
        numberOfLesson = 2;
        break;
      case "11:50 — 13:20 ":
        numberOfLesson = 3;
        break;
      case "13:50 — 15:20 ":
        numberOfLesson = 4;
        break;
      case "15:30 — 17:00 ":
        numberOfLesson = 5;
        break;
      default:
        numberOfLesson = 0;
    }
  }
  factory Subject.fromJson(Map<String, dynamic> json) =>
      _$SubjectFromJson(json);

  Map<String, dynamic> toJson() => _$SubjectToJson(this);
}

@JsonSerializable()
class Day {
  late String weekdayName;
  late int ofWeek;
  late List<Subject> subjects;
  late List<Map<String, String>> raw;
  Day(this.weekdayName, this.raw) {
    subjects = raw.map((e) => Subject(e)).toList();
    switch (weekdayName) {
      case "Понедельник":
        ofWeek = 1;
        break;
      case "Вторник":
        ofWeek = 2;
        break;
      case "Среда":
        ofWeek = 3;
        break;
      case "Четверг":
        ofWeek = 4;
        break;
      case "Пятница":
        ofWeek = 5;
        break;
      case "Суббота":
        ofWeek = 6;
        break;
      case "Воскресенье":
        ofWeek = 7;
        break;
      default:
        ofWeek = -1;
        break;
    }
  }
  factory Day.fromJson(Map<String, dynamic> json) => _$DayFromJson(json);

  Map<String, dynamic> toJson() => _$DayToJson(this);
}

@JsonSerializable()
class Schedule {
  Map<String, Map<String, List<Map<String, String>>>> raw;
  late Map<String, Map<int, Day>> schedule;
  late DateTime createDate;

  late int faculty;
  late int course;
  late int group;

  Schedule(this.raw,
      {required this.faculty, required this.course, required this.group}) {
    createDate = DateTime.now();
    schedule = raw.map((key, value) {
      return MapEntry(key, value.map(((keyday, valueday) {
        var day = Day(keyday, valueday);
        return MapEntry(day.ofWeek, day);
      })));
    });
  }

  /// Возвращает расписание на неделю, учитывая какая сейчас неделя,
  /// чётная или нечетная
  Day? onDay(DateTime date) {
    return ((date.weekOfYear % 2) != 0
        ? schedule["Нечетная неделя"]![date.weekday]
        : schedule["Четная неделя"]![date.weekday]);
  }

  /// Создаёт экземпляр из JSON сторки
  factory Schedule.fromJson(String json) =>
      _$ScheduleFromJson(jsonDecode(json));

  /// Экспортирует состояние в JSON
  String toJson() => jsonEncode(_$ScheduleToJson(this));
}
