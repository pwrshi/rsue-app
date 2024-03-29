import 'package:flutter/material.dart';
import 'package:rsue_app/src/core/api/response.dart';
import 'package:rsue_app/src/core/error/response_error.dart';
import 'package:rsue_app/src/core/resources/data_state.dart';
import 'package:rsue_app/src/core/usecases/usecase.dart';

abstract class DataSnapshot<T> extends ChangeNotifier
    implements UseCase<T, void, void> {
  Response<T> _data = const Response(status: ResponseStatus.init);

  Future<DataState<T>> call();
  void update(T t) {
    _data = Response(status: ResponseStatus.done, content: t);
    notifyListeners();
  }

  @override
  Future<void> tryUpdate({void args}) async {
    var result = await call();
    if (result is DataSuccess) {
      update(result.data as T);
    }
    if ((result is DataRestored) && (_data.status == ResponseStatus.error)) {
      update(result.data as T);
    }
  }

  @override
  Response<T> get({void args}) {
    if (_data.status == ResponseStatus.init) {
      _data = const Response(status: ResponseStatus.loading);
      call().then((value) {
        if (value is DataFailed) {
          _data = Response(status: ResponseStatus.error, error: value.error);
        } else if (value is DataRestored) {
          _data =
              Response(status: ResponseStatus.restored, content: value.data);
        } else if (value is DataSuccess) {
          _data = Response(status: ResponseStatus.done, content: value.data);
        } else {
          _data = const Response(
              status: ResponseStatus.error,
              error: ResponseError(name: 'Невозможный тип'));
        }
        notifyListeners();
      });
    }
    return _data;
  }
}
