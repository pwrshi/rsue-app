import 'error.dart';

class UseCaseError extends RsError {
  const UseCaseError({required String name})
      : super(name: "UseCase error: $name");
}
