import 'error.dart';

class RepositoryError extends RsError {
  const RepositoryError({required String name})
      : super(name: "Repository error: $name");
}
