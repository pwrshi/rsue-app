import 'package:rsue_app/src/core/error/repository_error.dart';
import 'package:rsue_app/src/data/repositories/repository_template.dart';
import 'package:rsue_app/src/data/repositories/session_datasource.dart';
import 'package:rsue_app/src/domain/entities/quiz_entity.dart';
import 'package:rsue_app/src/core/resources/data_state.dart';
import 'package:rsue_app/src/domain/repositories/session_repository.dart';

class SessionRepositoryImpl extends RepositoryBase
    implements SessionRepository {
  SessionRepositoryImpl(this.datasource, this.localDatasource);

  SessionDatasource datasource;
  SessionLocalDatasource localDatasource;
  @override
  Future<DataState<List<Quiz>>> getScheduleForGroup(String groupName) async {
    var snap = await invokeDSs<Map<String, List<Quiz>>>(
        datasource.getAllSchedules(),
        localDatasource.getAllSchedules(),
        (snapshot) => localDatasource.setAllSchedules(snapshot),
        "Ошибка бэкапа сессии",
        "Ошибка скачивания сессии");
    if (snap is DataSuccess) {
      var sch = snap.data?[groupName];
      return (sch == Null
          ? const DataFailed(
              error: RepositoryError(name: "Нет такой группы (("))
          : DataSuccess(data: sch));
    }
    return DataFailed(error: snap.error);
  }

  @override
  Future<DataState<Map<String, List<Quiz>>>> getSchedulesForAllGroups() {
    return invokeDSs<Map<String, List<Quiz>>>(
        datasource.getAllSchedules(),
        localDatasource.getAllSchedules(),
        (snapshot) => localDatasource.setAllSchedules(snapshot),
        "Ошибка бэкапа сессии",
        "Ошибка скачивания сессии");
  }
}
