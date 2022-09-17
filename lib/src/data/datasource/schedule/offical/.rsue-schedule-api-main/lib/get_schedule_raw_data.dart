import 'package:dio/dio.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';

import '../../_urls.dart';
import '../../../../../config/dio.dart';

// Дальше бога нет
/// Получить **сырое** расписание в формате
/// ```dart
/// {
///   "Четная/Нечетная неделя": {
///     "День недели": [
///       {
///         "name": "Дисциплина",
///         "teacher": "Преподаватель",
///         "time": "Время занятия",
///         "room": "Кабинет",
///         "type": "Лабораторная/Практика/Лекция",
///       }
///     ]
///   }
/// }
/// ```
Future<Map<String, Map<String, List<Map<String, String>>>>?> getScheduleRawData(
    int faculty, int course, int group) async {
  try {
    var response = await getDio().post(htmlUrl,
        data: FormData.fromMap({
          "f": faculty.toString(),
          "k": course.toString(),
          "g": group.toString()
        }));

    if (response.statusCode == 200) {
      Map<String, Map<String, List<Map<String, String>>>> schedule = {};

      List<Element>? content =
          parse(response.data.toString()).getElementById("content")?.children;

      Element? containerWeeks = content![content.length - 1];

      containerWeeks.children.asMap().forEach((idx, el) {
        if (el.className == "ned") {
          String currentWeek = el.innerHtml;

          List<Element>? week = containerWeeks.children[idx + 1].children;
          Map<String, List<Map<String, String>>> weekResult = {};

          for (var day in week) {
            if (day.text != " ") {
              String dayName = day.children.first.innerHtml;
              List<Map<String, String>> lessonsResult = [];

              day.children.asMap().forEach((idx, lesson) {
                if (idx != 0) {
                  String name = lesson.children[1].children[0].innerHtml;
                  String teacherName = lesson.children[2].children[0].innerHtml;
                  String time = lesson.children[0].children[0].innerHtml;
                  Element subgroup = lesson.children[0].children[0].children[0];
                  time = time.replaceAll(subgroup.outerHtml, "");
                  String room =
                      lesson.children[3].children[0].children[0].innerHtml;
                  String type =
                      lesson.children[3].children[1].children[0].innerHtml;
                  lessonsResult.add({
                    "subgroup": subgroup.text,
                    "name": name,
                    "teacher": teacherName,
                    "time": time,
                    "room": room,
                    "type": type,
                  });
                }
              });
              weekResult[dayName] = lessonsResult;
            }
          }
          schedule[currentWeek] = weekResult;
        }
      });
      return schedule;
    }
  } on DioError catch (error) {
    var statusCode = error.response?.statusCode;
    print(statusCode);
  }

  return null;
}
