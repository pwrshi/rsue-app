import 'package:rsue_app/src/data/repositories/schedule_service.dart';
import 'package:rsue_app/src/domain/entities/group_entity.dart';

abstract class ScheduleDatasource {
  Future<Map<int, String>> getFacults();
  Future<Map<int, String>> getCourses(int faculty);
  Future<Map<int, String>> getGroups(int faculty, int course);
  Future<List<Group>> getAllGroups();
  Future<ScheduleService> getScheduleService(GroupId groupId);
}

abstract class ScheduleLocalDatasource {
  Future<GroupId> getLastGroup();

  Future<void> setFacults(Map<int, String> snapshot);
  Future<void> setCourses(Map<int, String> snapshot, int faculty);
  Future<void> setGroups(Map<int, String> snapshot, int faculty, int course);
  Future<void> setAllGroups(List<Group> snapshot);
  Future<void> setScheduleService(GroupId groupId, ScheduleService snapshot);
}
