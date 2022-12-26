import 'package:rsue_app/src/core/error/error.dart';
import 'package:rsue_app/src/core/error/repository_error.dart';
import 'package:rsue_app/src/core/error/response_error.dart';
import 'package:rsue_app/src/core/resources/data_state.dart';

abstract class RepositoryBase {
  Future<DataState<T>> invokeDSs<T>(
      Future<T?> onlineDs,
      Future<T?> localDs,
      Future<void> Function(T snapshot) saveDsCallback,
      String localErr,
      String onlineErr) async {
    DataState<T> result;
    try {
      var snapshot = await onlineDs;
      if (snapshot == null) {
        throw const RepositoryError(name: "no data");
      }
      saveDsCallback(snapshot);
      result = DataSuccess(data: snapshot);
    } catch (onlineErr) {
      if (onlineErr is RsError) {
        result = DataFailed(error: onlineErr);
      } else {
        result = DataFailed(error: RepositoryError(name: onlineErr.toString()));
      }

      // попытка взять из локального источника
      try {
        var localSnap = await localDs;
        if (localSnap == null) {
          throw const ResponseError(name: "no local data");
        }
        result = DataRestored(data: localSnap);
      } catch (localErr) {
        if (localErr is RsError) {
          result = DataFailed(error: localErr);
        } else {
          result =
              DataFailed(error: RepositoryError(name: localErr.toString()));
        }
      }
    }
    return result;
  }
}
