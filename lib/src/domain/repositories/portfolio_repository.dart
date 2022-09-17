import 'package:rsue_app/src/core/api/response.dart';
import 'package:rsue_app/src/domain/entities/payment_entity.dart';
import 'package:rsue_app/src/domain/entities/subject_entity.dart';

abstract class PortfolioRepository {
  //
  //  LOGIN
  //

  Future<void> login(String username, String password);
  Response<void> logout();

  //
  //  FEATURES
  //

  Future whoami();
  Future<List<SubjectEntity>> getAcademicPerfomance();
  Future<List<PaymentEntity>> getPayments();
}
