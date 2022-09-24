import 'package:rsue_app/src/core/error/error.dart';
import 'package:rsue_app/src/core/error/response_error.dart';

class Response<T> {
  const Response({
    required this.status,
    this.error,
    this.content,
  });
  final ResponseStatus status;
  final RsError? error;
  final T? content;
}

enum ResponseStatus { init, loading, error, done, restored }
