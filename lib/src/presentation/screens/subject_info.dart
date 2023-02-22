import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rsue_app/src/core/api/response.dart';
import 'package:rsue_app/src/domain/entities/quiz_entity.dart';
import 'package:rsue_app/src/domain/entities/session_type.dart';
import 'package:rsue_app/src/domain/entities/subject_entity.dart';
import 'package:rsue_app/src/domain/usecases/subject_summary_by_name_usecase.dart';
import 'package:rsue_app/src/presentation/screens/session.dart';
import 'package:rsue_app/src/presentation/widgets/app_bar.dart';

class SubjectInfoContainer extends StatelessWidget {
  const SubjectInfoContainer(
      {super.key, required this.title, required this.children});
  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    List<Widget> childrenWithTitle = children;
    children.insertAll(
      0,
      [
        Text(
          title,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
        const SizedBox(
          height: 15,
        ),
      ],
    );

    return FittedBox(
      child: Container(
          margin: const EdgeInsets.only(top: 9),
          width: 260,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: const Color(0xFF334E68)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: childrenWithTitle,
          )),
    );
  }
}

class SessionWidget extends StatelessWidget {
  const SessionWidget({super.key, this.room, this.dateTime, this.type});
  final String? room;
  final String? dateTime;
  final SessionType? type;

  String? typeToText() {
    switch (type) {
      case SessionType.credit:
        return "Зачёт";
      case SessionType.exam:
        return "Экзамен";
      case SessionType.practice:
        return "Практика";
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SubjectInfoContainer(
      title: "Сессия",
      children: [
        Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: const Color(0xFF486581)),
            child: FittedBox(
              child: Row(
                children: [
                  ChipWidget(text: dateTime ?? ":("),
                  const SizedBox(
                    width: 10,
                  ),
                  ChipWidget(text: "Каб.$room"),
                  const SizedBox(
                    width: 10,
                  ),
                  ChipWidget(text: typeToText() ?? ":(")
                ],
              ),
            ))
      ],
    );
  }
}

class TeacherListWidget extends StatelessWidget {
  const TeacherListWidget({super.key, this.teachers});
  final String? teachers;

  @override
  Widget build(BuildContext context) {
    return SubjectInfoContainer(
      title: "Преподаватели",
      children: [
        Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: const Color(0xFF486581)),
            child: Text(teachers ?? ":("))
      ],
    );
  }
}

class PerfomanceScoreScale extends StatelessWidget {
  const PerfomanceScoreScale({super.key, required this.absoluteScore});
  final List<int> absoluteScore;

  @override
  Widget build(BuildContext context) {
    var summary = absoluteScore.fold<double>(
        0, (previousValue, element) => previousValue + element);
    return FittedBox(
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Container(
              height: 20,
              width: 320,
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color(0xFF9FB3C8)),
              child: Row(children: [
                Container(
                  height: 16,
                  width: summary * 3.16,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color(0xFFF7A23B)),
                  child: Row(children: [
                    Container(
                      height: 16,
                      width: absoluteScore[0] * 3.16,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: const Color(0xFFFBC62F)),
                    )
                  ]),
                )
              ])),
          SizedBox(
            width: 320,
            height: 70,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                    width: 159,
                    height: 70,
                    child: Text(
                      "неуд",
                      style: summary < 50
                          ? const TextStyle(color: Color(0xFFF7A23B))
                          : null,
                      textAlign: TextAlign.center,
                    )),
                Container(
                  color: Colors.white,
                  width: 1,
                  height: 30,
                ),
                SizedBox(
                    width: 53,
                    height: 70,
                    child: Text(
                      "3",
                      style: (summary >= 50) && (summary < 67)
                          ? const TextStyle(color: Color(0xFFF7A23B))
                          : null,
                      textAlign: TextAlign.center,
                    )),
                Container(
                  color: Colors.white,
                  width: 1,
                  height: 30,
                ),
                SizedBox(
                    width: 53,
                    height: 70,
                    child: Text(
                      "4",
                      style: (summary >= 67) && (summary < 84)
                          ? const TextStyle(color: Color(0xFFF7A23B))
                          : null,
                      textAlign: TextAlign.center,
                    )),
                Container(
                  color: Colors.white,
                  width: 1,
                  height: 30,
                ),
                SizedBox(
                    width: 52,
                    height: 70,
                    child: Text(
                      "5",
                      style: (summary >= 84)
                          ? const TextStyle(color: Color(0xFFF7A23B))
                          : null,
                      textAlign: TextAlign.center,
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class AcademicPerfomanceSummaryWidget extends StatelessWidget {
  const AcademicPerfomanceSummaryWidget({super.key, required this.subject});
  final SubjectEntity subject;
  @override
  Widget build(BuildContext context) {
    return SubjectInfoContainer(title: "Оценка по предмету", children: [
      PerfomanceScoreScale(absoluteScore: subject.absoluteControlPoints),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Text(
            "По точкам:",
            style: TextStyle(fontSize: 10, color: Color(0xffD9E2EC)),
          ),
          Text(
            "Итоговый балл:",
            style: TextStyle(fontSize: 10, color: Color(0xffD9E2EC)),
          )
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            subject.controlPoints.length == 2
                ? "за первую: ${subject.controlPoints[0]}\nза вторую: ${subject.controlPoints[1]}"
                : "оценка: ${subject.controlPoints[0]}",
            style: const TextStyle(
                fontSize: 12, color: Colors.white, fontWeight: FontWeight.w500),
          ),
          Text(
            subject.finalMark.toString(),
            style: const TextStyle(
                fontSize: 40, color: Colors.white, fontWeight: FontWeight.w600),
          )
        ],
      ),
      const SizedBox(
        height: 5,
      ),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: const Color(0xFF486581)),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(
            subject.isClosed
                ? "Оценка утверждена"
                : "Оценка ещё не окончательная",
            style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            width: 35,
            height: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const VerticalDivider(
                  color: Color(0xff334E68),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 2.0),
                  child: Icon(
                    subject.isClosed
                        ? FluentIcons.presence_available_24_filled
                        : FluentIcons.presence_away_24_filled,
                    size: 14,
                  ),
                )
              ],
            ),
          )
        ]),
      )
    ]);
  }
}

class SubjectInfoScreen extends StatefulWidget {
  const SubjectInfoScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SubjectInfoScreenState();
}

class _SubjectInfoScreenState extends State<SubjectInfoScreen> {
  Widget genBlock<T>(Response<T> content, Widget Function(T) successFunction,
      String nullMessage) {
    switch (content.status) {
      case ResponseStatus.done:
        return successFunction(content.content as T);
      case ResponseStatus.restored:
        return successFunction(content.content as T);
      case ResponseStatus.error:
        return Text(content.error.toString() == "null"
            ? nullMessage
            : content.error.toString());
      case ResponseStatus.loading:
        return const Padding(
          padding: EdgeInsets.all(18.0),
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      case ResponseStatus.init:
        return const Text("Инит");
    }
  }

  @override
  Widget build(BuildContext context) {
    var pair =
        ModalRoute.of(context)!.settings.arguments as MapEntry<String, int?>;
    return Scaffold(
        appBar: CustomAppBar(
          leading: IconButton(
            icon: const Icon(FluentIcons.arrow_left_16_filled),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          titleText: pair.key,
        ),
        body: Builder(
          builder: (context) {
            var value = context.watch<SubjectSummaryByNameUseCase>();
            var snap = value.get(args: pair);
            switch (snap.status) {
              case ResponseStatus.error:
                return ListView(
                  padding: const EdgeInsets.all(8),
                  children: [Text(value.get().error.toString())],
                );
              case ResponseStatus.done:
                var summary = snap.content;
                return ListView(
                  padding: const EdgeInsets.all(8),
                  children: [
                    genBlock(
                        summary!.subject,
                        (SubjectEntity subject) =>
                            AcademicPerfomanceSummaryWidget(
                              subject: subject,
                            ),
                        "Успеваемость не найдена"),
                    genBlock(
                        summary.quiz,
                        (Quiz quiz) => TeacherListWidget(
                              teachers: quiz.teachers,
                            ),
                        ""),
                    genBlock(
                        summary.quiz,
                        (Quiz quiz) => SessionWidget(
                              room: quiz.rooms,
                              dateTime: quiz.dateTime,
                              type: quiz.type,
                            ),
                        "Сессия не найдена"),
                  ],
                );
              default:
                return ListView(
                  padding: const EdgeInsets.all(8),
                  children: const [Text("такого не может быть")],
                );
            }
          },
        ));
  }
}
