import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:provider/provider.dart';

class MenuScaffold extends StatelessWidget {
  const MenuScaffold({super.key, required this.mainScreen, required this.menu});
  final Widget mainScreen;
  final List<Widget> menu;
  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      shadowLayer2Color: const Color(0xFF334E68),
      shadowLayer1Color: const Color(0xFF486581),
      menuBackgroundColor: const Color(0xFF102A43),
      controller: Provider.of<ZoomDrawerController>(context),
      menuScreen: Align(
        alignment: Alignment.bottomLeft,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20.0, left: 5.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: menu,
          ),
        ),
      ),
      mainScreen: mainScreen,
      borderRadius: 45.0,
      showShadow: true,
      angle: -15.0,
      drawerShadowsBackgroundColor: const Color(0xFF334E68),
      slideWidth: MediaQuery.of(context).size.width * 0.65,
    );
  }
}

class MenuButton extends StatelessWidget {
  const MenuButton(
      {super.key,
      required this.icon,
      required this.text,
      required this.onPressed});
  final void Function()? onPressed;
  final IconData icon;
  final String text;
  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onPressed,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(
                icon,
                size: 18,
              ),
            ),
            Text(
              text,
              style: const TextStyle(fontSize: 16),
            )
          ],
        ));
  }
}
