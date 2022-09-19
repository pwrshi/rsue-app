import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rsue_app/src/core/resources/data_state.dart';
import 'package:rsue_app/src/data/repositories/schedule_repository.dart';
import 'package:rsue_app/src/domain/repositories/schedule_repository.dart';
import 'package:rsue_app/src/presentation/widgets/short_info/short_info.dart';

import '../widgets/schedule/lesson.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var date = DateTime.now();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(FluentIcons.navigation_16_filled),
          onPressed: () {
            Provider.of<ZoomDrawerController>(context, listen: false).toggle!();
          },
        ),
        title: const Text(
          "RSUE",
          style: TextStyle(fontFamily: "Rubik_glitch"),
        ),
      ),
      body: ListView(padding: const EdgeInsets.all(8), children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 15.0),
          child: Text(
            "Добрый день, Станислав!",
            style: TextStyle(fontSize: 24),
            textAlign: TextAlign.center,
          ),
        ),
        const ShortInfo(),
        Padding(
          padding: const EdgeInsets.only(
            top: 30,
          ),
          child: Row(
            children: [
              TextButton(
                onPressed: () {},
                child: Row(
                  children: [
                    Text(
                      "Сегодня, ",
                      style: TextStyle(
                          fontSize: 24,
                          color: Theme.of(context).textTheme.bodyLarge?.color),
                    ),
                    Text(
                      "${date.day} ${DateFormat.MMMM('ru').format(date)}",
                      style: const TextStyle(
                          fontSize: 24, color: Color(0xFFBCCCDC)),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        FutureBuilder(
            future:
                Provider.of<ScheduleRepository>(context).getLessonsOnDay(date),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data is DataSuccess) {
                  var massive = buildLessonList(snapshot.data!.data!);
                  if (massive.length == 0) {
                    return const Center(
                        child: Text(
                      "Похоже, это выходной",
                      style: TextStyle(fontSize: 24),
                    ));
                  }
                  return Column(
                    children: massive,
                  );
                }
                return Text("Ошибочка ${snapshot.data!.error}");
              }
              return const CircularProgressIndicator();
            })
      ]),
    );
  }
}
