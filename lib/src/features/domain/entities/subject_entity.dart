class SubjectEntity {
  SubjectEntity(
      {required this.name,
      required this.teachersname,
      required this.type,
      required this.isClosed,
      required this.statement});
  bool isClosed;
  int statement;
  String name;
  String teachersname;
  SessionType type;
}

enum SessionType { exam, credit, practice }

/// academic perfomance interface
abstract class AP {
  int get finalMark;
  List<int> get controlPoints;
  List<int> get absoluteControlPoints;
}

class APExam implements AP {
  APExam(
    this._controlPoint1,
    this._controlPoint2,
  );
  final int _controlPoint1, _controlPoint2;

  @override
  int get finalMark => (_controlPoint1 + _controlPoint2) ~/ 2;
  @override
  List<int> get absoluteControlPoints =>
      [_controlPoint1 ~/ 2, _controlPoint2 ~/ 2];

  @override
  List<int> get controlPoints => [_controlPoint1, _controlPoint2];
}

class APCredit implements AP {
  APCredit(
    this._controlPoint1,
    this._controlPoint2,
  );
  final int _controlPoint1, _controlPoint2;

  @override
  int get finalMark => (_controlPoint1 + _controlPoint2) ~/ 2;
  @override
  List<int> get absoluteControlPoints =>
      [_controlPoint1 ~/ 2, _controlPoint2 ~/ 2];

  @override
  List<int> get controlPoints => [_controlPoint1, _controlPoint2];
}

class APPractice implements AP {
  APPractice(
    this._controlPoint1,
  );
  final int _controlPoint1;

  @override
  int get finalMark => _controlPoint1;
  @override
  List<int> get absoluteControlPoints => [_controlPoint1];

  @override
  List<int> get controlPoints => [_controlPoint1];
}
