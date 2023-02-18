import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:rsue_app/src/data/repositories/portfolio_datasource.dart';
import 'package:rsue_app/src/domain/entities/subject_entity.dart';
import 'package:rsue_app/src/domain/entities/payment_entity.dart';

Future<LazyBox<T>> _openHiveBox<T>(String boxName) async {


  return await Hive.openLazyBox<T>(boxName);
}
Future<void> initHive() async {
    if (!kIsWeb) {
    await Hive.initFlutter();
  }
  Hive.registerAdapter(StorageAcademicPerfomanceAdapter());
  Hive.registerAdapter(StoragePaymentsAdapter());
  Hive.registerAdapter(StorageOfCredentialsAdapter());
  //Hive.registerAdapter(WhoamiAdapter());
  await _openHiveBox<Map<String, List<SubjectEntity>>>('cache_datasource_get_academic_perfomance');
  await _openHiveBox<List<PaymentEntity>>('cache_datasource_get_payments');
  await _openHiveBox<Map>('_cache_datasource_get_whoami');
  await _openHiveBox<(String, String)>('offical_portfolio_cache_datasource_credentials'); 
}

// adapters
class StorageOfCredentialsAdapter extends TypeAdapter<(String, String)> {
  @override
  final typeId = 0;

  @override
  read(BinaryReader reader) {
    var li = reader.readStringList();
    return (li.first, li.last);
  }

  @override
  void write(BinaryWriter writer, (String, String) obj) {
    writer.writeStringList([obj.$0, obj.$1], writeLength: true);
  }
}

class WhoamiAdapter extends TypeAdapter<Map<String, String>> {
  @override
  final typeId = 3;

  @override
  read(BinaryReader reader) {
    var map = Map<String, String>.from(reader.readMap());
    return map;
  }

  @override
  void write(BinaryWriter writer,  obj) {
    writer.writeMap(obj);
  }
}


class StoragePaymentsAdapter extends TypeAdapter<PaymentEntity> {
  @override
  final typeId = 1;

  @override
  read(BinaryReader reader) {
    var li = jsonDecode(reader.readString());
    if (kDebugMode) {
      print(li);
    }
    var de = PaymentEntity.fromJson(li);
    return de;
  }

  @override
  void write(BinaryWriter writer, PaymentEntity obj) {
    writer.writeString(jsonEncode(obj));
  }
}
class StorageAcademicPerfomanceAdapter extends TypeAdapter<SubjectEntity> {
  @override
  final typeId = 2;

  @override
  read(BinaryReader reader) {
    var li = jsonDecode(reader.readString() );
        if (kDebugMode) {
          print(li);
        }
    var de = SubjectEntity.fromJson( li);
    if (kDebugMode) {
      print(de);
    }
    return de;
  }

  @override
  void write(BinaryWriter writer, SubjectEntity obj) {
    writer.writeString(jsonEncode(obj));
  }
}

class HivePortfolioCacheDatasource implements PortfolioLocalDatasource {

  var storageAcademicPerfomance =
      Hive.lazyBox<Map<String, List<SubjectEntity>>>('cache_datasource_get_academic_perfomance');
  var storagePayments =
      Hive.lazyBox<List<PaymentEntity>>('cache_datasource_get_payments');
  var storageWhoami =
      Hive.lazyBox<Map<String, String>>('_cache_datasource_get_whoami');
  var storageOfCredentials =  Hive.lazyBox<(String, String)>('offical_portfolio_cache_datasource_credentials'); 

  @override
  checkCredentials(String username, String password) async {
    return (await storageOfCredentials.get(username))?.$1 == password;
  }

  @override
  getAcademicPerfomance(
      String username, String password) async {
    return (storageAcademicPerfomance).get(username);
  }

  @override
  getPayments(String username, String password) async {
    return (storagePayments).get(username);
  }

  @override
  getLastCredentials() async {
    return (storageOfCredentials).get('_');
  }
  
  @override
getWhoami(String username, String password) async {
    return (storageWhoami).get(username);
  }
  
  @override
  Future<void> setAcademicPerfomance(String username, String password, Map<String, List<SubjectEntity>> snapshot) async {
    return (storageAcademicPerfomance).put(username, snapshot);
  }
  
  @override
  Future<void> setLastCredentials(String username, String password) async {
    (storageOfCredentials)
    ..put('_',(username, password))
    ..put(username, (username, password));
  }
  
  @override
  Future<void> setPayments(String username, String password, List<PaymentEntity> snapshot) async {
    return (storagePayments).put(username, snapshot);
  }
  
  @override
  Future<void> setWhoami(String username, String password, Map<String, String> snapshot) async {
    return (storageWhoami).put(username, snapshot);
  }
}
