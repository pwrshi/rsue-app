import 'package:rsue_app/src/domain/entities/schedule_service.dart';
import 'package:rsue_app/src/domain/entities/group_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DsNameStorage {
  SharedPreferences? pref;
  Future<SharedPreferences> getPref() async {
    return pref ??= await SharedPreferences.getInstance();
  }

  Future<String?> getLastDsName() async {
    return (await getPref()).getString("_D_S_N_A_M_E_");
  }

  Future<void> setLastDsName(String dsName) async {
    (await getPref()).setString("_D_S_N_A_M_E_", dsName);
  }
}

abstract class ScheduleDatasource {
  Future<Map<int, String>> getFacults();
  Future<Map<int, String>> getCourses(int faculty);
  Future<Map<int, String>> getGroups(int faculty, int course);
  Future<List<Group>> getAllGroups();
  Future<ScheduleService> getScheduleService(GroupId groupId);
}

abstract class ScheduleLocalDatasource {
  Future<GroupId?> getLastGroup();
  Future<void> setLastGroup(GroupId snapshot);

  Future<void> setFacults(Map<int, String> snapshot);
  Future<void> setCourses(Map<int, String> snapshot, int faculty);
  Future<void> setGroups(Map<int, String> snapshot, int faculty, int course);
  Future<void> setAllGroups(List<Group> snapshot);
  Future<void> setScheduleService(GroupId groupId, ScheduleService snapshot);

  Future<Map<int, String>?> getFacults();
  Future<Map<int, String>?> getCourses(int faculty);
  Future<Map<int, String>?> getGroups(int faculty, int course);
  Future<List<Group>?> getAllGroups();
  Future<ScheduleService?> getScheduleService(GroupId groupId);
}
