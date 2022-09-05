import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:provider/provider.dart';
import 'package:rsue_app/src/presentation/widgets/short_info/short_info.dart';

import '../widgets/schedule/lesson.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
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
                    const Text(
                      "9 Августа",
                      style: TextStyle(fontSize: 24),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        const LessonWidget(
          teacher: "доц.Рутта. Н.А.",
          name: "Математика",
          room: "Ауд.320",
          type: "Лекция",
          time: "8:30-10:00",
        ),
        const DelayWidget(
          time: 10,
        ),
        const LessonWidget(
          teacher: "ст.преп.Декамили Ю.Г..",
          name:
              "Элективные дисциплины (модули) по физической культуре и спорту",
          room: "Ауд.310",
          type: "Практика",
          time: "10:10-11:40",
        ),
        const DelayWidget(
          time: 10,
        )
      ]),
    );
  }
}
