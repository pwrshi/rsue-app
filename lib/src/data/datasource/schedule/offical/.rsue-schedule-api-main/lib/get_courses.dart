import 'dart:convert';
import 'package:dio/dio.dart';
import '../../../../../config/dio.dart';
import '../../_urls.dart';

/// Получить список курсов по факультету
Future<Map<int, String>?> getCourses(int faculty) async {
  var response = await getDio().post(
    queryUrl,
    data:
        FormData.fromMap({"query": "getKinds", "type_id": faculty.toString()}),
  );

  if (response.statusCode == 200) {
    Map<int, String> courses = {};
    List date = jsonDecode(response.data.toString());

    for (var el in date) {
      courses[el["kind_id"]] = el["kind"];
    }

    return courses;
  }

  return null;
}
