import 'dart:convert';
import 'package:dio/dio.dart';
import '../../../../../config/dio.dart';
import '../../_urls.dart';

/// Получить список групп, по факультету и курсу
Future<Map<int, String>?> getGroups(int faculty, int course) async {
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

  return null;
}
