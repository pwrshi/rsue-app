import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:provider/provider.dart';
import 'package:rsue_app/src/config/theme.dart';
import 'package:rsue_app/src/data/datasource/portfolio/portfolio_cache_sp.dart';
import 'package:rsue_app/src/data/datasource/portfolio/portfolio_offical.dart';
import 'package:rsue_app/src/data/datasource/schedule/offical/schedule_offical.dart';
import 'package:rsue_app/src/data/datasource/schedule/schedule_cache_sp.dart';
import 'package:rsue_app/src/data/repositories/portfolio_repository.dart';
import 'package:rsue_app/src/data/repositories/schedule_repository.dart';
import 'package:rsue_app/src/domain/repositories/portfolio_repository.dart';
import 'package:rsue_app/src/domain/repositories/schedule_repository.dart';
import 'package:rsue_app/src/presentation/providers/data/portfolio_snapshot.dart';
import 'package:rsue_app/src/presentation/providers/data/schedule_snapshot.dart';
import 'package:rsue_app/src/presentation/providers/widget/short_info.dart';
import 'package:rsue_app/src/presentation/screens/autor.dart';
import 'package:rsue_app/src/presentation/screens/dzen_mode.dart';
import 'package:rsue_app/src/presentation/screens/home.dart';
import 'package:rsue_app/src/presentation/screens/introduction.dart';
import 'package:rsue_app/src/presentation/screens/loading.dart';
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
          //
          // Репозитории
          //

          Provider<ScheduleRepository>(
              create: (context) => ScheduleRepositoryRsueOfficalImpl(
                  {"Сайт РГЭУ (РИНХ)": (ScheduleOfficalDatasource(), SharedPreferencesScheduleCacheDatasource())},
                  )),
          Provider<PortfolioRepository>(
              create: (context) => PortfolioRepositoryImpl(
                  PortfolioOfficalDataSource(),
                  SharedPreferencesPortfolioCacheDatasource())),

          // прокся для данных
          // Portfolio
          ChangeNotifierProxyProvider<PortfolioRepository, WhoamiSnapshot>(
            create: (context) => WhoamiSnapshot(null),
            update: (context, value, previous) => WhoamiSnapshot(value),
          ),
          ChangeNotifierProxyProvider<PortfolioRepository,
              AcademicPerfomanceSnapshot>(
            create: (context) => AcademicPerfomanceSnapshot(null),
            update: (context, value, previous) =>
                AcademicPerfomanceSnapshot(value),
          ),
          ChangeNotifierProxyProvider<PortfolioRepository, PaymentSnapshot>(
            create: (context) => PaymentSnapshot(null),
            update: (context, value, previous) => PaymentSnapshot(value),
          ),
          // Schedule
          ChangeNotifierProxyProvider<ScheduleRepository,
              ScheduleServiceSnapshot>(
            create: (context) => ScheduleServiceSnapshot(null),
            update: (context, value, previous) =>
                ScheduleServiceSnapshot(value),
          ),
          // непосредственно прокся для виджетов
          ChangeNotifierProxyProvider<AcademicPerfomanceSnapshot,
                  ShortInfoProvider>(
              create: (context) => ShortInfoProvider(null),
              update: (context, value, previous) => ShortInfoProvider(value)),

          Provider<ZoomDrawerController>(
            create: (context) => ZoomDrawerController(),
          ),
        ],
        child: MaterialApp(
            theme: mainTheme,
            title: 'РИНХ',
            initialRoute: '/loading',
            locale: const Locale('ru'),
            routes: {
              '/home': (context) =>
                  MenuScaffold(mainScreen: const HomeScreen(), menu: [
                    const Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text(
                        "Меню",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
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
                      onPressed: () {
                        Provider.of<ZoomDrawerController>(context,
                                listen: false)
                            .toggle!();
                        Navigator.pushNamed(context, '/autor');
                      },
                    ),
                  ]),
              '/loading': (context) => const LoadingScreen(),
              '/schedule': (context) => const ScheduleScreen(),
              '/profile/whoami': (context) => WhoamiScreen(),
              '/profile/payments': (context) => const PaymentScreen(),
              '/profile': (context) => const ProfileScreen(),
              '/introduction': (context) => const IntroductionScreen(),
              '/autor': (context) => const AutorScreen(),
              '/dzen_mode': (context) => const DzenModeScreen()
            }));
  }
}
