import 'package:rsue_app/src/core/resources/data_state.dart';
import 'package:rsue_app/src/domain/entities/quiz_entity.dart';

abstract class SessionRepository {
  Future<DataState<Map<String, List<Quiz>>>> getSchedulesForAllGroups();
  Future<DataState<List<Quiz>>> getScheduleForGroup(String groupName);
}
