import 'package:rsue_app/src/core/error/error.dart';

class DataSnapshotError extends RsError {
  const DataSnapshotError({required String name})
      : super(name: "DataSnapshotErr: $name");
}
