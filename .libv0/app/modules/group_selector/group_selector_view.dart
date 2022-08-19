import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'group_selector_controller.dart';
import 'components/faculty_selector.dart';
import 'components/course_selector.dart';
import 'components/group_selector.dart';

class GroupSelectView extends GetView<GroupSelectorController> {
  const GroupSelectView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          title: const Text('Выбор группы'),
          elevation: 0,
        ),
        body: Obx(() => Center(
              child: Column(children: [
                FacultySelector(
                    onChanged: (f) {
                      controller.setFaculty(f);
                    },
                    current: controller.faculty.value),
                CourseSelector(
                  onChanged: (c) {
                    controller.setCourse(c);
                  },
                  faculty: controller.faculty.value,
                  course: controller.course.value,
                ),
                GroupSelector(
                  onSelected: (b, g, s) {
                    controller.setGroup(g);
                  },
                  faculty: controller.faculty.value,
                  course: controller.course.value,
                  group: controller.group.value,
                ),
                ElevatedButton(
                    onPressed: () async {
                      await controller.submitGroup();
                      Get.snackbar("Успешно", "Вы выбрали группу");
                      Get.close(1);
                    },
                    child: const Text("Выбрать"))
              ]),
            )));
  }
}
