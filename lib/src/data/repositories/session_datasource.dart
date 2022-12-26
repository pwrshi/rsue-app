import 'package:rsue_app/src/domain/entities/quiz_entity.dart';
import 'package:rsue_session_api/rsue_session_api.dart';

abstract class SessionDatasource {
  Future<Map<String, List<Quiz>>> getAllSchedules();
}

abstract class SessionLocalDatasource extends SessionDatasource {
  Future<void> setAllSchedules(Map<String, List<Quiz>> snapshot);
}
