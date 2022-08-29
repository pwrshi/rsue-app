import 'package:flutter/material.dart';

import 'left_column.dart';
import 'right_column.dart';

class ShortInfo extends StatelessWidget {
  const ShortInfo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [LeftColumnInfoWidget(), RightColumnInfoWidget()],
    );
  }
}
