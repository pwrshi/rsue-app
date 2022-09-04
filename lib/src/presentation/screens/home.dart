import 'package:auto_size_text/auto_size_text.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:provider/provider.dart';
import 'package:rsue_app/src/presentation/widgets/short_info/short_info.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      shadowLayer2Color: const Color(0xFF334E68),
      shadowLayer1Color: const Color(0xFF486581),
      menuBackgroundColor: const Color(0xFF102A43),
      controller: Provider.of<ZoomDrawerController>(context),
      menuScreen: Align(
        alignment: Alignment.bottomLeft,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20.0, left: 5.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: const [
              Text(
                "Станислав",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              _MenuButton(
                icon: FluentIcons.home_48_filled,
                text: "Главная",
              ),
              _MenuButton(
                icon: FluentIcons.app_recent_24_filled,
                text: "Расписание",
              ),
              _MenuButton(
                icon: FluentIcons.people_48_filled,
                text: "Преподаватели",
              ),
              _MenuButton(
                icon: FluentIcons.person_48_filled,
                text: "Профиль",
              ),
              _MenuButton(
                icon: FluentIcons.bug_24_filled,
                text: "О приложении",
              ),
            ],
          ),
        ),
      ),
      mainScreen: _HomeScreen(),
      borderRadius: 45.0,
      showShadow: true,
      angle: -15.0,
      drawerShadowsBackgroundColor: const Color(0xFF334E68),
      slideWidth: MediaQuery.of(context).size.width * 0.65,
    );
  }
}

class _MenuButton extends StatelessWidget {
  const _MenuButton({
    required this.icon,
    required this.text,
  });
  final IconData icon;
  final String text;
  @override
  Widget build(BuildContext context) {
    return TextButton(
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(
                icon,
                size: 18,
              ),
            ),
            Text(
              text,
              style: const TextStyle(fontSize: 16),
            )
          ],
        ),
        onPressed: () {});
  }
}

class _HomeScreen extends StatelessWidget {
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

class DelayWidget extends StatelessWidget {
  const DelayWidget({super.key, required this.time});
  final int time;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 5, left: 30, right: 30),
      width: double.infinity,
      height: 40,
      decoration: const BoxDecoration(
          color: Color(0xFF486581),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5),
              topRight: Radius.circular(5),
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15))),
      child: Center(child: Text("$time минут")),
    );
  }
}

class LessonWidget extends StatelessWidget {
  const LessonWidget(
      {super.key,
      required this.name,
      required this.room,
      required this.teacher,
      required this.time,
      required this.type});
  final String type, room, name, teacher, time;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 5),
      padding: const EdgeInsets.all(15),
      width: double.infinity,
      height: 200,
      decoration: const BoxDecoration(
          color: Color(0xFF486581),
          borderRadius: BorderRadius.all(Radius.circular(15))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text(type), Text(room)],
          ),
          Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: AutoSizeText(name,
                    minFontSize: 16,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 38,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    )),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text(teacher), Text(time)],
              ),
            ],
          )
        ],
      ),
    );
  }
}
