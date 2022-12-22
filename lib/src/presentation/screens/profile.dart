import 'package:expandable/expandable.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rsue_app/src/core/api/response.dart';
import 'package:rsue_app/src/domain/entities/subject_entity.dart';
import 'package:rsue_app/src/presentation/providers/data/portfolio_snapshot.dart';
import 'package:rsue_app/src/presentation/widgets/app_bar.dart';
import 'package:rsue_app/src/presentation/widgets/schedule/subject.dart';

class ExpandSemesterWidget extends StatelessWidget {
  final List<SubjectEntity> subjects;
  final String title;

  const ExpandSemesterWidget(this.title, this.subjects, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: ExpandablePanel(
        theme: const ExpandableThemeData(
          useInkWell: false,
          hasIcon: false,
        ),
        header: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              color: const Color(0xff486581)),
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Expanded(child: Text(title)),
              ExpandableIcon(
                  theme: ExpandableThemeData(
                iconColor: Theme.of(context).textTheme.bodyMedium?.color,
              ))
            ],
          ),
        ),
        collapsed: Container(),
        expanded: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: subjects
              .map<Widget>((subject) => SubjectWidget(
                  name: subject.name,
                  controlPoints: subject.controlPoints,
                  teacher: subject.teachersname,
                  isClosed: subject.isClosed,
                  statement: subject.statement,
                  type: SubjectWidget.sessionTypeToString(subject.type)))
              .toList(),
        ),
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.withBack(
        context: context,
        titleText: "Профиль",
      ),
      body: Center(
        child: ListView(padding: const EdgeInsets.all(8), children: [
          SizedBox(
            height: 80,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: FilledButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/profile/payments');
                    },
                    style: FilledButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      backgroundColor: const Color(0xFF486581),
                      foregroundColor: Colors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          FluentIcons.barcode_scanner_24_filled,
                          size: 42,
                          weight: 2,
                        ),
                        const SizedBox(
                          width: 9,
                        ),
                        Builder(builder: (context) {
                          var value = context.watch<PaymentSnapshot>();
                          switch (value.data.status) {
                            case ResponseStatus.loading:
                              return const Text("--\nПлатежи");
                            case ResponseStatus.error:
                              return const Text("-_-\nПлатежи");
                            default:
                              return Text(
                                  "${value.data.content?.length}\nПлатежи");
                          }
                        })
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: 9,
                ),
                Expanded(
                  child: FilledButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/profile/whoami');
                    },
                    style: FilledButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      backgroundColor: const Color(0xFF486581),
                      foregroundColor: Colors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          FluentIcons.person_32_filled,
                          size: 38,
                          weight: 2,
                        ),
                        SizedBox(
                          width: 9,
                        ),
                        Text(
                          "Сведения\nо студенте",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w700),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Builder(builder: (c) {
            var value = context.watch<AcademicPerfomanceSnapshot>();
            switch (value.data.status) {
              case ResponseStatus.loading:
                return const SizedBox.shrink(
                  child: CircularProgressIndicator(),
                );
              case ResponseStatus.error:
                return SizedBox.shrink(
                  child: Text(value.data.error.toString()),
                );
              default:
                return Column(children: [
                  for (var s in (value.data.content?.entries.toList() ?? []))
                    ExpandSemesterWidget(s.key, s.value)

                  //   Padding(
                  //     padding: const EdgeInsets.only(
                  //         top: 20.0, left: 8, right: 8, bottom: 8),
                  //     child: Text(s.key),
                  //   ),
                  //   for (var subject in s.value)
                  //     SubjectWidget(
                  //         name: subject.name,
                  //         controlPoints: subject.controlPoints,
                  //         teacher: subject.teachersname,
                  //         isClosed: subject.isClosed,
                  //         statement: subject.statement,
                  //         type:
                  //             SubjectWidget.sessionTypeToString(subject.type))
                ]);
            }
            // if (snapshot.hasData) {
            //   if (snapshot.data is DataFailed) {
            //     return Container(
            //       color: const Color(0xFF486581),
            //       padding:
            //           const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
            //       child: Text(snapshot.data!.error!.name),
            //     );
            //   }
          })
          // const SubjectWidget(
          //   teacher: "доц.Рутта. Н.А.",
          //   name: "Математика",
          //   controlPoints: [90, 20],
          //   type: "Лекция",
          //   time: "8:30-10:00",
          // ),
          // const SubjectWidget(
          //   teacher: "доц.Рутта. Н.А.",
          //   name:
          //       "Элективные дисциплины (модули) по физической культуре и спорту",
          //   controlPoints: [100],
          //   type: "Лекция",
          //   time: "8:30-10:00",
          // ),
          // const SubjectWidget(
          //   teacher: "доц.Рутта. Н.А.",
          //   name:
          //       "Элективные дисциплины (модули) по физической культуре и спорту",
          //   controlPoints: [],
          //   type: "Лекция",
          //   time: "8:30-10:00",
          // )
        ]),
      ),
    );
  }
}
