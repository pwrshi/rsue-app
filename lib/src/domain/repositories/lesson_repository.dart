import 'package:rsue_app/src/core/api/response.dart';
import 'package:rsue_app/src/domain/entities/lesson_entity.dart';

abstract class ScheduleRepository {
  Future<Response> setGroup();
  Future<Response> getGroups();
  Future<Response<List<LessonEntity>>> getLessonsOnDay(DateTime date);
}
