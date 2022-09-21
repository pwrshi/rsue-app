import 'package:freezed_annotation/freezed_annotation.dart';

part 'subject_entity.freezed.dart';
part 'subject_entity.g.dart';

enum SessionType { exam, credit, practice }

// /// academic perfomance interface
// abstract class AcademicPerfomance {
//   int get finalMark;
//   List<int> get controlPoints;
//   List<int> get absoluteControlPoints;
//   AcademicPerfomance.fromJson(Map<String, Object?> json) {}
//   Map<String, dynamic> toJson();
// }

// @freezed
// class AcademicPerfomanceExam
//     with _$AcademicPerfomanceExam
//     implements AcademicPerfomance {
//   AcademicPerfomanceExam._();
//   const factory AcademicPerfomanceExam(
//     int controlPoint2,
//     int controlPoint1,
//   ) = _AcademicPerfomanceExam;

//   factory AcademicPerfomanceExam.fromJson(Map<String, Object?> json) =>
//       _$AcademicPerfomanceExamFromJson(json);
//   @override
//   int get finalMark {
//     return (controlPoint1 + controlPoint2) ~/ 2;
//   }

//   @override
//   List<int> get absoluteControlPoints =>
//       [controlPoint1 ~/ 2, controlPoint2 ~/ 2];

//   @override
//   List<int> get controlPoints => [controlPoint1, controlPoint2];
// }

// @freezed
// class AcademicPerfomanceCredit
//     with _$AcademicPerfomanceCredit
//     implements AcademicPerfomance {
//   AcademicPerfomanceCredit._();
//   const factory AcademicPerfomanceCredit(
//     int controlPoint1,
//     int controlPoint2,
//   ) = _AcademicPerfomanceCredit;

//   factory AcademicPerfomanceCredit.fromJson(Map<String, Object?> json) =>
//       _$AcademicPerfomanceCreditFromJson(json);

//   @override
//   int get finalMark => (controlPoint1 + controlPoint2) ~/ 2;
//   @override
//   List<int> get absoluteControlPoints =>
//       [controlPoint1 ~/ 2, controlPoint2 ~/ 2];

//   @override
//   List<int> get controlPoints => [controlPoint1, controlPoint2];
// }

// @freezed
// class AcademicPerfomancePractice
//     with _$AcademicPerfomancePractice
//     implements AcademicPerfomance {
//   AcademicPerfomancePractice._();
//   const factory AcademicPerfomancePractice(
//     int controlPoint1,
//   ) = _AcademicPerfomancePractice;
//   factory AcademicPerfomancePractice.fromJson(Map<String, Object?> json) =>
//       _$AcademicPerfomancePracticeFromJson(json);
//   @override
//   int get finalMark => controlPoint1;
//   @override
//   List<int> get absoluteControlPoints => [controlPoint1];

//   @override
//   List<int> get controlPoints => [controlPoint1];
// }

@freezed
class SubjectEntity with _$SubjectEntity {
  const SubjectEntity._();
  const factory SubjectEntity(
      {required String name,
      required String teachersname,
      required SessionType type,
      required bool isClosed,
      required int statement,
      required List<int> controlPoints}) = _SubjectEntity;
  factory SubjectEntity.fromJson(Map<String, Object?> json) =>
      _$SubjectEntityFromJson(json);

  int get finalMark =>
      controlPoints.reduce((value, element) => value + element) ~/
      controlPoints.length;
  List<int> get absoluteControlPoints =>
      controlPoints.map((e) => e ~/ controlPoints.length).toList();
}
