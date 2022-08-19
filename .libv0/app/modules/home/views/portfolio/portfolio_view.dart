import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:rsue_portfolio_api/rsue_portfolio_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controllers/portfolio_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PortfolioView extends GetView<PortfolioController> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            children: [
              FutureBuilder(future: Future(() async {
                var sp = await SharedPreferences.getInstance();
                var login = sp.getString("rsue_portfolio_login");
                var password = sp.getString("rsue_portfolio_password");
                if (login == null || password == null) {
                  return Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        gradient: LinearGradient(
                            colors: [
                              Color(0xFFF160DA),
                              Color(0xFF60A1F1),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight),
                      ),
                      child: Column(children: [
                        Text(
                          "Войдите в портфолио РГЭУ (РИНХ), чтобы получить дополнительный опыт",
                          textAlign: TextAlign.center,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: OutlinedButton(
                              style: ButtonStyle(
                                  side: MaterialStateProperty.all<BorderSide>(
                                      BorderSide(
                                          width: 1, color: Colors.white)),
                                  shape:
                                      MaterialStateProperty.all<OutlinedBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10))))),
                              onPressed: () {
                                Get.toNamed("/rsuelogin");
                              },
                              child: Text(
                                "Вход",
                                style: Theme.of(context).textTheme.bodyText1,
                              )),
                        )
                      ]));
                } else {
                  var data = await whoami(username: login, password: password);
                  if (data == null) {
                    return Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            color: Theme.of(context).primaryColor),
                        child: Text(
                            "Очень странная ошибка, ты не должен был её видеть"));
                  }
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        color: Theme.of(context).primaryColor),
                    child: Column(children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            data["Фамилия"] + " " + data["Имя"] ?? "",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          Text(
                            data["Группа"] ?? "",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Row(
                          children: [
                            Text(
                              data["Направление подготовки (или специальность)"] ??
                                  "",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            )
                          ],
                        ),
                      )
                    ]),
                  );
                }
              }), builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return snapshot.data;
                }
                return LinearProgressIndicator();
              }),
              // SizedBox(
              //   width: MediaQuery.of(context).size.width,
              //   height: MediaQuery.of(context).size.height - 400,
              //   child: GridView.count(
              //     crossAxisCount: 2,
              //     children: [
              //       TextButton(
              //           onPressed: () {},
              //           child: Column(
              //             mainAxisAlignment: MainAxisAlignment.center,
              //             children: [
              //               Icon(
              //                 FluentIcons.settings_28_filled,
              //                 size: 60,
              //               ),
              //               Text("Настройки")
              //             ],
              //           )),
              //       TextButton(
              //           onPressed: () {},
              //           child: Column(
              //             mainAxisAlignment: MainAxisAlignment.center,
              //             children: [
              //               Icon(
              //                 FluentIcons.tab_in_private_28_filled,
              //                 size: 60,
              //               ),
              //               Text("Внешний вид")
              //             ],
              //           )),
              //       TextButton(
              //           onPressed: () {},
              //           child: Column(
              //             mainAxisAlignment: MainAxisAlignment.center,
              //             children: [
              //               Icon(
              //                 FluentIcons.app_folder_20_filled,
              //                 size: 60,
              //               ),
              //               Text("Сервисы")
              //             ],
              //           )),
              //       TextButton(
              //           onPressed: () {},
              //           child: Column(
              //             mainAxisAlignment: MainAxisAlignment.center,
              //             children: [
              //               Icon(
              //                 FluentIcons.info_28_filled,
              //                 size: 60,
              //               ),
              //               Text("Помощь")
              //             ],
              //           )),
              //     ],
              //   ),
              // )
            ],
          ),
        ),
      ],
    );
  }
}
