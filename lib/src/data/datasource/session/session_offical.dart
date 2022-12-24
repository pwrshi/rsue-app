import 'package:rsue_app/src/data/repositories/session_datasource.dart';
import 'package:rsue_app/src/domain/entities/quiz_entity.dart';
import 'package:rsue_session_api/rsue_session_api.dart';

class SessionImplDatasource extends SessionDatasource {
  @override
  Future<Map<String, List<Quiz>>> getAllSchedules() async =>
      (await RsueSessionApi().getAllSchedules()).asMap().map((key, value) =>
          MapEntry(value!.name,
              value.exams.map((e) => Quiz(name: e!.name)).toList()));
}
