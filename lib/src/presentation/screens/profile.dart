import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:rsue_app/src/presentation/widgets/schedule/subject.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(FluentIcons.arrow_left_16_filled),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "Профиль",
          style: TextStyle(fontFamily: "Rubik_glitch"),
        ),
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
                    onPressed: () {},
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
                          FluentIcons.barcode_scanner_24_filled,
                          size: 42,
                          weight: 2,
                        ),
                        SizedBox(
                          width: 9,
                        ),
                        Text(
                          "13\nПлатежи",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w700),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: 9,
                ),
                Expanded(
                  child: FilledButton(
                    onPressed: () {},
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
          const SubjectWidget(
            teacher: "доц.Рутта. Н.А.",
            name: "Математика",
            controlPoints: [90, 20],
            type: "Лекция",
            time: "8:30-10:00",
          ),
          const SubjectWidget(
            teacher: "доц.Рутта. Н.А.",
            name:
                "Элективные дисциплины (модули) по физической культуре и спорту",
            controlPoints: [100],
            type: "Лекция",
            time: "8:30-10:00",
          ),
          const SubjectWidget(
            teacher: "доц.Рутта. Н.А.",
            name:
                "Элективные дисциплины (модули) по физической культуре и спорту",
            controlPoints: [],
            type: "Лекция",
            time: "8:30-10:00",
          )
        ]),
      ),
    );
  }
}
