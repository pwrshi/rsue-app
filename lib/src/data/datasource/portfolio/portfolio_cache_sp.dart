import 'dart:async';
import 'dart:convert';

import 'package:rsue_app/src/data/repositories/portfolio_datasource.dart';
import 'package:rsue_app/src/domain/entities/subject_entity.dart';
import 'package:rsue_app/src/domain/entities/payment_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesPortfolioCacheDatasource implements PortfolioLocalDatasource {
  SharedPreferences? pref;
  Future<SharedPreferences> getPref() async {
      return pref ??= await SharedPreferences.getInstance();
  }
  @override
  Future<bool> checkCredentials(String username, String password) async {
    return (await getPref()).getString(username) == password;
  }

  @override
  Future<Map<String, List<SubjectEntity>>?> getAcademicPerfomance(String username, String password) async {
    var raw = (await getPref()).getString("ap_cache_for_$username");
    if (raw != null) {
      var json = Map<String, List<dynamic>>.from(jsonDecode(raw));
      Map<String, List<SubjectEntity>> result = {};
      for (var semestr in json.entries) {
        List<SubjectEntity> list = [];
        for (var subjectRaw in semestr.value) {
          list.add(SubjectEntity.fromJson(Map<String, Object?>.from(subjectRaw)));
        }
        result[semestr.key] = list;
      }
      return result;
    }
    return null;
  }

  @override
  getLastCredentials() async {
    var raw = (await getPref()).getStringList("lc_cache");
    String? login = raw?[0], password = raw?[1];
    if ((login != null) ||( password != null)) {
      return (login!, password!);
    }
    return null;
  }

  @override
  Future<List<PaymentEntity>?> getPayments(String username, String password) async {
    var los = (await getPref()).getStringList("ps_cache_for_$username");
    if (los == null) {
      return null;
    }
    return los.map((e) => PaymentEntity.fromJson(json.decode(e) as Map<String, Object?>)).toList();
  }

  @override
  Future<Map<String, String>?> getWhoami(String username, String password)async {
    var raw = (await getPref()).getString("wi_cache_for_$username");
    if (raw == null) {
      return null;
    }
    return Map<String, String>.from(json.decode(raw));
  }

  @override
  Future<void> setAcademicPerfomance(String username, String password, Map<String, List<SubjectEntity>> snapshot) async{
    (await getPref()).setString("ap_cache_for_$username", json.encode(snapshot));
  }

  @override
  Future<void> setLastCredentials(String username, String password) async {
    (await getPref()).setStringList("lc_cache", [username, password]);
  }

  @override
  Future<void> setPayments(String username, String password, List<PaymentEntity> snapshot) async {
    (await getPref()).setStringList("ps_cache_for_$username", snapshot.map((e) => json.encode(e)).toList());
  }

  @override
  Future<void> setWhoami(String username, String password, Map<String, String> snapshot) async {
    (await getPref()).setString("wi_cache_for_$username", json.encode(snapshot));
  }
  
}