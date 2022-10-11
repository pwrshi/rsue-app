import 'package:rsue_app/src/core/resources/data_state.dart';
import 'package:rsue_app/src/domain/entities/schedule_service.dart';
import 'package:rsue_app/src/domain/repositories/schedule_repository.dart';
import 'package:rsue_app/src/domain/usecases/data/portfolio_snapshot.dart';
import 'package:rsue_app/src/domain/usecases/data/snapshot_interface.dart';

const reposNotFound = DataSnapshotError(name: "Репозиторий не найден");

class ScheduleServiceSnapshot extends DataSnapshot<ScheduleService> {
  ScheduleServiceSnapshot(this.repo);
  ScheduleRepository? repo;

  @override
  Future<DataState<ScheduleService>> call() async {
    return await repo?.getScheduleService() ??
        const DataFailed(error: reposNotFound);
  }
}
