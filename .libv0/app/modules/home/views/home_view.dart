import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rsue_app/app/modules/home/views/components/bottom_bar.dart';

import 'portfolio/portfolio_view.dart';

import 'schedule/schedule_view.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          title: const Text('Расписание'),
          actions: [
            IconButton(
                onPressed: () {
                  Get.toNamed("/selectgroup");
                },
                icon: const Icon(Icons.settings))
          ],
          elevation: 0,
        ),
        resizeToAvoidBottomInset: false,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingBottomBar(
            page: controller.navpage,
            onTap: (int id) {
              controller.changePage(id);
              controller.tbc.animateToPage(id,
                  duration: const Duration(milliseconds: 150),
                  curve: Curves.easeInOut);
            }),
        body: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: controller.tbc,
            children: [
              ScheduleView(),
              const Center(
                child: Text("plumb"),
              ),
              PortfolioView()
            ]));
  }
}
