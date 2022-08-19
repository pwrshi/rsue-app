import 'package:flutter/material.dart';
import 'package:animated_toggle_switch/animated_toggle_switch.dart';
// ignore: library_prefixes
import 'package:rsue_schedule_api/rsue_schedule_api.dart' as ScheduleAPI;

/// Возвращает иконку факультета
/// Отрисовка списка Факультетов
class FacultySelector extends StatelessWidget {
  Widget iconBuilder(int i, Size zsize, bool active) {
    const double inset = 3;
    double? size;
    switch (i) {
      case 1:
        return Padding(
            padding: EdgeInsets.all(inset),
            child: Image.asset(
              "assets/icons/faculty/mip/100.png",
              width: size,
              height: size,
            ));
      case 2:
        return Padding(
            padding: EdgeInsets.all(inset),
            child: Image.asset(
              "assets/icons/faculty/td/100.png",
              width: size,
              height: size,
            ));
      case 3:
        return Padding(
            padding: EdgeInsets.all(inset),
            child: Image.asset(
              "assets/icons/faculty/ktiib/80.png",
              width: size,
              height: size,
            ));
      case 4:
        return Padding(
            padding: EdgeInsets.all(inset),
            child: Image.asset(
              "assets/icons/faculty/uef/100.png",
              width: size,
              height: size,
            ));
      case 5:
        return Padding(
            padding: EdgeInsets.all(inset),
            child: Image.asset(
              "assets/icons/faculty/eif/100.png",
              width: size,
              height: size,
            ));
      case 6:
        return Padding(
            padding: EdgeInsets.all(inset),
            child: Image.asset(
              "assets/icons/faculty/u/100.png",
              width: size,
              height: size,
            ));
      case 7:
        return Padding(
            padding: EdgeInsets.all(inset),
            child: Image.asset(
              "assets/icons/faculty/fliz/100.png",
              width: size,
              height: size,
            ));
      default:
        return Icon(
          Icons.cancel,
          size: size,
        );
    }
  }

  /// Отрисовка списка Факультетов
  FacultySelector({required this.onChanged, required this.current});
  final int current;
  final void Function(int) onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                "Выбери факультет",
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
            ),
            FutureBuilder<Map<int, String>?>(
              future: ScheduleAPI.getFacults(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var values =
                      snapshot.data!.entries.map((e) => e.key).toList();
                  values.remove(0);
                  return AnimatedToggleSwitch<int>.rolling(
                      borderColor: Colors.transparent,
                      indicatorColor: Colors.transparent,
                      //innerColor: Theme.of(context).colorScheme.background,
                      current: current,
                      values: values,
                      onChanged: onChanged,
                      foregroundBoxShadow: [
                        BoxShadow(
                          color: Theme.of(context).colorScheme.secondary,
                          spreadRadius: 2,
                          blurRadius: 0,
                          offset: Offset(0, 0),
                        )
                      ],
                      iconBuilder: iconBuilder);
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                return CircularProgressIndicator();
              },
            ),
          ],
        ));
  }
}
