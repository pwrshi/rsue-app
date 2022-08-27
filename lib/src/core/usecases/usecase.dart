import 'package:rsue_app/src/core/api/response.dart';

abstract class UseCase<Type, Params> {
  Future<Response<Type>> call(Params params);
}
