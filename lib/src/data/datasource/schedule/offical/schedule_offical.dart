import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:rsue_app/src/config/dio.dart';
import 'package:rsue_app/src/core/error/datasource_error.dart';
import 'package:rsue_app/src/data/datasource/schedule/offical/_urls.dart';
import 'package:rsue_app/src/data/repositories/schedule_datasource.dart';
import 'package:rsue_app/src/data/repositories/schedule_service.dart';
import 'package:rsue_app/src/domain/entities/group_entity.dart';
import 'package:rsue_app/src/domain/entities/lesson_entity.dart';

typedef ScheduleRaw = Map<String, Map<String, List<Map<String, String>>>>;

class ScheduleOfficalDatasource extends ScheduleDatasource {
  @override
  Future<Map<int, String>> getFacults() async {
    var response = await getDio().get(htmlUrl);

    if (response.statusCode == 200) {
      Map<int, String> facults = {};

      List<Element> selects =
          parse(response.data.toString()).getElementsByTagName("select");
      Element elem = selects.first;

      elem.children.asMap().forEach(((idx, el) {
        int id = int.tryParse(el.attributes["value"] ?? "") ?? idx;
        var value = el.text;
        facults[id] = value;
      }));

      // первый пункт, пустой "Факультет"
      facults.remove(0);
      return facults;
    }

    throw DatasourceError(
        name:
            "Ошибка при получении данных факультетов. Код: ${response.statusCode}");
  }

  @override
  Future<Map<int, String>> getCourses(int faculty) async {
    var response = await getDio().post(
      queryUrl,
      data: FormData.fromMap(
          {"query": "getKinds", "type_id": faculty.toString()}),
    );

    if (response.statusCode == 200) {
      Map<int, String> courses = {};
      List date = jsonDecode(response.data.toString());

      for (var el in date) {
        courses[el["kind_id"]] = el["kind"];
      }

      return courses;
    }

    throw DatasourceError(
        name:
            "Ошибка при получении данных курсов. Код: ${response.statusCode}");
  }

  @override
  Future<Map<int, String>> getGroups(int faculty, int course) async {
    var response = await getDio().post(
      queryUrl,
      data: FormData.fromMap({
        "query": "getCategories",
        "type_id": faculty.toString(),
        "kind_id": course.toString()
      }),
    );

    if (response.statusCode == 200) {
      Map<int, String> groups = {};
      List date = jsonDecode(response.data.toString());

      for (var el in date) {
        groups[el["category_id"]] = el["category"];
      }

      return groups;
    }
    throw DatasourceError(
        name: "Ошибка при получении данных групп. Код: ${response.statusCode}");
  }

  @override
  Future<List<Group>> getAllGroups() async {
    Map<int, String> facults = await getFacults();

    List<Group> allGroups = [];

    for (var faculty in facults.keys) {
      Map<int, String> courses = await getCourses(faculty);
      for (var course in courses.keys) {
        Map<int, String> groups = await getGroups(faculty, course);
        for (var group in groups.entries) {
          allGroups.add(Group(group.value,
              GroupId(facult: faculty, course: course, group: group.key)));
        }
      }
    }
    return allGroups;
  }

  Future<ScheduleRaw> _getScheduleRaw(GroupId groupId) async {
    var response = await getDio().post(htmlUrl,
        data: FormData.fromMap({
          "f": groupId.facult.toString(),
          "k": groupId.course.toString(),
          "g": groupId.group.toString()
        }));

    if (response.statusCode == 200) {
      Map<String, Map<String, List<Map<String, String>>>> schedule = {};

      try {
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
                    String teacherName =
                        lesson.children[2].children[0].innerHtml;
                    String time = lesson.children[0].children[0].innerHtml;
                    Element subgroup =
                        lesson.children[0].children[0].children[0];
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
      } catch (e) {
        throw DatasourceError(name: "Ошибка парсинга расписания + $e");
      }

      return schedule;
    }
    throw DatasourceError(
        name: "Ошибка получения расписания, код сайта: ${response.statusCode}");
  }

  DayOfWeek _nameToDayOfWeek(String weekdayName) {
    switch (weekdayName) {
      case "Понедельник":
        return 1;
      case "Вторник":
        return 2;
      case "Среда":
        return 3;
      case "Четверг":
        return 4;
      case "Пятница":
        return 5;
      case "Суббота":
        return 6;
      case "Воскресенье":
        return 7;
      default:
        return -1;
    }
  }

  Map<DayOfWeek, List<AbstractLesson>> _parseWeek(
      Map<String, List<Map<String, String>>> weekRaw) {
    Map<DayOfWeek, List<AbstractLesson>> result = {};
    for (var dayRaw in weekRaw.entries) {
      result[_nameToDayOfWeek(dayRaw.key)] = dayRaw.value.map((element) {
        LessonType type;
        switch (element["type"]) {
          case "Лекция":
            type = LessonType.lection;
            break;
          case "Практика":
            type = LessonType.practice;
            break;
          default:
            type = LessonType.lab;
        }
        return AbstractLesson(
            name: element["name"] ?? "",
            teachersname: element["teacher"] ?? "",
            room: element["room"] ?? "",
            type: type,
            time: element["time"] ?? "");
      }).toList();
    }
    return result;
  }

  @override
  Future<ScheduleService> getScheduleService(GroupId groupId) async {
    ScheduleRaw raw = await _getScheduleRaw(groupId);
    Map<String, List<Map<String, String>>> evenRaw;
    Map<String, List<Map<String, String>>> oddRaw;
    try {
      oddRaw = raw["Нечетная неделя"]!;
    } catch (e) {
      throw const DatasourceError(name: '"Нечетная неделя" не найдена');
    }
    try {
      evenRaw = raw["Четная неделя"]!;
    } catch (e) {
      throw const DatasourceError(name: '"Четная неделя" не найдена');
    }
    return ScheduleService(_parseWeek(evenRaw), _parseWeek(oddRaw));
  }
}
