import 'package:get/get.dart';

import '../controllers/rsue_login_controller.dart';

class RsueLoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RsueLoginController>(
      () => RsueLoginController(),
    );
  }
}
