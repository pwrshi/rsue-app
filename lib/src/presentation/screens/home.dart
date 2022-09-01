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
    super.key,
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
      body: Center(
        child: Column(children: const [ShortInfo()]),
      ),
    );
  }
}
