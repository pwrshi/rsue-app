import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rsue_app/src/presentation/widgets/schedule/lesson.dart';

const int maxWeekPages = 10;

class IndexedDateWithWeek {
  IndexedDateWithWeek(
    this._initDay,
    this._max,
  ) {
    initDay(0);
  }
  PageController week = PageController(initialPage: maxWeekPages),
      day = PageController(initialPage: maxWeekPages * 7);
  // максимальное количество страниц-недель
  final int _max;
  // _initDay и _focusedDay Всегда должны быть понедельником
  final DateTime _initDay;
  late DateTime _selectedDay;
  late DateTime _focusedDay;

  DateTime get selectedDay {
    return _selectedDay;
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

  int get weekId {
    return _max - _initDay.difference(_focusedDay).inDays;
  }

  set weekId(int newid) {
    _focusedDay = _initDay.add(Duration(days: (newid - _max) * 7));
    print("$newid\n$_focusedDay");
  }

  int get dayId {
    return _max * 7 - _initDay.difference(_selectedDay).inDays;
  }

  void initDay(int newid) {
    _selectedDay = _initDay.add(Duration(days: newid - _max * 7));
    _focusedDay =
        _selectedDay.subtract(Duration(days: _selectedDay.weekday - 1));
  }

  set dayId(int newid) {
    initDay(newid);
    week.animateToPage(weekId,
        curve: Curves.bounceIn, duration: const Duration(seconds: 1));
    print("$_selectedDay\n$_focusedDay\n$_initDay");
  }
}

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<StatefulWidget> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  DateTime date = DateTime.now();
  IndexedDateWithWeek idxw = IndexedDateWithWeek(
    DateTime.now(),
    maxWeekPages,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
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
              child: PageView.builder(
                itemCount: maxWeekPages * 2,
                controller: idxw.week,
                onPageChanged: ((value) {
                  idxw.weekId = value;
                }),
                itemBuilder: (BuildContext context, int index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: idxw
                        .getWeek(index)
                        .map((e) => DayButton(
                              date: e,
                              selected: idxw.selectedDay,
                            ))
                        .toList(),
                  );
                },
              ),
            ),
            Expanded(
                child: PageView.builder(
              itemCount: maxWeekPages * 2 * 7,
              onPageChanged: (value) {
                idxw.dayId = value;
              },
              controller: idxw.day,
              itemBuilder: ((context, index) =>
                  ListView(padding: const EdgeInsets.all(8), children: const [
                    LessonWidget(
                      teacher: "доц.Рутта. Н.А.",
                      name: "Математика",
                      room: "Ауд.320",
                      type: "Лекция",
                      time: "8:30-10:00",
                    ),
                    DelayWidget(
                      time: 10,
                    ),
                    LessonWidget(
                      teacher: "ст.преп.Декамили Ю.Г..",
                      name:
                          "Элективные дисциплины (модули) по физической культуре и спорту",
                      room: "Ауд.310",
                      type: "Практика",
                      time: "10:10-11:40",
                    ),
                    DelayWidget(
                      time: 10,
                    ),
                    LessonWidget(
                      teacher: "доц.Рутта. Н.А.",
                      name: "Математика",
                      room: "Ауд.320",
                      type: "Лекция",
                      time: "8:30-10:00",
                    ),
                    DelayWidget(
                      time: 10,
                    ),
                    LessonWidget(
                      teacher: "ст.преп.Декамили Ю.Г..",
                      name:
                          "Элективные дисциплины (модули) по физической культуре и спорту",
                      room: "Ауд.310",
                      type: "Практика",
                      time: "10:10-11:40",
                    ),
                    DelayWidget(
                      time: 10,
                    )
                  ])),
            ))
          ],
        ),
      ),
    );
  }
}

class DayButton extends StatefulWidget {
  DayButton(
      {super.key, required this.date, required this.selected, this.onTap});
  final DateTime date;
  DateTime selected;
  void Function()? onTap;

  @override
  State<StatefulWidget> createState() => _DayButtonState();
}

class _DayButtonState extends State<DayButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: widget.selected == widget.date
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
              DateFormat.MMM().format(widget.date),
              style: const TextStyle(color: Colors.white70, fontSize: 10),
            ),
            Text(widget.date.day.toString(),
                style: const TextStyle(fontSize: 20)),
            Text(DateFormat.E().format(widget.date),
                style: const TextStyle(color: Colors.white70, fontSize: 12))
          ],
        ),
      ),
    );
  }
}
