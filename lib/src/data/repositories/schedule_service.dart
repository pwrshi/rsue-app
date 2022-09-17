import 'package:rsue_app/src/data/datasource/schedule/offical/schedule_offical.dart';
import 'package:rsue_app/src/domain/entities/lesson_entity.dart';
import 'package:week_of_year/week_of_year.dart';

typedef DayOfWeek = int;

class ScheduleService {
  const ScheduleService(this.evenWeek, this.oddWeek);
  final Map<DayOfWeek, List<AbstractLesson>> evenWeek;
  final Map<DayOfWeek, List<AbstractLesson>> oddWeek;

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
