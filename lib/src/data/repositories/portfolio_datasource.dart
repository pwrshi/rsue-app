import 'package:rsue_app/src/domain/entities/payment_entity.dart';
import 'package:rsue_app/src/domain/entities/subject_entity.dart';

abstract class PortfolioDataSource {
  Future<bool> checkCredentials(String username, String password);
  Future<List<SubjectEntity>> getAcademicPerfomance(
      String username, String password);
  Future<List<PaymentEntity>> getPayments(String username, String password);
  Future<Map<String, String>> whoami(String username, String password);
}
