import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rsue_schedule_api/rsue_schedule_api.dart';

class SelectGroup extends StatefulWidget {
  const SelectGroup({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => SelectGroupState();
}

class SelectGroupState extends State<SelectGroup> {
  PageController ctrl = PageController(initialPage: 0);
  int facult = 1;
  int course = 1;
  int group = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: PageView(
          controller: ctrl,
          children: [
            FutureBuilder<Map<int, String>?>(
                future: getFacults(),
                builder: ((context, snapshot) {
                  if (snapshot.hasData) {
                    var values = snapshot.data;

                    values?.remove(0);
                    List<Widget> facults = [];
                    values?.forEach((key, value) {
                      facults.add(ListTile(
                        leading: Text(key.toString()),
                        title: Text(value),
                        onTap: () {
                          setState(() {
                            facult = key;
                            ctrl.nextPage(duration: const Duration(seconds: 1), curve: Curves.easeIn);
                          });
                        },
                      ));
                    });

                    return ListView(children: facults);
                  }
                  return const FlutterLogo();
                })),
            FutureBuilder<Map<int, String>?>(
                future: getCourses(facult),
                builder: ((context, snapshot) {
                  if (snapshot.hasData) {
                    var values = snapshot.data;

                    values?.remove(0);
                    List<Widget> facults = [];
                    values?.forEach((key, value) {
                      facults.add(ListTile(
                        leading: Text(key.toString()),
                        title: Text(value),
                        onTap: () {
                          setState(() {
                            course = key;
                            ctrl.nextPage(duration: const Duration(seconds: 1), curve: Curves.easeIn);
                          });
                        },
                      ));
                    });

                    return ListView(children: facults);
                  }
                  return const FlutterLogo();
                })), 
                FutureBuilder<Map<int, String>?>(
                future: getGroups(facult, course),
                builder: ((context, snapshot) {
                  if (snapshot.hasData) {
                    var values = snapshot.data;

                    values?.remove(0);
                    List<Widget> facults = [];
                    values?.forEach((key, value) {
                      facults.add(ListTile(
                        leading: Text(key.toString()),
                        title: Text(value),
                        onTap: () {
                          setState(() {
                            group = key;
                            ctrl.nextPage(duration: const Duration(seconds: 1), curve: Curves.easeIn);
                          });
                        },
                      ));
                    });

                    return ListView(children: facults);
                  }
                  return const FlutterLogo();
                })), 
          ],
        ));
  }
}
