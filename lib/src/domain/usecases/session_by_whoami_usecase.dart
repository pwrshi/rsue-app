import 'package:rsue_app/src/core/api/response.dart';
import 'package:rsue_app/src/core/usecases/usecase.dart';
import 'package:rsue_app/src/domain/entities/quiz_entity.dart';
import 'package:rsue_app/src/domain/usecases/portfolio_snapshot.dart';
import 'package:rsue_app/src/domain/usecases/sessions_snapshot.dart';

class SessionByWhoamiUseCase implements UseCase<(String, List<Quiz>), void, void> {
  SessionByWhoamiUseCase({this.sessions, this.whoami});

  WhoamiSnapshot? whoami;
  SessionsSnapshot? sessions;

  @override
  Response<(String, List<Quiz>)> get({void args}) {
    if ((whoami == null) ||
        (sessions == null) ||
        (sessions?.get().status == ResponseStatus.init) ||
        (whoami?.get().status == ResponseStatus.init)) {
      return const Response(status: ResponseStatus.init);
    } else if ((whoami!.get().status == ResponseStatus.loading) ||
        (sessions!.get().status == ResponseStatus.loading)) {
      return const Response(status: ResponseStatus.loading);
    } else if ((sessions!.get().status == ResponseStatus.error) ||
        (whoami!.get().status == ResponseStatus.error)) {
      return const Response(status: ResponseStatus.error);
    } else {
      if (whoami!.get().status == ResponseStatus.done) {
        var groupName = whoami!.get().content?["Группа"];
        if (sessions!.get().content!.containsKey(groupName)) {
          var p =
              sessions!.get().content![whoami!.get().content?["Группа"]];
          return Response(status: ResponseStatus.done, content: (groupName!, p!));
        }
      } 
    }
    return const Response(status: ResponseStatus.error, error: DataSnapshotError(name: "группа не найдена"));
  }

  @override
    Future<void> tryUpdate({void args}) async {
   whoami?.tryUpdate();
   sessions?.tryUpdate();
  }
}
