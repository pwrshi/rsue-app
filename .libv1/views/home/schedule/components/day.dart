import 'package:flutter/material.dart';
import 'package:rsue_schedule_api/schedule_type.dart';
import 'lesson.dart';

class DayList extends StatelessWidget {
  DayList(this.schedule);
  late final Day? schedule;
  @override
  Widget build(BuildContext context) {
    if (schedule?.subjects == null) {
      return Column(
        children: [Text("Похоже, занятий нет)")],
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
      );
    } else {
      return Column(
        children: schedule!.subjects
            .asMap()
            .map((idx, lesson) => MapEntry(idx, Lesson(lesson)))
            .values
            .toList(),
      );
    }
  }
}
