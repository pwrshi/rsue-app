import 'package:rsue_app/src/core/resources/data_state.dart';
import 'package:rsue_app/src/domain/entities/group_entity.dart';
import 'package:rsue_app/src/domain/entities/schedule_service.dart';

abstract class ScheduleRepository {
  //
  //  LOGIN
  //

  // identity api
  void setGroup(Group group);
  Future<bool> isAuthorized();
  void setGroupByGroupId(GroupId groupId);
  void unsetGroup();
  Future<DataState<List<Group>>> getGroups();

  // treetype login scenary support
  Future<DataState<Map<int, String>>> getFacults();
  Future<DataState<Map<int, String>>> getCoursesByFacultId(int faculty);
  Future<DataState<Map<int, String>>> getGroupsByFacultIdAndCourseId(
      int faculty, int course);
  List<String> getDatasources();
  void setDatasource(String name);

  //
  //  FEATURES
  //

  Future<DataState<ScheduleService>> getScheduleService();
}
