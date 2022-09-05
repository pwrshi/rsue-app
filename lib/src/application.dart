import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:provider/provider.dart';
import 'package:rsue_app/src/config/theme.dart';
import 'package:rsue_app/src/presentation/screens/home.dart';
import 'package:rsue_app/src/presentation/screens/profile.dart';
import 'package:rsue_app/src/presentation/screens/schedule.dart';
import 'package:rsue_app/src/presentation/widgets/menu_scaffold.dart';

class RsueApplication extends StatelessWidget {
  const RsueApplication({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider<ZoomDrawerController>(
        create: (context) => ZoomDrawerController(),
        child: MaterialApp(
            theme: mainTheme,
            title: 'app',
            initialRoute: '/home',
            locale: const Locale('ru'),
            routes: {
              '/home': (context) =>
                  MenuScaffold(mainScreen: const HomeScreen(), menu: [
                    const Text(
                      "Станислав",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    MenuButton(
                      icon: FluentIcons.home_48_filled,
                      text: "Главная",
                      onPressed: () {
                        Provider.of<ZoomDrawerController>(context,
                                listen: false)
                            .toggle!();
                      },
                    ),
                    MenuButton(
                      icon: FluentIcons.app_recent_24_filled,
                      text: "Расписание",
                      onPressed: () {
                        Provider.of<ZoomDrawerController>(context,
                                listen: false)
                            .toggle!();
                        Navigator.pushNamed(context, '/schedule');
                      },
                    ),
                    MenuButton(
                      icon: FluentIcons.people_48_filled,
                      text: "Преподаватели",
                      onPressed: () {},
                    ),
                    MenuButton(
                      icon: FluentIcons.person_48_filled,
                      text: "Профиль",
                      onPressed: () {
                        Provider.of<ZoomDrawerController>(context,
                                listen: false)
                            .toggle!();
                        Navigator.pushNamed(context, '/profile');
                      },
                    ),
                    MenuButton(
                      icon: FluentIcons.bug_24_filled,
                      text: "О приложении",
                      onPressed: () {},
                    ),
                  ]),
              '/schedule': (context) => const ScheduleScreen(),
              '/profile': (context) => const ProfileScreen()
            }));
  }
}
