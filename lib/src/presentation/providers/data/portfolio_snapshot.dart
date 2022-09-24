import 'package:rsue_app/src/core/resources/data_state.dart';
import 'package:rsue_app/src/domain/entities/payment_entity.dart';
import 'package:rsue_app/src/domain/entities/subject_entity.dart';
import 'package:rsue_app/src/domain/repositories/portfolio_repository.dart';
import 'package:rsue_app/src/presentation/providers/data/snapshot_interface.dart';

class PaymentSnapshot extends DataSnapshot<List<PaymentEntity>> {
  PaymentSnapshot(this.repo);
  PortfolioRepository repo;
  @override
  Future<DataState<List<PaymentEntity>>> call() {
    return repo.getPayments();
  }

  @override
  Future<void> tryUpdate() async {
    DataState<List<PaymentEntity>> result = await repo.getPayments();
    if (result is DataSuccess) {
      update(result.data!);
    }
  }
}

class WhoamiSnapshot extends DataSnapshot<Map<String, String>> {
  WhoamiSnapshot(this.repo);
  PortfolioRepository repo;
  @override
  Future<DataState<Map<String, String>>> call() {
    return repo.whoami();
  }

  @override
  Future<void> tryUpdate() async {
    DataState<Map<String, String>> result = await repo.whoami();
    if (result is DataSuccess) {
      update(result.data!);
    }
  }
}

class AcademicPerfomanceSnapshot
    extends DataSnapshot<Map<String, List<SubjectEntity>>> {
  AcademicPerfomanceSnapshot(this.repo);
  PortfolioRepository repo;
  @override
  Future<DataState<Map<String, List<SubjectEntity>>>> call() {
    return repo.getAcademicPerfomance();
  }

  @override
  Future<void> tryUpdate() async {
    DataState<Map<String, List<SubjectEntity>>> result =
        await repo.getAcademicPerfomance();
    if (result is DataSuccess) {
      update(result.data!);
    }
  }
}
