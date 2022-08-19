import 'package:get/get.dart';

import 'group_selector_controller.dart';

class GroupSelectorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GroupSelectorController>(
      () => GroupSelectorController(),
    );
  }
}
