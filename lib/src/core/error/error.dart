class RsError {
  const RsError({required this.name});
  final String name;
  @override
  String toString() {
    return "_\n|E| $name \n + ";
  }
}
