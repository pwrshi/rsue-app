import 'error.dart';

class ResponseError extends RsError {
  const ResponseError({required String name})
      : super(name: "ResponseError: $name");
}
