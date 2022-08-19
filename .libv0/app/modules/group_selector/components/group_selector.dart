import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';
// ignore: library_prefixes
import 'package:rsue_schedule_api/rsue_schedule_api.dart' as ScheduleAPI;

/// Отрисовка списка групп
class GroupSelector extends StatelessWidget {
  /// Отрисовка списка групп
  final GroupButtonController ctrl = GroupButtonController();
  GroupSelector(
      {required this.onSelected,
      required this.faculty,
      required this.course,
      required this.group});
  final int faculty, course, group;
  final dynamic Function(String, int, bool) onSelected;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            "Выбери группу",
            textAlign: TextAlign.start,
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
        ),
        FutureBuilder<Map<int, String>?>(
          future: ScheduleAPI.getGroups(faculty, course),
          builder: (context, snapshot) {
            ctrl.selectIndex(group);
            if (snapshot.hasData) {
              return GroupButton(
                controller: ctrl,
                isRadio: true,
                onSelected: onSelected,
                buttons: snapshot.data!.values.toList(),
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
