import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GroupSelectorController extends GetxController {
  var faculty = 1.obs;
  var course = 1.obs;
  var group = 0.obs;

  void setFaculty(int f) {
    faculty.value = f;
    course.value = 1;
    group.value = 0;
  }

  void setCourse(int c) {
    course.value = c;
    group.value = 0;
  }

  void setGroup(int g) {
    group.value = g;
  }

  Future<bool> submitGroup() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('student_info_faculty-id', faculty.value);
    await prefs.setInt('student_info_course-id', course.value);
    await prefs.setInt('student_info_group-id', group.value + 1);
    return true;
  }
}
