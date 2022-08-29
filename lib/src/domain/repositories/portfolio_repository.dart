import 'package:rsue_app/src/core/api/response.dart';

abstract class PortfolioRepository {
  Future<Response<void>> login(String username, String password);
  Future<Response<void>> logout();

  Future<Response> whoami();
  Future<Response> getAcademicPerfomance();
  Future<Response> getPayments();
}
