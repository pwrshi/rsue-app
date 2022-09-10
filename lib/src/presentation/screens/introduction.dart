import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:rsue_app/src/core/api/response.dart';

Future<Map<int, String>> getFacults() {
  return Future.delayed(
      const Duration(seconds: 2),
      (() => {
            1: "Менеджмента и предпринимательства",
            2: "Торгового дела",
            3: "Компьютерных технологий и информационной безопасности",
            4: "Учетно-экономический",
          }));
}

Future<Map<int, String>> getCourses() {
  return Future.delayed(
      const Duration(seconds: 2), (() => {1: "1 курс", 2: "2 курс"}));
}

Future<Map<int, String>> getGroups() {
  return Future.delayed(
      const Duration(seconds: 2), (() => {1: "ПРИ-322", 2: "ПРИ-312"}));
}

class IntroductionScreen extends StatefulWidget {
  const IntroductionScreen({super.key});

  @override
  State<StatefulWidget> createState() => _IntroductionScreenState();
}

class _IntroductionScreenState extends State<IntroductionScreen> {
  PageController pctrl = PageController();
  static const typeAnimation = Curves.easeOut;
  static const animationSpeed = Duration(milliseconds: 300);
  Response<Map<int, String>> facults =
          const Response(status: ResponseStatus.init),
      courses = const Response(status: ResponseStatus.init),
      groups = const Response(status: ResponseStatus.init);

  int? faculty, course, group;
  MapEntry<int, String>? dropdownValue;
  @override
  void initState() {
    super.initState();
    Future.sync((() => fetchFacults())).then((value) => null);
  }

  void resetGroup() {
    group = null;
    groups = const Response(status: ResponseStatus.init);
  }

  void resetCourse() {
    course = null;
    courses = const Response(status: ResponseStatus.init);
  }

  void fetchFacults() {
    faculty = null;
    resetCourse();
    resetGroup();
    facults = const Response<Map<int, String>>(status: ResponseStatus.loading);
    getFacults().then((value) {
      setState(() {
        facults = Response(status: ResponseStatus.done, content: value);
      });
    });
  }

  void fetchCourse() {
    course = null;
    resetGroup();
    courses = const Response<Map<int, String>>(status: ResponseStatus.loading);
    getCourses().then((value) {
      setState(() {
        courses = Response(status: ResponseStatus.done, content: value);
      });
    });
  }

  void fetchGroups() {
    group = null;
    groups = const Response<Map<int, String>>(status: ResponseStatus.loading);
    getGroups().then((value) {
      setState(() {
        groups = Response(status: ResponseStatus.done, content: value);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pctrl,
        children: [
          const Center(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                "Привет!\n\nэто альтернативное приложения для доступа к сервисам РИНХ",
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const Text(
                  "Выбери источник расписания",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                ),
                Expanded(
                    child: Center(
                        child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      height: 133,
                      width: 133,
                      decoration: const BoxDecoration(
                          color: Color(0xFF486581),
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      child: const Center(
                          child: Text(
                        "Официальный сайт РИНХ",
                        textAlign: TextAlign.center,
                      )),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      height: 133,
                      width: 133,
                      decoration: const BoxDecoration(
                          color: Color(0xFF486581),
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      child: const Center(
                          child: Text(
                        "Бэкап tahinuke.ru",
                        textAlign: TextAlign.center,
                      )),
                    ),
                  ],
                )))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const Text(
                  "Выбери группу",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                ),
                SelectorWidget(
                  placeholder: "Факультет",
                  value: faculty,
                  onChanged: (value) {
                    setState(() {
                      faculty = value;
                      fetchCourse();
                    });
                  },
                  items: facults,
                ),
                SelectorWidget(
                  placeholder: "Курс",
                  items: courses,
                  value: course,
                  onChanged: (value) {
                    setState(() {
                      fetchGroups();
                      course = value;
                    });
                  },
                ),
                SelectorWidget(
                  placeholder: "Группа",
                  items: groups,
                  value: group,
                  onChanged: (value) {
                    setState(() {
                      group = value;
                    });
                  },
                )
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 15.0, left: 8, right: 8),
        child: SizedBox(
          height: 50,
          child: Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            FilledButton(
                onPressed: () {
                  pctrl.animateToPage((pctrl.page!.toInt() - 1),
                      duration: animationSpeed, curve: typeAnimation);
                },
                style: FilledButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  backgroundColor: const Color(0xFF486581),
                  foregroundColor: Colors.white,
                ),
                child: const Icon(FluentIcons.arrow_left_28_filled)),
            const SizedBox(
              width: 4,
            ),
            Expanded(
              child: FilledButton(
                  onPressed: () {
                    pctrl.animateToPage((pctrl.page!.toInt() + 1),
                        duration: animationSpeed, curve: typeAnimation);
                  },
                  style: FilledButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    backgroundColor: const Color(0xFF486581),
                    foregroundColor: Colors.white,
                  ),
                  child: const Text("Далее")),
            )
          ]),
        ),
      ),
    );
  }
}

class SelectorWidget extends StatelessWidget {
  const SelectorWidget(
      {super.key,
      this.value,
      required this.items,
      this.onChanged,
      required this.placeholder});
  final String placeholder;
  final int? value;
  final Response<Map<int, String>> items;
  final void Function(int?)? onChanged;
  @override
  Widget build(BuildContext context) {
    switch (items.status) {
      case ResponseStatus.done:
        return DropdownButton<int?>(
          itemHeight: 90,
          isExpanded: true,
          //style: const TextStyle(overflow: TextOverflow.ellipsis),
          hint: Text(placeholder),
          value: value,
          icon: const Icon(Icons.arrow_downward),
          onChanged: onChanged,
          items: items.content!.entries.map((MapEntry<int, String> item) {
            return DropdownMenuItem<int>(
              value: item.key,
              child: Text(
                item.value,
                overflow: TextOverflow.clip,
              ),
            );
          }).toList(),
        );
      default:
        return DropdownButton<int?>(
          enableFeedback: false,
          itemHeight: 90,
          isExpanded: true,
          //style: const TextStyle(overflow: TextOverflow.ellipsis),
          hint: Text(placeholder),
          value: null,
          icon: const Icon(Icons.arrow_downward),
          onChanged: null,
          items: null,
        );
    }
  }
}
