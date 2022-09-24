import 'package:json_annotation/json_annotation.dart';
import 'package:rsue_app/src/domain/entities/lesson_entity.dart';
import 'package:week_of_year/week_of_year.dart';

part 'schedule_service.g.dart';

typedef DayOfWeek = int;

@JsonSerializable()
class ScheduleService {
  const ScheduleService(this.evenWeek, this.oddWeek);
  final Map<DayOfWeek, List<AbstractLesson>> evenWeek;
  final Map<DayOfWeek, List<AbstractLesson>> oddWeek;

  factory ScheduleService.fromJson(Map<String, dynamic> json) =>
      _$ScheduleServiceFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$ScheduleServiceToJson(this);

  Map<DayOfWeek, List<AbstractLesson>> _getAbstractWeekByDateTime(
      DateTime date) {
    bool weekIsOdd = (date.weekOfYear % 2) != 0;
    return weekIsOdd ? oddWeek : evenWeek;
  }

  List<ConcreteLesson> generateConcreteDay(
      DateTime date, List<AbstractLesson> lessons) {
    return lessons
        .map((e) => generateConcreteLessonFromAbstract(date, e))
        .toList();
  }

  List<ConcreteLesson> getLessonsOnDay(DateTime date) {
    return generateConcreteDay(
        date, _getAbstractWeekByDateTime(date)[date.weekday] ?? []);
  }
}
