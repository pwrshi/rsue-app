import 'dart:convert';

import 'package:rsue_app/src/config/dio.dart';
import 'package:rsue_app/src/core/error/error.dart';
import 'package:rsue_app/src/data/repositories/schedule_datasource.dart';
import 'package:rsue_app/src/domain/entities/schedule_service.dart';
import 'package:rsue_app/src/domain/entities/group_entity.dart';

typedef ScheduleRaw = Map<String, Map<String, List<Map<String, String>>>>;

class SchedulePwrshiBackupDatasource implements ScheduleDatasource {
  @override
  Future<List<Group>> getAllGroups() async {
    var resp = await getDio()
        .get<String>('https://schedule-backup.pwrshi.ru/groups.json');
    if (resp.statusCode == 200) {
      var struct = jsonDecode(resp.data!) as Map<String, dynamic>;
      return struct.entries.map((e) {
        final gid = (e.value as List<int>);
        return Group(
            e.key, GroupId(facult: gid[0], course: gid[1], group: gid[2]));
      }).toList();
    } else {
      throw RsError(name: 'status code is ${resp.statusCode}');
    }
  }

  @override
  Future<Map<int, String>> getCourses(int faculty) async =>
      _getList('https://schedule-backup.pwrshi.ru/$faculty.json');

  Future<Map<int, String>> _getList(String url) async {
    var resp = await getDio().get<String>(url);
    if (resp.statusCode == 200) {
      return Map<String, String>.from(jsonDecode(resp.data!))
          .map((key, value) => MapEntry(int.parse(key), value));
    } else {
      throw RsError(name: 'status code is ${resp.statusCode}');
    }
  }

  @override
  Future<Map<int, String>> getFacults() async =>
      _getList('https://schedule-backup.pwrshi.ru/facults.json');

  @override
  Future<Map<int, String>> getGroups(int faculty, int course) async =>
      _getList('https://schedule-backup.pwrshi.ru/$faculty-$course.json');

  @override
  Future<ScheduleService> getScheduleService(GroupId groupId) async {
    var resp = await getDio().get<String>(
        'https://schedule-backup.pwrshi.ru/${groupId.facult}-${groupId.course}-${groupId.group}.json');
    if (resp.statusCode == 200) {
      return ScheduleService.fromJson(json.decode(resp.data!));
    } else {
      throw RsError(name: 'status code is ${resp.statusCode}');
    }
  }
}
