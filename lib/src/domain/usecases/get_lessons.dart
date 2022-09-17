import 'package:rsue_app/src/core/usecases/usecase.dart';
import 'package:rsue_app/src/domain/repositories/schedule_repository.dart';
import 'package:rsue_app/src/domain/entities/lesson_entity.dart';

class GetLessons implements UseCase<Future<List<ConcreteLesson>>, DateTime> {
  GetLessons(this.repository);
  final ScheduleRepository repository;
  @override
  Future<List<ConcreteLesson>> call(DateTime date) =>
      repository.getLessonsOnDay(date);
}
