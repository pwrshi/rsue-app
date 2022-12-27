import 'package:rsue_app/src/core/api/response.dart';
import 'package:rsue_app/src/core/resources/data_state.dart';
import 'package:rsue_app/src/core/usecases/usecase.dart';
import 'package:rsue_app/src/domain/entities/quiz_entity.dart';
import 'package:rsue_app/src/domain/usecases/portfolio_snapshot.dart';
import 'package:rsue_app/src/domain/usecases/session_snapshot.dart';
import 'package:rsue_app/src/core/usecases/snapshot.dart';

class GetSessionForMyGroupSnapshot implements UseCase<(String, List<Quiz>), void> {
  GetSessionForMyGroupSnapshot({this.sessions, this.whoami});

  WhoamiSnapshot? whoami;
  SessionsSnapshot? sessions;

  @override
  Response<(String, List<Quiz>)> get data {
    if ((whoami == null) ||
        (sessions == null) ||
        (sessions?.data.status == ResponseStatus.init) ||
        (whoami?.data.status == ResponseStatus.init)) {
      return const Response(status: ResponseStatus.init);
    } else if ((whoami!.data.status == ResponseStatus.loading) ||
        (sessions!.data.status == ResponseStatus.loading)) {
      return const Response(status: ResponseStatus.loading);
    } else if ((sessions!.data.status == ResponseStatus.error) ||
        (whoami!.data.status == ResponseStatus.error)) {
      return const Response(status: ResponseStatus.error);
    } else {
      if (whoami!.data.status == ResponseStatus.done) {
        var groupName = whoami!.data.content?["Группа"];
        if (sessions!.data.content!.containsKey(groupName)) {
          var p =
              sessions!.data.content![whoami!.data.content?["Группа"]];
          return Response(status: ResponseStatus.done, content: (groupName!, p!));
        }
      } 
    }
    return const Response(status: ResponseStatus.error, error: DataSnapshotError(name: "группа не найдена"));
  }

  @override
  Future<void> tryUpdate(args) async {
   whoami?.tryUpdate(args);
   sessions?.tryUpdate(args);
  }
}
