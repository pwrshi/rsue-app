import 'dart:convert';

import 'package:rsue_app/src/data/repositories/session_datasource.dart';
import 'package:rsue_app/src/domain/entities/quiz_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesSessionCacheDatasource
    implements SessionLocalDatasource {
  SharedPreferences? pref;

  Future<SharedPreferences> getPref() async {
    return pref ??= await SharedPreferences.getInstance();
  }

  @override
  Future<Map<String, List<Quiz>>> getAllSchedules() async {
    String? raw = (await getPref()).getString("sp_cache_all_schedules");
    Map<String, List<dynamic>> m = jsonDecode(raw!);

    return m.map((key, value) => MapEntry(
        key,
        value
            .map((e) => Quiz.fromJson(Map<String, dynamic>.from(e)))
            .toList()));
  }

  @override
  Future<void> setAllSchedules(Map<String, List<Quiz>> snapshot) async {
    (await getPref()).setString("sp_cache_all_schedules", jsonEncode(snapshot));
  }
}
