class RepositoryError {
  const RepositoryError({required this.name});
  final String name;
  @override
  String toString() {
    return "Repository error: $name";
  }
}
