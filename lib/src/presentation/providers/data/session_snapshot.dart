import 'package:rsue_app/src/core/resources/data_state.dart';
import 'package:rsue_app/src/domain/entities/quiz_entity.dart';
import 'package:rsue_app/src/domain/repositories/session_repository.dart';
import 'package:rsue_app/src/presentation/providers/data/portfolio_snapshot.dart';
import 'package:rsue_app/src/presentation/providers/data/snapshot_interface.dart';

const reposNotFound = DataSnapshotError(name: "Репозиторий не найден");

class SessionsSnapshot extends DataSnapshot<Map<String, List<Quiz>>> {
  SessionsSnapshot(this.repo);
  SessionRepository? repo;

  @override
  Future<DataState<Map<String, List<Quiz>>>> call() async {
    return await repo?.getSchedulesForAllGroups() ??
        const DataFailed(error: reposNotFound);
  }
}
