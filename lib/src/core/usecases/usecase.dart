import 'package:rsue_app/src/core/api/response.dart';

abstract class UseCase<Type, Params> {
  Type call(Params params);
}
