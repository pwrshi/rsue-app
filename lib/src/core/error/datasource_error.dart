import 'error.dart';

class DatasourceError extends RsError {
  const DatasourceError({required String name})
      : super(name: "Datasource error: $name");
}
