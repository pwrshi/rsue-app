import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar(
      {super.key, required this.titleText, this.leading, this.actions});
  final String titleText;
  final Widget? leading;
  final List<Widget>? actions;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: actions,
      leading: leading,
      elevation: 0,
      backgroundColor: Theme.of(context).colorScheme.background,
      centerTitle: true,
      title: Text(
        titleText,
        style: const TextStyle(fontFamily: "Rubik_glitch"),
      ),
    );
  }

  @override
  Size get preferredSize => AppBar().preferredSize;

  factory CustomAppBar.withBack(
      {required String titleText, required BuildContext context}) {
    return CustomAppBar(
      titleText: titleText,
      leading: IconButton(
        icon: const Icon(FluentIcons.arrow_left_16_filled),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
