import 'dart:convert';

import 'package:rsue_app/src/data/repositories/schedule_datasource.dart';
import 'package:rsue_app/src/domain/entities/group_entity.dart';
import 'package:rsue_app/src/domain/entities/schedule_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesScheduleCacheDatasource
    implements ScheduleLocalDatasource {
  SharedPreferences? pref;
  Future<SharedPreferences> getPref() async {
    return pref ??= await SharedPreferences.getInstance();
  }

  @override
  Future<List<Group>?> getAllGroups() async {
    return null;
  }

  @override
  Future<Map<int, String>?> getCourses(int faculty) async {
    return null;
  }

  @override
  Future<Map<int, String>?> getFacults() async {
    return null;
  }

  @override
  Future<Map<int, String>?> getGroups(int faculty, int course) async {
    return null;
  }

  @override
  Future<GroupId?> getLastGroup() async {
    var raw = (await getPref()).getString("last_selected_group");
    if (raw == null) {
      return null;
    }
    return GroupId.fromJson(json.decode(raw));
  }

  @override
  Future<ScheduleService?> getScheduleService(GroupId groupId) async {
    var raw = (await getPref()).getString("service_of_group_id_$groupId");
    if (raw == null) {
      return null;
    }
    return ScheduleService.fromJson(json.decode(raw));
  }

  @override
  Future<void> setAllGroups(List<Group> snapshot) async {}

  @override
  Future<void> setCourses(Map<int, String> snapshot, int faculty) async {}

  @override
  Future<void> setFacults(Map<int, String> snapshot) async {}

  @override
  Future<void> setGroups(
      Map<int, String> snapshot, int faculty, int course) async {}

  @override
  Future<void> setScheduleService(
      GroupId groupId, ScheduleService snapshot) async {
    (await getPref())
        .setString("service_of_group_id_$groupId", json.encode(snapshot));
  }

  @override
  Future<void> setLastGroup(GroupId snapshot) async {
    (await getPref()).setString("last_selected_group", json.encode(snapshot));
  }
}
