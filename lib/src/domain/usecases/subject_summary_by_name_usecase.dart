import 'package:rsue_app/src/core/api/response.dart';
import 'package:rsue_app/src/core/error/usecase_error.dart';
import 'package:rsue_app/src/core/usecases/usecase.dart';
import 'package:rsue_app/src/domain/entities/quiz_entity.dart';
import 'package:rsue_app/src/domain/entities/subject_entity.dart';
import 'package:rsue_app/src/domain/usecases/portfolio_snapshot.dart';
import 'package:rsue_app/src/domain/usecases/session_by_whoami_usecase.dart';

class SubjectSummary {
  SubjectSummary({required this.subject, required this.quiz});
  Response<SubjectEntity> subject;
  Response<Quiz> quiz;
}

// TODO: переписать с records
class SubjectSummaryByNameUseCase
    implements UseCase<SubjectSummary, void, String> {
  SubjectSummaryByNameUseCase({required this.aps, required this.session});
  AcademicPerfomanceSnapshot aps;
  SessionByWhoamiUseCase session;
  @override
  Response<SubjectSummary> get({String? args}) {
    var ssnap = session.get();
    var apssnap = aps.get();
    if (args == null) {
      return const Response(
          status: ResponseStatus.error,
          error: UseCaseError(name: "Нет аргумента"));
    }
    SubjectEntity? subject = apssnap.content?[0]?.fold<SubjectEntity?>(
        null, (prev, el) => (el.name == args ? el : null));

    Quiz? quiz = ssnap.content?.$1.fold<Quiz?>(null, (prev, el) {
      print(el.toString());
      return (el.name == args ? el : null);
    });

    Response<SubjectEntity> rsubject = Response(
        status:
            (((apssnap.status == ResponseStatus.done) && (subject == null)) ||
                    ((apssnap.status == ResponseStatus.restored) &&
                        (subject == null)))
                ? ResponseStatus.error
                : apssnap.status,
        content: subject);
    Response<Quiz> rquiz = Response(
        status: (((ssnap.status == ResponseStatus.done) && (subject == null)) ||
                ((ssnap.status == ResponseStatus.restored) &&
                    (subject == null)))
            ? ResponseStatus.error
            : ssnap.status,
        content: quiz);

    return Response(
        status: ResponseStatus.done,
        content: SubjectSummary(subject: rsubject, quiz: rquiz));
  }

  @override
  Future<void> tryUpdate({void args}) async {
    aps?.tryUpdate();
    session?.tryUpdate();
  }
}
