import 'package:rsue_app/src/core/api/response.dart';
import 'package:rsue_app/src/features/domain/entities/lesson_entity.dart';

abstract class LessonsRepository {
  Future<Response> setGroup();
  Future<Response<List<LessonEntity>>> getLessons(DateTime date);
}
