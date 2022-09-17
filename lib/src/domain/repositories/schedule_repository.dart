import 'package:rsue_app/src/core/api/response.dart';
import 'package:rsue_app/src/domain/entities/group_entity.dart';
import 'package:rsue_app/src/domain/entities/lesson_entity.dart';

abstract class ScheduleRepository {
  //
  //  LOGIN
  //

  // identity api
  Response<void> setGroup(Group group);
  Response<void> unsetGroup();
  Future<Response<List<Group>>> getGroups();

  Future<Response<void>> setGroupByGroupId(GroupId groupId);
  // treetype login scenary support
  Future<Response<Map<int, String>>> getFacults();
  Future<Response<Map<int, String>>> getCourseByFacultId(int facult);
  Future<Response<Map<int, String>>> getGroupsByFacultIdAndCourseId(
      int facult, int course);

  //
  //  FEATURES
  //

  Future<Response<List<LessonEntity>>> getLessonsOnDay(DateTime date);
}
