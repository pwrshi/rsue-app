// import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'dart:async';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:rsue_schedule_api/schedule_type.dart';
import 'package:rsue_schedule_api/rsue_schedule_api.dart' as ScheduleAPI;
import './components/calendar_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';
import 'components/calendar_bar.dart';

const oneDay = Duration(days: 1);

class ScheduleView extends StatelessWidget {
  ScheduleView({super.key}) {
    changeSliderPage(date: focusedDay.value);
  }

  /// Меняет день фокуса
  void changeFocusedDay(DateTime day) {
    focusedDay.value = day.toIso8601String();
    changeSliderPage(date: focusedDay.toString());
  }

  /// Меняет страницы карусели
  void changeSliderPage({int? idx, String? date}) {
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
    int _idx = idx ?? pageId.value;
    pageId.value = _idx;
    String currentPage = (idx == null ? date : pages[_idx]);

    String nextPage = DateTime.parse(currentPage).add(oneDay).toIso8601String();
    String previousPage =
        DateTime.parse(currentPage).subtract(oneDay).toIso8601String();

    switch (_idx) {
      case 0:
        pages.value = [currentPage, nextPage, previousPage];
        break;
      case 1:
        pages.value = [previousPage, currentPage, nextPage];
        break;
      case 2:
        pages.value = [nextPage, previousPage, currentPage];
        break;
      default:
    }
    focusedDay.value = currentPage;
  }

  final focusedDay = (DateTime.now().toIso8601String()).obs;

  /// Индекс выбранной страницы в каруселе
  final pageId = 1.obs;

  /// Страницы содержания календарных дней
  final pages = [].obs;

  final format = CalendarFormat.week.obs;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(future: Future(() async {
      // Выставляет режим высокой частоты кадров
      // await FlutterDisplayMode.setHighRefreshRate();

      // Получение модели из памяти (если есть)
      final prefs = await SharedPreferences.getInstance();
      final String? sched = prefs.getString('schedule_snapshot');

      if (sched == null) {
        // Получение из памяти номера группы
        int? f = prefs.getInt('student_info_faculty-id');
        int? c = prefs.getInt('student_info_course-id');
        int? g = prefs.getInt('student_info_group-id');

        while ((f == null) || (c == null) || (g == null)) {
          await Get.toNamed("/selectgroup");
          f = prefs.getInt('student_info_faculty-id');
          c = prefs.getInt('student_info_course-id');
          g = prefs.getInt('student_info_group-id');
        }

        FutureOr<Schedule?> some(Map e) async {
          int f = e['f'];
          int c = e['c'];
          int g = e['g'];
          return await ScheduleAPI.getSchedule(f, c, g);
        }

        Schedule? s = await some({'f': f, 'c': c, 'g': g});
        await prefs.setString('schedule_snapshot', s!.toJson());
        return s;
      } else {
        Schedule? s = Schedule.fromJson(sched);
        return s;
      }
    }), builder: (context, AsyncSnapshot<Schedule?> snapshot) {
      if (snapshot.hasData) {
        return Obx(() => Column(
              children: [
                ScheduleCalendarBar(
                    DateTime.parse(focusedDay.string),
                    (selectedDay, focusedDay) => changeFocusedDay(selectedDay),
                    format.value, (nf) {
                  format.value = nf;
                }),
                AnimatedSize(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.linear,
                  child: ScheduleCalendarView(
                    data: snapshot.data!,
                    pages: pages.map((str) => DateTime.parse(str)).toList(),
                    onPageChanged: (_idx, __) {
                      changeSliderPage(idx: _idx);
                    },
                    format: format.value,
                  ),
                )
              ],
            ));
      }
      return const CircularProgressIndicator();
    });
  }
}
