import 'package:auto_size_text/auto_size_text.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:rsue_app/src/domain/entities/subject_entity.dart';

class SubjectWidget extends StatelessWidget {
  const SubjectWidget(
      {super.key,
      required this.name,
      required this.controlPoints,
      required this.teacher,
      required this.type,
      required this.statement,
      required this.isClosed});
  final String type, name, teacher;
  final List<int> controlPoints;
  final int statement;
  final bool isClosed;

  static String sessionTypeToString(SessionType s) {
    switch (s) {
      case SessionType.credit:
        return "Зачёт";
      case SessionType.exam:
        return "Экзамен";
      default:
        return "Практика";
    }
  }

  Widget getMark() {
    if (controlPoints.isEmpty) {
      return const Text("0_o");
    }
    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: const Color(0xFFD9E2EC)),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(9),
                color: const Color(0xFF486581)),
            child: Text(
              controlPoints[0].toString(),
              style: const TextStyle(
                  color: Color(0xFFD9E2EC),
                  fontWeight: FontWeight.w500,
                  fontSize: 12),
            ),
          ),
          for (var point in controlPoints.skip(1))
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
                child: Text(
                  point.toString(),
                  style: const TextStyle(
                      color: Color(0xFF486581),
                      fontWeight: FontWeight.w500,
                      fontSize: 12),
                )),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FittedBox(
        child: Container(
      margin: const EdgeInsets.only(top: 9),
      padding: const EdgeInsets.all(15),
      width: 342,
      height: 161,
      decoration: const BoxDecoration(
          color: Color(0xFF486581),
          borderRadius: BorderRadius.all(Radius.circular(15))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                type,
                style: const TextStyle(fontSize: 12),
              ),
              getMark()
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ConstrainedBox(
                    constraints: BoxConstraints.loose(const Size(270, 70)),
                    child: AutoSizeText(name,
                        minFontSize: 12,
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 38,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        )),
                  ),
                  Text(teacher, style: const TextStyle(fontSize: 12)),
                ],
              ),
              Column(children: [
                (isClosed
                    ? const Icon(
                        FluentIcons.presence_available_24_filled,
                        size: 15,
                      )
                    : const Icon(
                        FluentIcons.presence_away_24_filled,
                        size: 15,
                      )),
                const SizedBox(
                  height: 2,
                ),
                Text(
                  statement.toString(),
                  style: const TextStyle(fontSize: 10),
                )
              ])
            ],
          )
        ],
      ),
    ));
  }
}
