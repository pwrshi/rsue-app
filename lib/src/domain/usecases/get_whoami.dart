import 'package:rsue_app/src/core/resources/data_state.dart';
import 'package:rsue_app/src/core/usecases/usecase.dart';
import 'package:rsue_app/src/domain/repositories/portfolio_repository.dart';

class GetWhoami implements UseCase<DataState<Map<String, String>>, void> {
  GetWhoami(this.repository);
  final PortfolioRepository repository;
  @override
  Future<DataState<Map<String, String>>> call(_) => repository.whoami();
}
