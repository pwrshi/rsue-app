import 'package:flutter/material.dart';

import 'left_column.dart';
import 'right_column.dart';

class ShortInfo extends StatelessWidget {
  const ShortInfo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FittedBox(
        child: Row(
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
    ));
  }
}
