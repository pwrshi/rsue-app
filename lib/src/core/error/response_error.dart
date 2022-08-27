class ResponseError {
  const ResponseError({required this.name});
  final String name;
  @override
  String toString() {
    return "ResponseError: $name";
  }
}
