import 'package:rsue_app/src/domain/entities/lesson_entity.dart';
import 'package:rsue_app/src/domain/entities/group_entity.dart';
import 'package:rsue_app/src/core/api/response.dart';
import 'package:rsue_app/src/domain/repositories/schedule_repository.dart';

class ScheduleRepositoryImpl implements ScheduleRepository {
  @override
  Future<Response<Group>> getGroups() {
    // TODO: implement getGroups
    throw UnimplementedError();
  }

  @override
  Future<Response<List<LessonEntity>>> getLessonsOnDay(DateTime date) {
    // TODO: implement getLessonsOnDay
    throw UnimplementedError();
  }

  @override
  Future<Response<void>> setGroup(Group group) {
    // TODO: implement setGroup
    throw UnimplementedError();
  }

  @override
  Future<Response<void>> unsetGroup() {
    // TODO: implement unsetGroup
    throw UnimplementedError();
  }
}
