import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../lib_de/models/apis/response.dart';
import '../../../../lib_de/view_models/user.dart';
import '../../../../lib_de/views/home/schedule/components/calendar_bar.dart';
import 'package:table_calendar/table_calendar.dart';

import 'components/calendar_view.dart';

const oneDay = Duration(days: 1);

class ScheduleBody extends StatefulWidget {
  const ScheduleBody({super.key});

  @override
  State<StatefulWidget> createState() => _ScheduleBodyState();
}

class _ScheduleBodyState extends State<ScheduleBody> {
  @override
  Widget build(BuildContext context) {
    var model = context.watch<UserViewModel>();
    switch (model.schedule.status) {
      case Status.initial:
        return const ScheduleBodyInitial();
      case Status.completed:
        return const ScheduleBodyCompleted();
      case Status.error:
        return Padding(
          padding: const EdgeInsets.all(8),
          child: Text("Ошибка ${model.schedule.message}"),
        );
      case Status.loading:
        return const Padding(
          padding: EdgeInsets.all(8),
          child: Text("Загрузка..."),
        );
    }
  }
}

class ScheduleBodyInitial extends StatelessWidget {
  const ScheduleBodyInitial({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          const Text("Группа не выбрана"),
          ElevatedButton(
              onPressed: () {
                context.read<UserViewModel>().setGroup(3, 1, 8);
              },
              child: const Text("Выставить ПРИ-312"))
        ],
      ),
    );
  }
}

class ScheduleBodyCompleted extends StatefulWidget {
  const ScheduleBodyCompleted({super.key});

  @override
  State<StatefulWidget> createState() => _ScheduleBodyCompletedState();
}

class _ScheduleBodyCompletedState extends State<ScheduleBodyCompleted> {
  @override
  void initState() {
    super.initState();
    changeSliderPage(date: focusedDay);
  }

  var focusedDay = DateTime.now();
  var format = CalendarFormat.week;
  int index = 0;

  /// Страницы содержания календарных дней
  List<DateTime> pages = [];

  void changeFocusedDay(DateTime day) {
    focusedDay = day;
    changeSliderPage(date: focusedDay);
  }

  /// Меняет страницы карусели
  void changeSliderPage({int? idx, DateTime? date}) {
    /*
      Для минимизации количества виджетов в дереве карусели для 
      определённых дней недели осуществляется следущее:
        * Существует всего три страницы, индекс мы никак не меняем программно,
          его меняет ТОЛЬКО сам пользователь
        * В тот момент, когда пользователь меняет страницу, мы подменям 
          содержимое страниц так, чтобы пользователю казалось, что количество 
          страниц с расписанием бесконечное множество, хотя это не так
        * В итоге он ходит циклично по страницам, где меняется только их 
          содержимое
    */
    index = idx ?? index;
    focusedDay = date ?? pages[index];
    DateTime nextDay = focusedDay.add(oneDay);
    DateTime previousDay = focusedDay.subtract(oneDay);

    switch (index) {
      case 0:
        pages = [focusedDay, nextDay, previousDay];
        break;
      case 1:
        pages = [previousDay, focusedDay, nextDay];
        break;
      case 2:
        pages = [nextDay, previousDay, focusedDay];
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ScheduleCalendarBar(
            focusedDay,
            (sDay, fDay) {
              setState(() {
                focusedDay = fDay;
              });
            },
            format,
            (newFormat) {
              setState(() {
                format = newFormat;
              });
            }),
        ScheduleCalendarView(
          data: context.read<UserViewModel>().schedule.data!,
          pages: pages,
          onPageChanged: (idx, __) {
            changeSliderPage(idx: idx);
          },
          format: format,
        )
      ],
    );
  }
}
