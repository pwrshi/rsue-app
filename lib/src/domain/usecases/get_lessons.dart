import 'package:rsue_app/src/core/resources/data_state.dart';
import 'package:rsue_app/src/core/usecases/usecase.dart';
import 'package:rsue_app/src/domain/repositories/schedule_repository.dart';
import 'package:rsue_app/src/domain/entities/lesson_entity.dart';

class GetLessons implements UseCase<DataState<List<ConcreteLesson>>, DateTime> {
  GetLessons(this.repository);
  final ScheduleRepository repository;
  @override
  Future<DataState<List<ConcreteLesson>>> call(DateTime date) =>
      repository.getLessonsOnDay(date);
}
