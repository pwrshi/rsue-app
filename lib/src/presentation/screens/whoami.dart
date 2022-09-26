import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rsue_app/src/core/api/response.dart';
import 'package:rsue_app/src/domain/repositories/portfolio_repository.dart';
import 'package:rsue_app/src/presentation/providers/data/portfolio_snapshot.dart';

class WhoamiScreen extends StatelessWidget {
  WhoamiScreen({super.key});

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
            "Кто я?",
            style: TextStyle(fontFamily: "Rubik_glitch"),
          )),
      body: Builder(builder: (c) {
        var value = context.watch<WhoamiSnapshot>();
        Map<String, String> whoami = {
          "Фамилия": "-------",
          "Отчество": "---------",
          "Имя": "------",
          "Факультет": "--------- -------- ------- ----",
          "Направление подготовки (или специальность)": "--.--.-- ------ -----",
          "Группа": "--------",
          "Номер зачетной книжки": "------",
          "Год поступления": "----",
        };
        if ((value.data.status == ResponseStatus.done) ||
            (value.data.status == ResponseStatus.restored)) {
          whoami = value.data.content!;
        }
        return ListView(
          padding: const EdgeInsets.all(8),
          children: [
            Container(
              width: 341,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: const Color(0xff486581),
              ),
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (var kv in whoami.entries)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          kv.key,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          kv.value,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontFamily: "Rubik",
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(
                          height: 17,
                        ),
                      ],
                    ),
                ],
              ),
            )
          ],
        );
      }),
    );
  }
}
