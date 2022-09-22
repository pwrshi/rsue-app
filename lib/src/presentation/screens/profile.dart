import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rsue_app/src/core/resources/data_state.dart';
import 'package:rsue_app/src/domain/repositories/portfolio_repository.dart';
import 'package:rsue_app/src/presentation/widgets/schedule/subject.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
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
                        FutureBuilder(
                            future: Provider.of<PortfolioRepository>(context)
                                .getPayments(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Text(
                                    "${snapshot.data!.data?.length}\nПлатежи");
                              }
                              return const Text("--\nПлатежи");
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
          FutureBuilder(
              future: Provider.of<PortfolioRepository>(context)
                  .getAcademicPerfomance(),
              builder: (c, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data is DataFailed) {
                    return Container(
                      color: const Color(0xFF486581),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 20),
                      child: Text(snapshot.data!.error!.name),
                    );
                  }
                  return Column(
                    children: [
                      for (var s in snapshot.data!.data!.entries) ...[
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 20.0, left: 8, right: 8, bottom: 8),
                          child: Text(s.key),
                        ),
                        for (var subject in s.value)
                          SubjectWidget(
                              name: subject.name,
                              controlPoints: subject.controlPoints,
                              teacher: subject.teachersname,
                              isClosed: subject.isClosed,
                              statement: subject.statement,
                              type: SubjectWidget.sessionTypeToString(
                                  subject.type))
                      ]
                    ],
                  );
                }
                return const CircularProgressIndicator();
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
