import 'package:hive/hive.dart';
import 'package:rsue_app/src/core/get_hive_box.dart';
import 'package:rsue_app/src/data/repositories/portfolio_datasource.dart';
import 'package:rsue_app/src/domain/entities/subject_entity.dart';
import 'package:rsue_app/src/domain/entities/payment_entity.dart';

class PortfolioCacheDatasource implements PortfolioLocalDatasource {
  var storageAcademicPerfomance =
      openHiveBox<Map<String, List<SubjectEntity>>>('portfolio_cache_datasource_get_academic_perfomance');
  var storagePayments =
      openHiveBox<List<PaymentEntity>>('portfolio_cache_datasource_get_payments');
  var storageWhoami =
      openHiveBox<Map<String, String>>('portfolio_cache_datasource_get_whoami');
  var storageOfCredentials =  openHiveBox<(String, String)>('portfolio_cache_datasource_credentials'); 

  @override
  checkCredentials(String username, String password) async {
    return (await storageOfCredentials).get(username)?.$1 == password;
  }

  @override
  getAcademicPerfomance(
      String username, String password) async {
    return (await storageAcademicPerfomance).get((username, password))!;
  }

  @override
  getPayments(String username, String password) async {
    return (await storagePayments).get((username, password))!;
  }

  @override
  getLastCredentials() async {
    return (await storageOfCredentials).get('_');
  }
  
  @override
  Future<Map<String, String>> getWhoami(String username, String password) async {
    return (await storageWhoami).get((username, password))!;
  }
  
  @override
  Future<void> setAcademicPerfomance(String username, String password, Map<String, List<SubjectEntity>> snapshot) async {
    return (await storageAcademicPerfomance).put((username, password), snapshot);
  }
  
  @override
  Future<void> setLastCredentials(String username, String password) async {
    (await storageOfCredentials)
    ..put('_',(username, password))
    ..put(username, (username, password));
  }
  
  @override
  Future<void> setPayments(String username, String password, List<PaymentEntity> snapshot) async {
    return (await storagePayments).put((username, password), snapshot);
  }
  
  @override
  Future<void> setWhoami(String username, String password, Map<String, String> snapshot) async {
    return (await storageWhoami).put((username, password), snapshot);
  }
}
