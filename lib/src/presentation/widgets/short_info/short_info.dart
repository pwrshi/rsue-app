import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rsue_app/src/core/api/response.dart';
import 'package:rsue_app/src/domain/usecases/widget/short_info.dart';

import 'left_column.dart';
import 'right_column.dart';

class ShortInfo extends StatelessWidget {
  const ShortInfo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FittedBox(child: Builder(
      builder: (context) {
        switch (context.watch<ShortInfoProvider>().state) {
          case ResponseStatus.error:
            return Container(
              decoration: const BoxDecoration(
                  color: Color(0xFFF75D5F),
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              height: 140,
              width: 342,
              child: const Center(
                child: Text("Ошибка"),
              ),
            );
          case ResponseStatus.done:
            return Row(
              children: [
                Column(mainAxisSize: MainAxisSize.max, children: const [
                  TopLeftInfoWidget(),
                  SizedBox(
                    height: 8,
                  ),
                  BottomLeftInfoWidget()
                ]),
                const SizedBox(
                  width: 8,
                ),
                const RightColumnInfoWidget()
              ],
            );
          case ResponseStatus.restored:
            return Row(
              children: [
                Column(mainAxisSize: MainAxisSize.max, children: const [
                  TopLeftInfoWidget(),
                  SizedBox(
                    height: 8,
                  ),
                  BottomLeftInfoWidget()
                ]),
                const SizedBox(
                  width: 8,
                ),
                const RightColumnInfoWidget()
              ],
            );
          default:
            return Container(
              decoration: const BoxDecoration(
                  color: Color(0xFF486581),
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              height: 140,
              width: 342,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
        }
      },
    ));
  }
}
