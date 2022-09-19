import 'package:rsue_app/src/core/resources/data_state.dart';
import 'package:rsue_app/src/core/usecases/usecase.dart';
import 'package:rsue_app/src/domain/entities/payment_entity.dart';
import 'package:rsue_app/src/domain/repositories/portfolio_repository.dart';

class GetPayments implements UseCase<DataState<Map<String, String>>, void> {
  GetPayments(this.repository);
  final PortfolioRepository repository;
  @override
  Future<DataState<Map<String, String>>> call(void _) => repository.whoami();
}
