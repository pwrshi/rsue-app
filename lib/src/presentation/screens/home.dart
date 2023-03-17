import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rsue_app/src/core/api/response.dart';
import 'package:rsue_app/src/domain/entities/schedule_service.dart';
import 'package:rsue_app/src/domain/usecases/portfolio_snapshot.dart';
import 'package:rsue_app/src/domain/usecases/schedule_snapshot.dart';
import 'package:rsue_app/src/presentation/widgets/app_bar.dart';
import 'package:rsue_app/src/presentation/widgets/schedule/schedule.dart';
import 'package:rsue_app/src/presentation/widgets/short_info/short_info.dart';

import '../widgets/schedule/lesson.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
// [SliverAppBar]s are typically used in [CustomScrollView.slivers], which in
// turn can be placed in a [Scaffold.body].
  IndexedDateWithWeek idxw = IndexedDateWithWeek(
    DateTime.now(),
    maxWeekPages,
  );
  ListView dayWidget(Response<ScheduleService> service, int index) {
    var date = idxw.getDateTimeByDayId(index);
    var s = DateFormat.EEEE('ru').format(date);
    List<Widget> result = [
      Padding(
        padding: EdgeInsets.only(bottom: 8.0, left: 8.0, right: 8.0),
        child: Row(
          children: [
            Text(
              "${s[0].toUpperCase() + s.substring(1)}, ",
              style: TextStyle(
                  fontSize: 24,
                  color: Theme.of(context).textTheme.bodyLarge?.color),
            ),
            Text(
              "${date.day} ${DateFormat.MMMM('ru').format(date)}",
              style: const TextStyle(fontSize: 24, color: Color(0xFFBCCCDC)),
            )
          ],
        ),
      )
    ];
    switch (service.status) {
      case ResponseStatus.done:
        var w = buildLessonList(service.content!.getLessonsOnDay(date));
        if (w.isEmpty) {
          result.add(const Center(
              child: Text(
            "Похоже, это выходной",
            style: TextStyle(fontSize: 24),
          )));
        } else {
          result.add(Column(children: w));
        }
        break;
      case ResponseStatus.restored:
        var w = buildLessonList(service.content!.getLessonsOnDay(date));
        if (w.isEmpty) {
          result.add(const Center(
              child: Text(
            "Похоже, это выходной",
            style: TextStyle(fontSize: 24),
          )));
        } else {
          result.add(Column(children: w));
        }
        break;
      case ResponseStatus.error:
        result.add(Center(
            child: Text(
          service.error.toString(),
          style: const TextStyle(fontSize: 24),
        )));
        break;
      default:
        result.add(const Center(
          child: CircularProgressIndicator(),
        ));
    }

    return ListView(padding: const EdgeInsets.all(8), children: result);
  }

  @override
  Widget build(BuildContext context) {
    var service = context.watch<ScheduleServiceSnapshot>().get();
    return Scaffold(
      body: NestedScrollView(
        body: SizedBox.expand(
          child: Column(
            children: [
              Expanded(
                  child: PageView.builder(
                itemCount: maxWeekPages * 2 * 7,
                onPageChanged: (value) {
                  setState(() {
                    idxw.dayId = value;
                  });
                },
                controller: idxw.day,
                itemBuilder: ((context, index) {
                  return dayWidget(service, index);
                }),
              ))
            ],
          ),
        ),
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              leading: IconButton(
                icon: const Icon(FluentIcons.navigation_16_filled),
                onPressed: () {
                  Provider.of<ZoomDrawerController>(context, listen: false)
                      .toggle!();
                },
              ),
              title: const Text(
                "RSUE",
                style: TextStyle(fontFamily: "Rubik_glitch"),
              ),
              centerTitle: true,
              backgroundColor: Theme.of(context).colorScheme.background,
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(90),
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: ConstrainedBox(
                      constraints:
                          const BoxConstraints(maxWidth: 344, maxHeight: 90),
                      child: PageView.builder(
                        itemCount: maxWeekPages * 2,
                        controller: idxw.week,
                        onPageChanged: ((value) {}),
                        itemBuilder: (BuildContext context, int index) {
                          return FittedBox(
                            child: Container(
                                margin: const EdgeInsets.only(top: 5),
                                width: 350,
                                height: 75,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: idxw
                                      .getWeek(index)
                                      .map((e) => DayButton(
                                            key: ValueKey(MapEntry(
                                                e, idxw.selectedDay == e)),
                                            date: e,
                                            selected: idxw.selectedDay == e,
                                            onTap: () {
                                              idxw.setDayIdByDate(e);
                                            },
                                          ))
                                      .toList(),
                                )),
                          );
                        },
                      ),
                    )),
              ),
              pinned: true,
              snap: false,
              floating: false,
              expandedHeight: 470.0,
              flexibleSpace: FlexibleSpaceBar(
                expandedTitleScale: 1,
                collapseMode: CollapseMode.pin,
                background: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    SizedBox(
                      width: 350,
                      height: 100,
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: ShortInfo()),
                    SizedBox(
                      width: 350,
                      height: 90,
                    ),
                  ],
                ),
              ),
            ),
          ];
        },
      ),
    );
  }
}

class HomeScreene extends StatelessWidget {
  const HomeScreene({super.key});

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
              switch (value.get().status) {
                case ResponseStatus.loading:
                  return const Text(
                    "Привет!",
                    style: TextStyle(fontSize: 24),
                    textAlign: TextAlign.center,
                  );
                case ResponseStatus.error:
                  return const Text(
                    "Привет, -_-!",
                    style: TextStyle(fontSize: 24),
                    textAlign: TextAlign.center,
                  );
                default:
                  return Text(
                    "Привет, ${value.get().content?['Имя']}!",
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
          var service = Provider.of<ScheduleServiceSnapshot>(context).get();

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
