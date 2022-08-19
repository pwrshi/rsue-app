import 'package:flutter/material.dart';
import 'package:animated_toggle_switch/animated_toggle_switch.dart';
// ignore: library_prefixes
import 'package:rsue_schedule_api/rsue_schedule_api.dart' as ScheduleAPI;

/// Отрисовка списка курсов
class CourseSelector extends StatelessWidget {
  /// Отрисовка списка курсов
  CourseSelector(
      {required this.onChanged, required this.faculty, required this.course});

  final int faculty;
  final int course;

  final void Function(int) onChanged;

  Widget iconBuilder(int i, Size size, bool active) {
    switch (i) {
      case 1:
        return Icon(
          Icons.looks_one,
        );
      case 2:
        return Icon(
          Icons.looks_two,
        );
      case 3:
        return Icon(
          Icons.looks_3,
        );
      case 4:
        return Icon(
          Icons.looks_4,
        );
      case 5:
        return Icon(
          Icons.looks_5,
        );
      default:
        return Icon(
          Icons.cancel,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (faculty <= 0) {
      return Text("");
    } else {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Выбери курс",
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
          ),
          FutureBuilder<Map<int, String>?>(
            future: ScheduleAPI.getCourses(faculty),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var values =
                    (snapshot.data!.entries.map((e) => e.key).toList());
                return AnimatedToggleSwitch<int>.rolling(
                  current: course,
                  values: values,
                  onChanged: onChanged,
                  iconBuilder: iconBuilder,
                  borderColor: Colors.transparent,
                  //foregroundBoxShadow: _foregroundBoxShadow
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              return const CircularProgressIndicator();
            },
          ),
        ],
      );
    }
  }
}
