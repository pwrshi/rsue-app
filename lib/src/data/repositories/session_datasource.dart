import 'package:rsue_app/src/domain/entities/quiz_entity.dart';

abstract class SessionDatasource {
  Future<Map<String, List<Quiz>>> getAllSchedules();
}

abstract class SessionLocalDatasource extends SessionDatasource {
  Future<void> setAllSchedules(Map<String, List<Quiz>> snapshot);
}
