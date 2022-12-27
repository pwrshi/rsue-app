import 'package:rsue_app/src/core/api/response.dart';

abstract class UseCase<T, P> {
  Response<T> get data;
  Future<void> tryUpdate(P args);
}
