import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:rsue_app/src/core/api/response.dart';
import 'package:rsue_app/src/core/resources/data_state.dart';
import 'dart:async';

import 'package:rsue_app/src/domain/entities/group_entity.dart';
import 'package:rsue_app/src/domain/repositories/schedule_repository.dart';

// Фейковые данные

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

Future<bool> checkAccount(String login, String password) {
  return Future.delayed(const Duration(seconds: 2), () {
    return true;
  });
}

// Непосредственно реализация экрана

class IntroductionScreen extends StatefulWidget {
  const IntroductionScreen({super.key});

  @override
  State<StatefulWidget> createState() => _IntroductionScreenState();
}

class _IntroductionScreenState extends State<IntroductionScreen> {
  PageController pctrl = PageController();

  // Константы для анимации перехода между страниц
  static const typeAnimation = Curves.easeOut;
  static const animationSpeed = Duration(milliseconds: 300);

  String? dsName;
  GroupId? group;
  String? login, password;
  int pageBuffer = 0;

  @override
  void initState() {
    pctrl.addListener(() {
      //double currentpage;
      // try {
      //   currentpage = pctrl.page!;
      // } catch (e) {
      //   currentpage = 0;
      // }
      // if (currentpage.ceil() != pageBuffer) {

      // }
      setState(() {
        //pageBuffer = currentpage.ceil();
      });
    });
    super.initState();
  }

  bool mayITurnPage() {
    double currentpage;
    try {
      currentpage = pctrl.page!;
    } catch (e) {
      currentpage = 0;
    }
    if ((dsName == null) && (currentpage == 1.0)) {
      return false;
    }
    if ((group == null) && (currentpage == 2.0)) {
      return false;
    }
    if (((login == null) || (password == null)) && (currentpage == 3.0)) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pctrl,
        children: [
          // первая страница
          const FirstPage(),
          // вторая страница
          SecondPage(
            dss: Provider.of<ScheduleRepository>(context, listen: false)
                .getDatasources(),
            setDataSource: (value) {
              setState(() {
                dsName = value;
                Provider.of<ScheduleRepository>(context, listen: false)
                    .setDatasource(value);
              });
            },
          ),
          // третья страница
          ThirdPage(
            onUnset: () {
              Provider.of<ScheduleRepository>(context, listen: false)
                  .unsetGroup();
              setState(() {
                group = null;
              });
              // ScaffoldMessenger.of(context)
              //     .showSnackBar(const SnackBar(content: Text("Убрана")));
            },
            onSet: (f, c, g) {
              setState(() {
                Provider.of<ScheduleRepository>(context, listen: false)
                    .setGroupByGroupId(
                        group = GroupId(facult: f, course: c, group: g));
              });
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text("$f, $c, $g")));
            },
          ),
          // четвёртая страница
          FourthPage(
            onLogin: (login, password) {
              setState(() {
                this.login = login;
                this.password = password;
              });
            },
          ),
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
                  setState(() {});
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
                    if (mayITurnPage()) {
                      pctrl.animateToPage((pctrl.page!.toInt() + 1),
                          duration: animationSpeed, curve: typeAnimation);
                      double currentpage;
                      try {
                        currentpage = pctrl.page!;
                      } catch (e) {
                        currentpage = 0;
                      }
                      if (((login != null) || (password != null)) &&
                          (currentpage == 3.0)) {
                        Navigator.pushNamed(context, "/home");
                      }
                    }
                  },
                  style: mayITurnPage()
                      ? FilledButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          backgroundColor: const Color(0xFF486581),
                          foregroundColor: Colors.white,
                        )
                      : FilledButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          backgroundColor: const Color(0xFF334E68),
                          foregroundColor: const Color(0xff9FB3C8),
                        ),
                  child: const Text("Далее")),
            )
          ]),
        ),
      ),
    );
  }
}

class FourthPage extends StatefulWidget {
  const FourthPage({super.key, required this.onLogin});
  final void Function(String login, String password) onLogin;
  @override
  State<StatefulWidget> createState() => _FourthPageState();
}

class _FourthPageState extends State<FourthPage> {
  TextEditingController loginField = TextEditingController(),
      passwordField = TextEditingController();
  bool enabled = true;
  RoundedLoadingButtonController lbc = RoundedLoadingButtonController();
  Response<bool> isSuccessful = const Response(status: ResponseStatus.init);
  InputDecoration getDecoration(bool enabled, String placeholder) =>
      InputDecoration(
        contentPadding: const EdgeInsets.all(20),
        enabled: enabled,
        filled: true,
        fillColor: const Color(0xFF486581),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(15))),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(15))),
        border: const OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(15))),
        labelText: placeholder,
      );
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Text(
          "Войдите в портфолио",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
        ),
        Expanded(
            child: Center(
                child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: loginField,
              decoration: getDecoration(enabled, "Логин"),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: passwordField,
              decoration: getDecoration(enabled, "Пароль"),
              obscureText: true,
            ),
            const SizedBox(
              height: 20,
            ),
            RoundedLoadingButton(
                color: const Color(0xff486581),
                successColor: const Color(0xff0FCA7A),
                onPressed: () {
                  setState(() {
                    enabled = false;
                  });
                  isSuccessful = const Response(status: ResponseStatus.loading);
                  lbc.start();
                  checkAccount(loginField.text, passwordField.text)
                      .then((value) {
                    if (mounted) {
                      setState(() {
                        isSuccessful = Response(
                            status: ResponseStatus.done, content: value);
                        if (value) {
                          lbc.success();
                          widget.onLogin(loginField.text, passwordField.text);
                        } else {
                          lbc.error();
                          Future.delayed(const Duration(seconds: 3), () {
                            if (mounted) {
                              lbc.reset();
                              setState(() {
                                enabled = true;
                              });
                            }
                          });
                        }
                      });
                    }
                  });
                },
                controller: lbc,
                child: const Text("Проверить"))
          ],
        )))
      ],
    );
  }
}

class ThirdPage extends StatefulWidget {
  const ThirdPage({super.key, required this.onSet, required this.onUnset});
  final void Function(int f, int c, int g) onSet;
  final void Function() onUnset;
  @override
  State<StatefulWidget> createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {
  // Переменные для хранения результатов
  Response<Map<int, String>> facults =
          const Response(status: ResponseStatus.init),
      courses = const Response(status: ResponseStatus.init),
      groups = const Response(status: ResponseStatus.init);
  int? faculty, course, group;
  @override
  void initState() {
    super.initState();
  }

  // Сценарные действия

  void setFaculty(int value) {
    resetGroup();
    resetCourse();
    setState(() {
      faculty = value;
    });
    fetchCourse();
  }

  void setCourse(int value) {
    resetGroup();
    setState(() {
      course = value;
    });
    fetchGroups();
  }

  void setGroup(int value) {
    setState(() {
      group = value;
      widget.onSet(faculty!, course!, group!);
    });
  }

  void resetGroup() {
    if (group != null) {
      group = null;
      widget.onUnset();
    }
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
    Provider.of<ScheduleRepository>(context, listen: false)
        .getFacults()
        .then((value) {
      if (value is DataSuccess) {
        if (mounted) {
          setState(() {
            facults =
                Response(status: ResponseStatus.done, content: value.data);
          });
        }
      }
    });
  }

  void fetchCourse() {
    courses = const Response<Map<int, String>>(status: ResponseStatus.loading);
    Provider.of<ScheduleRepository>(context, listen: false)
        .getCoursesByFacultId(faculty!)
        .then((value) {
      if (value is DataSuccess) {
        if (mounted) {
          setState(() {
            courses =
                Response(status: ResponseStatus.done, content: value.data);
          });
        }
      }
    });
  }

  void fetchGroups() {
    groups = const Response<Map<int, String>>(status: ResponseStatus.loading);
    Provider.of<ScheduleRepository>(context, listen: false)
        .getGroupsByFacultIdAndCourseId(faculty!, course!)
        .then((value) {
      if (value is DataSuccess) {
        if (mounted) {
          setState(() {
            groups = Response(status: ResponseStatus.done, content: value.data);
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (facults.status == ResponseStatus.init) {
      fetchFacults();
    }
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Text(
          "Выбери группу",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
        ),
        SelectorWidget(
          placeholder: "Факультет",
          value: faculty,
          onChanged: (v) {
            setFaculty(v!);
          },
          items: facults,
        ),
        SelectorWidget(
          placeholder: "Курс",
          items: courses,
          value: course,
          onChanged: (v) {
            setCourse(v!);
          },
        ),
        SelectorWidget(
          placeholder: "Группа",
          items: groups,
          value: group,
          onChanged: (v) {
            setGroup(v!);
          },
        )
      ],
    );
  }
}

class SecondPage extends StatefulWidget {
  const SecondPage({super.key, required this.setDataSource, required this.dss});
  final void Function(String) setDataSource;
  final List<String> dss;
  @override
  State<StatefulWidget> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  String selected = "";
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 40.0),
            child: Text(
              "Выбери источник расписания",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
              child: ListView(children: [
            Wrap(
              alignment: WrapAlignment.center,
              runSpacing: 20,
              spacing: 20,
              children: [
                for (var el in widget.dss)
                  DataSourceWidget(
                    name: el,
                    selected: el == selected,
                    onPressed: () {
                      setState(() {
                        selected = el;
                        widget.setDataSource(el);
                      });
                    },
                  ),
              ],
            )
          ]))
        ],
      ),
    );
  }
}

class DataSourceWidget extends StatelessWidget {
  const DataSourceWidget(
      {super.key, required this.name, required this.selected, this.onPressed});
  final String name;
  final bool selected;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 133,
      width: 133,
      child: FilledButton(
          onPressed: onPressed,
          style: FilledButton.styleFrom(
            elevation: 30,
            shadowColor: const Color(0xFF486581),
            shape: RoundedRectangleBorder(
              side: selected
                  ? const BorderSide(width: 3, color: Color(0xFF9FB3C8))
                  : BorderSide.none,
              borderRadius: BorderRadius.circular(15.0),
            ),
            backgroundColor: const Color(0xFF486581),
            foregroundColor: Colors.white,
          ),
          child: Text(
            name,
            textAlign: TextAlign.center,
          )),
    );
  }
}

class FirstPage extends StatelessWidget {
  const FirstPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Text(
          "Привет!\n\nэто альтернативное приложения для доступа к сервисам РИНХ",
          style: TextStyle(fontSize: 18),
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
      case ResponseStatus.loading:
        return DropdownButton<int?>(
          enableFeedback: false,
          itemHeight: 90,
          isExpanded: true,
          //style: const TextStyle(overflow: TextOverflow.ellipsis),
          hint: Row(
            children: [
              Text(placeholder),
              const SizedBox(
                width: 25,
              ),
              const CircularProgressIndicator()
            ],
          ),
          value: null,
          icon: const Icon(Icons.arrow_downward),
          onChanged: null,
          items: null,
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
