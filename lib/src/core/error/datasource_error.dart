class DatasourceError {
  const DatasourceError({required this.name});
  final String name;
  @override
  String toString() {
    return "Datasource error: $name";
  }
}
