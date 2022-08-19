import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class FloatingBottomBar extends StatelessWidget {
  FloatingBottomBar({required this.page, required this.onTap});
  final void Function(int) onTap;
  final RxInt page;

  static const _buttons = [
    BottomNavigationBarItem(
        icon: Padding(
          padding: EdgeInsets.only(top: 12, left: 10, right: 10),
          child: Icon(
            FluentIcons.glance_24_filled,
            size: 26,
          ),
        ),
        label: 'Home\n'),
    BottomNavigationBarItem(
        icon: Padding(
          padding: EdgeInsets.only(top: 12, left: 10, right: 10),
          child: Icon(FluentIcons.communication_24_filled),
        ),
        label: "News\n"),
    BottomNavigationBarItem(
        icon: Padding(
          padding: EdgeInsets.only(top: 12, left: 10, right: 10),
          child: Icon(FluentIcons.person_24_filled),
        ),
        label: 'Me\n'),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(
          bottom: 26,
          left: 80,
          right: 80,
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          child: Obx(
            (() => BottomNavigationBar(
                fixedColor: Theme.of(context).textTheme.bodyText1?.color,
                currentIndex: page.value,
                onTap: onTap,
                unselectedFontSize: 10,
                selectedFontSize: 10,
                iconSize: 30,
                backgroundColor: Theme.of(context).primaryColorLight,
                items: _buttons)),
          ),
        ));
  }
}
