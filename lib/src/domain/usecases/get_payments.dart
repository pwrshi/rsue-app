import 'package:rsue_app/src/core/api/response.dart';
import 'package:rsue_app/src/core/usecases/usecase.dart';
import 'package:rsue_app/src/domain/entities/payment_entity.dart';
import 'package:rsue_app/src/domain/repositories/portfolio_repository.dart';

class GetPayments implements UseCase<List<PaymentEntity>, void> {
  GetPayments(this.repository);
  final PortfolioRepository repository;
  @override
  Future<Response<List<PaymentEntity>>> call(void _) =>
      repository.getPayments();
}
