import 'package:dio/dio.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:provider/provider.dart';
import 'package:rsue_app/src/config/dio.dart';
import 'package:rsue_app/src/config/theme.dart';
import 'package:rsue_app/src/data/datasource/portfolio/portfolio_offical.dart';
import 'package:rsue_app/src/data/datasource/schedule/offical/schedule_offical.dart';
import 'package:rsue_app/src/data/repositories/portfolio_repository.dart';
import 'package:rsue_app/src/data/repositories/schedule_repository.dart';
import 'package:rsue_app/src/domain/repositories/portfolio_repository.dart';
import 'package:rsue_app/src/domain/repositories/schedule_repository.dart';
import 'package:rsue_app/src/presentation/screens/home.dart';
import 'package:rsue_app/src/presentation/screens/introduction.dart';
import 'package:rsue_app/src/presentation/screens/payments.dart';
import 'package:rsue_app/src/presentation/screens/profile.dart';
import 'package:rsue_app/src/presentation/screens/schedule.dart';
import 'package:rsue_app/src/presentation/screens/whoami.dart';
import 'package:rsue_app/src/presentation/widgets/menu_scaffold.dart';

class RsueApplication extends StatelessWidget {
  const RsueApplication({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          // Боковое меню
          // http клиент
          Provider<Dio>(create: (context) => getDio()),
          // Источники данных
          ProxyProvider<Dio, ScheduleOfficalDatasource>(
              update: (context, value, previous) =>
                  ScheduleOfficalDatasource(value)),
          ProxyProvider<Dio, PortfolioOfficalDataSource>(
              update: (context, value, previous) =>
                  PortfolioOfficalDataSource(value)),
          // Репозитории
          ProxyProvider<ScheduleOfficalDatasource, ScheduleRepository>(
              update: (context, value, previous) =>
                  ScheduleRepositoryRsueOfficalImpl(
                      {"Сайт РГЭУ (РИНХ)": value})),
          ProxyProvider<PortfolioOfficalDataSource, PortfolioRepository>(
              update: (context, value, previous) =>
                  PortfolioRepositoryImpl(value)),
          // непосредственно прокся для виджетов
          Provider<ZoomDrawerController>(
            create: (context) => ZoomDrawerController(),
          ),
        ],
        child: MaterialApp(
            theme: mainTheme,
            title: 'app',
            initialRoute: '/introduction',
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
              '/profile/whoami': (context) => WhoamiScreen(),
              '/profile/payments': (context) => const PaymentScreen(),
              '/profile': (context) => const ProfileScreen(),
              '/introduction': (context) => const IntroductionScreen()
            }));
  }
}
