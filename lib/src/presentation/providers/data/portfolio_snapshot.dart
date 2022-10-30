import 'package:rsue_app/src/core/error/error.dart';
import 'package:rsue_app/src/core/resources/data_state.dart';
import 'package:rsue_app/src/domain/entities/payment_entity.dart';
import 'package:rsue_app/src/domain/entities/subject_entity.dart';
import 'package:rsue_app/src/domain/repositories/portfolio_repository.dart';
import 'package:rsue_app/src/presentation/providers/data/snapshot_interface.dart';

const reposNotFound = DataSnapshotError(name: "Репозиторий не найден");

class DataSnapshotError extends RsError {
  const DataSnapshotError({required String name})
      : super(name: "DataSnapshotErr: $name");
}

class PaymentSnapshot extends DataSnapshot<List<PaymentEntity>> {
  PaymentSnapshot(this.repo);
  PortfolioRepository? repo;
  @override
  Future<DataState<List<PaymentEntity>>> call() async {
    return await repo?.getPayments() ?? const DataFailed(error: reposNotFound);
  }

  @override
  Future<void> tryUpdate() async {
    DataState<List<PaymentEntity>> result =
        await repo?.getPayments() ?? const DataFailed(error: reposNotFound);
    if (result is DataSuccess) {
      update(result.data!);
    }
  }
}

class WhoamiSnapshot extends DataSnapshot<Map<String, String>> {
  WhoamiSnapshot(this.repo);
  PortfolioRepository? repo;
  @override
  Future<DataState<Map<String, String>>> call() async {
    return await repo?.whoami() ?? const DataFailed(error: reposNotFound);
  }

  @override
  Future<void> tryUpdate() async {
    DataState<Map<String, String>> result =
        await repo?.whoami() ?? const DataFailed(error: reposNotFound);
    if (result is DataSuccess) {
      update(result.data!);
    }
  }
}

class AcademicPerfomanceSnapshot
    extends DataSnapshot<Map<String, List<SubjectEntity>>> {
  AcademicPerfomanceSnapshot(this.repo);
  PortfolioRepository? repo;
  @override
  Future<DataState<Map<String, List<SubjectEntity>>>> call() async {
    return await repo?.getAcademicPerfomance() ??
        const DataFailed(error: reposNotFound);
  }

  @override
  Future<void> tryUpdate() async {
    DataState<Map<String, List<SubjectEntity>>> result =
        await repo?.getAcademicPerfomance() ??
            const DataFailed(error: reposNotFound);
    if (result is DataSuccess) {
      update(result.data!);
    }
  }
}
