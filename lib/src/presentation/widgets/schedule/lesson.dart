import 'package:auto_size_text/auto_size_text.dart';
import "package:flutter/material.dart";

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
              children: [
                SizedBox(
                  width: double.infinity,
                  child: AutoSizeText(name,
                      minFontSize: 16,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 38,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      )),
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
