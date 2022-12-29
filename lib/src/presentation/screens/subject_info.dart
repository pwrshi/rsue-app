import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rsue_app/src/core/api/response.dart';
import 'package:rsue_app/src/domain/entities/quiz_entity.dart';
import 'package:rsue_app/src/domain/entities/subject_entity.dart';
import 'package:rsue_app/src/domain/usecases/subject_summary_by_name_usecase.dart';
import 'package:rsue_app/src/presentation/screens/session.dart';
import 'package:rsue_app/src/presentation/widgets/app_bar.dart';
import 'package:rsue_app/src/presentation/widgets/schedule/subject.dart';

class SubjectInfoScreen extends StatefulWidget {
  const SubjectInfoScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SubjectInfoScreenState();
}

class _SubjectInfoScreenState extends State<SubjectInfoScreen> {
  Widget genBlock<T>(Response<T> content, Widget Function(T) successFunction) {
    switch (content.status) {
      case ResponseStatus.done:
        return successFunction(content.content as T);
      case ResponseStatus.restored:
        return successFunction(content.content as T);
      case ResponseStatus.error:
        return Text(content.error.toString());
      case ResponseStatus.loading:
        return const Center(
          child: CircularProgressIndicator(),
        );
      case ResponseStatus.init:
        return const Text("Инит");
    }
  }

  @override
  Widget build(BuildContext context) {
    var name = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
        appBar: CustomAppBar(
          leading: IconButton(
            icon: const Icon(FluentIcons.arrow_left_16_filled),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          titleText: name,
        ),
        body: Builder(
          builder: (context) {
            var value = context.watch<SubjectSummaryByNameUseCase>();
            var snap = value.get(args: name);
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
                        summary!.quiz,
                        (Quiz quiz) => QuizWidget(
                              name: quiz.name,
                              datetime: quiz.dateTime,
                              teachers: quiz.teachers,
                              rooms: quiz.rooms,
                            )),
                    genBlock(
                        summary.subject,
                        (SubjectEntity subject) => SubjectWidget(
                            name: subject.name,
                            controlPoints: subject.controlPoints,
                            teacher: subject.teachersname,
                            type:
                                SubjectWidget.sessionTypeToString(subject.type),
                            statement: subject.statement,
                            isClosed: subject.isClosed))
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
