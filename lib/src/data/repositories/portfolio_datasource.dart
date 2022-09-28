import 'package:rsue_app/src/domain/entities/payment_entity.dart';
import 'package:rsue_app/src/domain/entities/subject_entity.dart';

abstract class PortfolioDatasource {
  Future<bool> checkCredentials(String username, String password);
  Future<Map<String, List<SubjectEntity>>?> getAcademicPerfomance(
      String username, String password);
  Future<List<PaymentEntity>?> getPayments(String username, String password);
  Future<Map<String, String>?> getWhoami(String username, String password);
}

abstract class PortfolioLocalDatasource extends PortfolioDatasource {
  // Работа с хранилищем логинов
  Future<(String, String)?> getLastCredentials();

  // Методы для записи
  Future<void> setLastCredentials(String username, String password);
  Future<void> setAcademicPerfomance(
      String username, String password, Map<String, List<SubjectEntity>> snapshot);
  Future<void> setPayments(String username, String password, List<PaymentEntity> snapshot);
  Future<void> setWhoami(String username, String password, Map<String, String> snapshot);
}