class LessonEntity {
  LessonEntity(
      {required this.name,
      required this.teachersname,
      required this.time,
      required this.room,
      required this.type});

  String name;
  String teachersname;
  DateTime time;
  String room;
  LessonType type;
}

enum LessonType { lab, lection, practice }
