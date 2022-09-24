import 'package:rsue_app/src/core/resources/data_state.dart';
import 'package:rsue_app/src/core/usecases/usecase.dart';
import 'package:rsue_app/src/domain/entities/subject_entity.dart';
import 'package:rsue_app/src/domain/repositories/portfolio_repository.dart';

class GetAcademicPerfomance
    implements UseCase<DataState<Map<String, List<SubjectEntity>>>, void> {
  GetAcademicPerfomance(this.repository);
  final PortfolioRepository repository;
  @override
  Future<DataState<Map<String, List<SubjectEntity>>>> call(void _) =>
      repository.getAcademicPerfomance();
}
