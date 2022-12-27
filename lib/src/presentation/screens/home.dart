import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rsue_app/src/core/api/response.dart';
import 'package:rsue_app/src/domain/usecases/portfolio_snapshot.dart';
import 'package:rsue_app/src/domain/usecases/schedule_snapshot.dart';
import 'package:rsue_app/src/presentation/widgets/app_bar.dart';
import 'package:rsue_app/src/presentation/widgets/short_info/short_info.dart';

import '../widgets/schedule/lesson.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var date = DateTime.now();
    return Scaffold(
      appBar: CustomAppBar(
        leading: IconButton(
          icon: const Icon(FluentIcons.navigation_16_filled),
          onPressed: () {
            Provider.of<ZoomDrawerController>(context, listen: false).toggle!();
          },
        ),
        titleText: "RSUE",
      ),
      body: ListView(padding: const EdgeInsets.all(8), children: [
        Padding(
            padding: const EdgeInsets.only(bottom: 15.0),
            child: Builder(builder: (context) {
              var value = context.watch<WhoamiSnapshot>();
              switch (value.data.status) {
                case ResponseStatus.loading:
                  return const Text(
                    "Добрый день!",
                    style: TextStyle(fontSize: 24),
                    textAlign: TextAlign.center,
                  );
                case ResponseStatus.error:
                  return const Text(
                    "Добрый день, -_-!",
                    style: TextStyle(fontSize: 24),
                    textAlign: TextAlign.center,
                  );
                default:
                  return Text(
                    "Добрый день, ${value.data.content?['Имя']}!",
                    style: const TextStyle(fontSize: 24),
                    textAlign: TextAlign.center,
                  );
              }
            })),
        const ShortInfo(),
        Padding(
            padding: const EdgeInsets.only(
              top: 30,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/schedule');
                },
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
              ),
            )),
        Builder(builder: (context) {
          var service = Provider.of<ScheduleServiceSnapshot>(context).data;

          switch (service.status) {
            case ResponseStatus.done:
              var w = buildLessonList(service.content!.getLessonsOnDay(date));
              if (w.isEmpty) {
                return const Center(
                    child: Text(
                  "Похоже, это выходной",
                  style: TextStyle(fontSize: 24),
                ));
              }
              return Column(children: w);
            case ResponseStatus.error:
              return Center(
                  child: Text(
                service.error.toString(),
                style: const TextStyle(fontSize: 24),
              ));
            case ResponseStatus.restored:
              var w = buildLessonList(service.content!.getLessonsOnDay(date));
              if (w.isEmpty) {
                return const Center(
                    child: Text(
                  "Похоже, это выходной",
                  style: TextStyle(fontSize: 24),
                ));
              }
              return Column(children: w);
            default:
              return const Center(
                child: CircularProgressIndicator(),
              );
          }
        })
      ]),
    );
  }
}
