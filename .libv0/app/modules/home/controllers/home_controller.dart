import 'package:flutter/material.dart';
import 'package:get/get.dart';

const oneDay = Duration(days: 1);

class HomeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  /// Id Страницы в Нижнем баре
  final navpage = 0.obs;
  late final PageController tbc;

  @override
  void onInit() {
    super.onInit();
    tbc = PageController();
    // Инициализация странц карусели
  }

  @override
  void onClose() {}

  void changePage(int id) {
    navpage.value = id;
  }
}
