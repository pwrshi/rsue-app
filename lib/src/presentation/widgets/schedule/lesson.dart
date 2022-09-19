import 'package:auto_size_text/auto_size_text.dart';
import "package:flutter/material.dart";
import 'package:rsue_app/src/domain/entities/lesson_entity.dart';

class LessonWidget extends StatelessWidget {
  const LessonWidget(
      {super.key,
      required this.name,
      required this.room,
      required this.teacher,
      required this.time,
      required this.type});
  final String type, room, name, teacher, time;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Container(
        margin: const EdgeInsets.only(top: 5),
        padding: const EdgeInsets.all(15),
        width: 344,
        height: 200,
        decoration: const BoxDecoration(
            color: Color(0xFF486581),
            borderRadius: BorderRadius.all(Radius.circular(15))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text(type), Text(room)],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 300,
                  height: 80,
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: AutoSizeText(name,
                        minFontSize: 16,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          fontSize: 38,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        )),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text(teacher), Text(time)],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  static LessonWidget fromConcreteLesson(ConcreteLesson lesson) {
    String type;
    switch (lesson.type) {
      case LessonType.lab:
        type = "Лабораторная";
        break;
      case LessonType.lection:
        type = "Лекция";
        break;
      case LessonType.practice:
        type = "Практика";
        break;
      default:
        type = ";(";
    }
    return LessonWidget(
      name: lesson.name,
      room: lesson.room,
      teacher: lesson.teachersname,
      time:
          "${lesson.startTime.hour}:${lesson.startTime.minute}-${lesson.endTime.hour}:${lesson.endTime.minute}",
      type: type,
    );
  }
}

class DelayWidget extends StatelessWidget {
  const DelayWidget({super.key, required this.time});
  final int time;
  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Container(
        margin: const EdgeInsets.only(top: 5, left: 30, right: 30),
        width: 284,
        height: 40,
        decoration: const BoxDecoration(
            color: Color(0xFF486581),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5),
                topRight: Radius.circular(5),
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15))),
        child: Center(child: Text("$time минут")),
      ),
    );
  }
}

List<Widget> buildLessonList(List<ConcreteLesson> list) {
  List<Widget> result = [];
  for (var i = 0; i < list.length; i++) {
    var lesson = list[i];
    ConcreteLesson? next = ((i + 1) < list.length) ? list[i + 1] : null;
    result.add(LessonWidget.fromConcreteLesson(lesson));
    if (next != null) {
      Duration delay = lesson.endTime.difference(next.startTime);
      if (delay.inMinutes < 0) {
        result.add(DelayWidget(time: -delay.inMinutes));
      }
    }
  }
  return result;
}
