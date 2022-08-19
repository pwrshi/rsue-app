import 'package:get/get.dart';

import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';

import '../modules/group_selector/group_selector_binding.dart';
import '../modules/group_selector/group_selector_view.dart';

import '../modules/select_group/select_group.dart';

import '../modules/rsue_login/bindings/rsue_login_binding.dart';
import '../modules/rsue_login/views/rsue_login_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initital = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SELECTGROUP,
      page: () => const SelectGroup(),
    ),
    GetPage(
      name: _Paths.RSUELOGIN,
      page: () => RsueLoginView(),
      binding: RsueLoginBinding(),
    ),
  ];
}
