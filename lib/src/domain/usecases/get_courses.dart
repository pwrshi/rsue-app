import 'package:rsue_app/src/core/resources/data_state.dart';
import 'package:rsue_app/src/core/usecases/usecase.dart';
import 'package:rsue_app/src/domain/repositories/schedule_repository.dart';

class GetCourses implements UseCase<DataState<Map<int, String>>, int> {
  GetCourses(this.repository);
  final ScheduleRepository repository;
  @override
  Future<DataState<Map<int, String>>> call(int _) =>
      repository.getCoursesByFacultId(_);
}
