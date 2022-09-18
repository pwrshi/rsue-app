import 'package:rsue_app/src/core/api/response.dart';
import 'package:rsue_app/src/core/resources/data_state.dart';
import 'package:rsue_app/src/domain/entities/payment_entity.dart';
import 'package:rsue_app/src/domain/entities/subject_entity.dart';

abstract class PortfolioRepository {
  //
  //  LOGIN
  //

  Future<DataState<void>> login(String username, String password);
  void logout();

  //
  //  FEATURES
  //

  Future<DataState<Map<String, String>>> whoami();
  Future<DataState<List<SubjectEntity>>> getAcademicPerfomance();
  Future<DataState<List<PaymentEntity>>> getPayments();
}
