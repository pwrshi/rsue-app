import 'package:rsue_app/src/core/resources/data_state.dart';
import 'package:rsue_app/src/core/usecases/usecase.dart';
import 'package:rsue_app/src/domain/repositories/schedule_repository.dart';

class GetFacults implements UseCase<DataState<Map<int, String>>, void> {
  GetFacults(this.repository);
  final ScheduleRepository repository;
  @override
  Future<DataState<Map<int, String>>> call(void _) => repository.getFacults();
}
