class SubjectEntity {
  SubjectEntity(
      {required this.name,
      required this.teachersname,
      required this.type,
      required this.isClosed,
      required this.statement,
      required this.academicPerfomance});
  bool isClosed;
  int statement;
  AcademicPerfomance academicPerfomance;
  String name;
  String teachersname;
  SessionType type;
}

enum SessionType { exam, credit, practice }

/// academic perfomance interface
abstract class AcademicPerfomance {
  int get finalMark;
  List<int> get controlPoints;
  List<int> get absoluteControlPoints;
}

class AcademicPerfomanceExam implements AcademicPerfomance {
  AcademicPerfomanceExam(
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

class AcademicPerfomanceCredit implements AcademicPerfomance {
  AcademicPerfomanceCredit(
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

class AcademicPerfomancePractice implements AcademicPerfomance {
  AcademicPerfomancePractice(
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
