import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rsue_app/src/core/api/response.dart';
import 'package:rsue_app/src/domain/usecases/portfolio_snapshot.dart';
import 'package:rsue_app/src/presentation/widgets/app_bar.dart';

class WhoamiScreen extends StatelessWidget {
  const WhoamiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.withBack(
        context: context,
        titleText: "Кто я?",
      ),
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
        if ((value.get().status == ResponseStatus.done) ||
            (value.get().status == ResponseStatus.restored)) {
          whoami = value.get().content!;
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
