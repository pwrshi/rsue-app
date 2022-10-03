import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rsue_app/src/core/api/response.dart';
import 'package:rsue_app/src/domain/repositories/schedule_repository.dart';
import 'package:rsue_app/src/presentation/providers/data/schedule_snapshot.dart';
import 'package:rsue_app/src/presentation/widgets/schedule/lesson.dart';

const int maxWeekPages = 15;

class IndexedDateWithWeek {
  IndexedDateWithWeek(
    DateTime date,
    this._max,
  ) {
    _initDay = clearDateTimeFromTime(findMondayOfThisWeek(date));
    week = PageController(initialPage: _max);
    day = PageController(initialPage: _max * 7 + date.weekday - 1);
    _initDays(_max * 7 + date.weekday - 1);
  }

  static const typeAnimation = Curves.easeOut;
  static const animationSpeed = Duration(milliseconds: 300);

  /// контроллер для управления компонентом
  late PageController week, day;

  /// максимальное количество страниц-недель
  final int _max;

  /*
    для лучшего понимания процесса _initDay и _focusedDay 
    являются понедельниками с временем 0:00, по ним вычисляются недели
  */

  /// понедельник той недели, которая, является точкой отсчёта
  late final DateTime _initDay;

  /// выбранный день
  late DateTime _selectedDay;

  /// понедельник той недели, которая, находится в фокусе
  late DateTime _focusedDay;

  static DateTime clearDateTimeFromTime(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  static DateTime findMondayOfThisWeek(DateTime date) {
    return date.subtract(Duration(days: date.weekday - 1));
  }

  DateTime get selectedDay {
    return _selectedDay;
  }

  DateTime getDateTimeByDayId(int id) {
    return _initDay.add(Duration(days: id - _max * 7));
  }

  List<DateTime> getWeek(int wId) {
    List<DateTime> week = [];
    DateTime i = _initDay.add(Duration(days: (wId - _max) * 7));
    week.add(i);
    for (i = i.add(const Duration(days: 1));
        i.weekday > 1;
        i = i.add(const Duration(days: 1))) {
      week.add(i);
    }
    return week;
  }

  void setDayIdByDate(DateTime date) {
    _focusedDay = findMondayOfThisWeek(clearDateTimeFromTime(date));
    _selectedDay = clearDateTimeFromTime(date);
    day.animateToPage(dayId, curve: typeAnimation, duration: animationSpeed);
  }

  int get weekId {
    return _max - (_initDay.difference(_focusedDay).inDays / 7).ceil();
  }

  set weekId(int newid) {
    _focusedDay = _initDay.add(Duration(days: (newid - _max) * 7));
  }

  int get dayId {
    return _max * 7 - _initDay.difference(_selectedDay).inDays;
  }

  void _initDays(int newDayId) {
    _selectedDay = _initDay.add(Duration(days: newDayId - _max * 7));
    _focusedDay = findMondayOfThisWeek(_selectedDay);
  }

  set dayId(int newDayId) {
    _initDays(newDayId);
    week.animateToPage(weekId, curve: typeAnimation, duration: animationSpeed);
  }
}

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<StatefulWidget> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  IndexedDateWithWeek idxw = IndexedDateWithWeek(
    DateTime.now(),
    maxWeekPages,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(FluentIcons.arrow_left_16_filled),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "Расписание",
          style: TextStyle(fontFamily: "Rubik_glitch"),
        ),
      ),
      body: SizedBox.expand(
        child: Column(
          children: [
            SizedBox(
              height: 90,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 400),
                child: PageView.builder(
                  itemCount: maxWeekPages * 2,
                  controller: idxw.week,
                  onPageChanged: ((value) {}),
                  itemBuilder: (BuildContext context, int index) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: idxw
                          .getWeek(index)
                          .map((e) => DayButton(
                                date: e,
                                selected: idxw.selectedDay,
                                onTap: () {
                                  idxw.setDayIdByDate(e);
                                },
                              ))
                          .toList(),
                    );
                  },
                ),
              ),
            ),
            Expanded(
                child: PageView.builder(
              itemCount: maxWeekPages * 2 * 7,
              onPageChanged: (value) {
                setState(() {
                  idxw.dayId = value;
                });
              },
              controller: idxw.day,
              itemBuilder: ((context, index) {
                var date = idxw.getDateTimeByDayId(index);
                var s = DateFormat.EEEE('ru').format(date);
                return Builder(builder: (context) {
                  var service =
                      Provider.of<ScheduleServiceSnapshot>(context).data;

                  List<Widget> result = [
                    Row(
                      children: [
                        Text(
                          "${s[0].toUpperCase() + s.substring(1)}, ",
                          style: TextStyle(
                              fontSize: 24,
                              color:
                                  Theme.of(context).textTheme.bodyLarge?.color),
                        ),
                        Text(
                          "${date.day} ${DateFormat.MMMM('ru').format(date)}",
                          style: const TextStyle(
                              fontSize: 24, color: Color(0xFFBCCCDC)),
                        )
                      ],
                    )
                  ];
                  switch (service.status) {
                    case ResponseStatus.done:
                      var w = buildLessonList(
                          service.content!.getLessonsOnDay(date));
                      if (w.isEmpty) {
                        result.add(const Center(
                            child: Text(
                          "Похоже, это выходной",
                          style: TextStyle(fontSize: 24),
                        )));
                      } else {
                        result.add(Column(children: w));
                      }
                      break;
                    case ResponseStatus.restored:
                      var w = buildLessonList(
                          service.content!.getLessonsOnDay(date));
                      if (w.isEmpty) {
                        result.add(const Center(
                            child: Text(
                          "Похоже, это выходной",
                          style: TextStyle(fontSize: 24),
                        )));
                      } else {
                        result.add(Column(children: w));
                      }
                      break;
                    case ResponseStatus.error:
                      result.add(Center(
                          child: Text(
                        service.error.toString(),
                        style: const TextStyle(fontSize: 24),
                      )));
                      break;
                    default:
                      result.add(const Center(
                        child: CircularProgressIndicator(),
                      ));
                  }
                  return ListView(
                      padding: const EdgeInsets.all(8), children: result);
                });
              }),
            ))
          ],
        ),
      ),
    );
  }
}

class DayButton extends StatelessWidget {
  const DayButton(
      {super.key, required this.date, required this.selected, this.onTap});
  final DateTime date;
  final DateTime selected;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: selected == date
            ? BoxDecoration(
                color: const Color(0xFF486581),
                borderRadius: BorderRadius.circular(15))
            : null,
        width: 45,
        height: 70,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              DateFormat.MMM('ru').format(date).replaceAll('.', ''),
              style: const TextStyle(color: Colors.white70, fontSize: 10),
            ),
            Text(date.day.toString(), style: const TextStyle(fontSize: 20)),
            Text(DateFormat.E('ru').format(date),
                style: const TextStyle(color: Colors.white70, fontSize: 12))
          ],
        ),
      ),
    );
  }
}
