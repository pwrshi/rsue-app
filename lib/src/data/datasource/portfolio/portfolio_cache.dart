import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:rsue_app/src/core/get_hive_box.dart';
import 'package:rsue_app/src/data/repositories/portfolio_datasource.dart';
import 'package:rsue_app/src/domain/entities/subject_entity.dart';
import 'package:rsue_app/src/domain/entities/payment_entity.dart';

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

class StoragePaymentsAdapter extends TypeAdapter<PaymentEntity> {
  @override
  final typeId = 1;

  @override
  read(BinaryReader reader) {
    var li = jsonDecode(reader.readString()) as Map<String, dynamic>;
    return PaymentEntity.fromJson(li);
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
    var li = reader.readString();
    return SubjectEntity.fromJson(jsonDecode(li ) as Map<String, dynamic>);
  }

  @override
  void write(BinaryWriter writer, SubjectEntity obj) {
    writer.writeString(jsonEncode(obj));
  }
}

class PortfolioCacheDatasource implements PortfolioLocalDatasource {

  var storageAcademicPerfomance =
      openHiveBox<Map<String, List<SubjectEntity>>>('cache_datasource_get_academic_perfomance');
  var storagePayments =
      openHiveBox<List<PaymentEntity>>('cache_datasource_get_payments');
  var storageWhoami =
      openHiveBox<Map<String, String>>('cache_datasource_get_whoami');
  var storageOfCredentials =  openHiveBox<(String, String)>('offical_portfolio_cache_datasource_credentials'); 

  @override
  checkCredentials(String username, String password) async {
    return (await storageOfCredentials).get(username)?.$1 == password;
  }

  @override
  getAcademicPerfomance(
      String username, String password) async {
    return (await storageAcademicPerfomance).get(username);
  }

  @override
  getPayments(String username, String password) async {
    return (await storagePayments).get(username);
  }

  @override
  getLastCredentials() async {
    return (await storageOfCredentials).get('_');
  }
  
  @override
getWhoami(String username, String password) async {
    return (await storageWhoami).get(username) as Map<String, String>;
  }
  
  @override
  Future<void> setAcademicPerfomance(String username, String password, Map<String, List<SubjectEntity>> snapshot) async {
    return (await storageAcademicPerfomance).put(username, snapshot);
  }
  
  @override
  Future<void> setLastCredentials(String username, String password) async {
    (await storageOfCredentials)
    ..put('_',(username, password))
    ..put(username, (username, password));
  }
  
  @override
  Future<void> setPayments(String username, String password, List<PaymentEntity> snapshot) async {
    return (await storagePayments).put(username, snapshot);
  }
  
  @override
  Future<void> setWhoami(String username, String password, Map<String, String> snapshot) async {
    return (await storageWhoami).put(username, snapshot);
  }
}
