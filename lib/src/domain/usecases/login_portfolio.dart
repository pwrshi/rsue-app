import 'package:rsue_app/src/core/resources/data_state.dart';
import 'package:rsue_app/src/core/usecases/usecase.dart';
import 'package:rsue_app/src/domain/repositories/portfolio_repository.dart';

class GetWhoami implements UseCase<DataState<void>, (String, String)> {
  GetWhoami(this.repository);
  final PortfolioRepository repository;
  @override
  Future<DataState<void>> call(meta) => repository.login(meta.$0, meta.$1);
}
