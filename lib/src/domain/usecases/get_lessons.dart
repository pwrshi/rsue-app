import 'package:rsue_app/src/core/api/response.dart';
import 'package:rsue_app/src/core/usecases/usecase.dart';
import 'package:rsue_app/src/domain/repositories/schedule_repository.dart';
import 'package:rsue_app/src/domain/entities/lesson_entity.dart';

class GetLessons implements UseCase<List<LessonEntity>, DateTime> {
  GetLessons(this.repository);
  final ScheduleRepository repository;
  @override
  Future<Response<List<LessonEntity>>> call(DateTime date) =>
      repository.getLessonsOnDay(date);
}
