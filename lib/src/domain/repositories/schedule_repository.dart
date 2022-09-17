import 'package:rsue_app/src/core/api/response.dart';
import 'package:rsue_app/src/domain/entities/group_entity.dart';
import 'package:rsue_app/src/domain/entities/lesson_entity.dart';

abstract class ScheduleRepository {
  //
  //  LOGIN
  //

  // identity api
  void setGroup(Group group);
  void setGroupByGroupId(GroupId groupId);
  void unsetGroup();
  Future<List<Group>> getGroups();

  // treetype login scenary support
  Future<Map<int, String>> getFacults();
  Future<Map<int, String>> getCoursesByFacultId(int faculty);
  Future<Map<int, String>> getGroupsByFacultIdAndCourseId(
      int faculty, int course);
  List<String> getDatasources();
  void setDatasource(String name);

  //
  //  FEATURES
  //

  Future<List<ConcreteLesson>> getLessonsOnDay(DateTime date);
}
