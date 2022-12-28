import 'package:expandable/expandable.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rsue_app/src/core/api/response.dart';
import 'package:rsue_app/src/domain/entities/quiz_entity.dart';
import 'package:rsue_app/src/domain/usecases/session_by_whoami_usecase.dart';
import 'package:rsue_app/src/presentation/widgets/app_bar.dart';

class ExpandQuizGroupWidget extends StatelessWidget {
  final List<Quiz> subjects;
  final String title;

  const ExpandQuizGroupWidget(this.title, this.subjects, {super.key});

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
              .map<Widget>((subject) => QuizWidget(
                    name: subject.name,
                    datetime: subject.dateTime,
                    rooms: subject.rooms,
                    teachers: subject.teachers,
                  ))
              .toList(),
        ),
      ),
    );
  }
}

class SessionScreen extends StatefulWidget {
  const SessionScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SessionScreenState();
}

class _SessionScreenState extends State<SessionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          leading: IconButton(
            icon: const Icon(FluentIcons.arrow_left_16_filled),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          titleText: "Сессия",
        ),
        body: Builder(
          builder: (context) {
            var session = context.watch<SessionByWhoamiUseCase>();

            switch (session.data.status) {
              case ResponseStatus.error:
                return ListView(
                  padding: const EdgeInsets.all(8),
                  children: [Text(session.data.error.toString())],
                );
              case ResponseStatus.loading:
                return ListView(
                  padding: const EdgeInsets.all(8),
                  children: [
                    Center(
                      child: Column(
                        children: const [
                          CircularProgressIndicator(),
                          SizedBox(
                            height: 12,
                          ),
                          Text("Это долго :(")
                        ],
                      ),
                    )
                  ],
                );
              default:
                return ListView(
                  padding: const EdgeInsets.all(8),
                  children: session.data.content!.$1
                      .map<Widget>((subject) => QuizWidget(
                            name: subject.name,
                            datetime: subject.dateTime,
                            rooms: subject.rooms,
                            teachers: subject.teachers,
                          ))
                      .toList(),
                );
            }
          },
        ));
  }
}

class QuizWidget extends StatelessWidget {
  const QuizWidget(
      {super.key,
      required this.name,
      this.datetime,
      this.rooms,
      this.teachers});
  final String name;
  final String? datetime, rooms, teachers;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Container(
        margin: const EdgeInsets.only(top: 8),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Material(
            color: const Color(0xff486581),
            child: InkWell(
              onTap: (() async {
                Navigator.of(context)
                    .pushNamed("/subject_info", arguments: name);
              }),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 260,
                          child: Text(
                            name,
                            style: const TextStyle(
                              color: Color(0xffbcccdc),
                              fontSize: 13,
                              fontFamily: "Rubik",
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          width: 260,
                          child: Wrap(
                            runSpacing: 8,
                            spacing: 8,
                            children: [
                              ChipWidget(
                                text: datetime ?? ":(",
                              ),
                              ChipWidget(
                                text: rooms ?? ":(",
                              ),
                              ChipWidget(
                                text: teachers ?? ":(",
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    const Icon(
                      FluentIcons.chevron_right_48_filled,
                      size: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ChipWidget extends StatelessWidget {
  const ChipWidget({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: const Color(0xff334e68),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white54,
          fontSize: 12,
          fontWeight: FontWeight.bold,
          fontFamily: "Rubik",
        ),
      ),
    );
  }
}
