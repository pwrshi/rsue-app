import 'package:equatable/equatable.dart';

class LessonEntity extends Equatable {
  const LessonEntity(
      {required this.name,
      required this.teachersname,
      required this.time,
      required this.room,
      required this.type});

  final String name;
  final String teachersname;
  final DateTime time;
  final String room;
  final LessonType type;

  @override
  List<Object?> get props => [name, teachersname, time, room, type];
}

enum LessonType { lab, lection, practice }
