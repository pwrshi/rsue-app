import 'package:rsue_app/src/core/api/response.dart';
import 'package:rsue_app/src/domain/entities/group_entity.dart';
import 'package:rsue_app/src/domain/entities/lesson_entity.dart';

abstract class ScheduleRepository {
  Future<Response<void>> setGroup(Group group);
  Future<Response<void>> unsetGroup();
  Future<Response<Group>> getGroups();

  Future<Response<List<LessonEntity>>> getLessonsOnDay(DateTime date);
}
