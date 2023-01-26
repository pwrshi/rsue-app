import 'package:rsue_app/src/data/repositories/session_datasource.dart';
import 'package:rsue_app/src/domain/entities/quiz_entity.dart';
import 'package:rsue_session_api/api.dart';
import 'package:rsue_session_api/rsue_session_api.dart';

class SessionImplDatasource extends SessionDatasource {
  SessionType _convertEnums(MarkType type) {
    switch (type) {
      case MarkType.credit:
        return SessionType.credit;
      case MarkType.exam:
        return SessionType.exam;
      case MarkType.practise:
        return SessionType.practise;
    }
  }

  @override
  Future<Map<String, List<Quiz>>> getAllSchedules() async =>
      (await RsueSessionApi().getAllSchedules()).asMap().map((key, value) =>
          MapEntry(
              value!.name,
              value.exams
                  .map<Quiz>((SubjectInfo? e) => Quiz(
                      name: e!.name,
                      dateTime: e.dateTime,
                      rooms: e.rooms?.join(", "),
                      teachers: e.teachers?.join(", "),
                      type: _convertEnums(e.mark)))
                  .toList()));
}
