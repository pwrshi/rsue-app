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
    SubjectEntity? subject;
    var arrayOfSubjects = apssnap.content?.entries.toList()[0].value;

    if (arrayOfSubjects != null) {
      for (var s in arrayOfSubjects) {
        if (s.name == args) {
          subject = s;
        }
      }
    }

    // .fold<SubjectEntity?>(
    //     null, (prev, el) => (el.name == args ? el : null));

    Quiz? quiz;
    var arrayOfQuizes = ssnap.content?.$1;

    if (arrayOfQuizes != null) {
      for (var q in arrayOfQuizes) {
        if (q.name == args) {
          quiz = q;
        }
      }
    }

    // .fold<Quiz?>(null, (prev, el) => (el.name == args ? el : null))

    Response<SubjectEntity> rsubject = Response(
        status:
            (((apssnap.status == ResponseStatus.done) && (subject != null)) ||
                    ((apssnap.status == ResponseStatus.restored) &&
                        (subject != null)))
                ? apssnap.status
                : ResponseStatus.error,
        content: subject);
    Response<Quiz> rquiz = Response(
        status: (((ssnap.status == ResponseStatus.done) && (quiz != null)) ||
                ((ssnap.status == ResponseStatus.restored) &&
                    (subject == null)))
            ? ssnap.status
            : ResponseStatus.error,
        content: quiz);

    return Response(
        status: ResponseStatus.done,
        content: SubjectSummary(subject: rsubject, quiz: rquiz));
  }

  @override
  Future<void> tryUpdate({void args}) async {
    aps.tryUpdate();
    session.tryUpdate();
  }
}
