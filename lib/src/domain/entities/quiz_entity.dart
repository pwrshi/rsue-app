import 'package:freezed_annotation/freezed_annotation.dart';
part 'quiz_entity.freezed.dart';
part 'quiz_entity.g.dart';

enum SessionType {
  exam,
  practise,
  credit,
}

@freezed
class Quiz with _$Quiz {
  const factory Quiz(
      {required String name,
      String? dateTime,
      String? rooms,
      String? teachers,
      SessionType? type}) = _Quiz;

  factory Quiz.fromJson(Map<String, Object?> json) => _$QuizFromJson(json);
}
