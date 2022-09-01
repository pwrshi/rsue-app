import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:provider/provider.dart';
import 'package:rsue_app/src/config/theme.dart';
import 'package:rsue_app/src/presentation/screens/home.dart';

void main() {
  runApp(const RsueApplication());
}

class RsueApplication extends StatelessWidget {
  const RsueApplication({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider<ZoomDrawerController>(
        create: (context) => ZoomDrawerController(),
        child: MaterialApp(
            theme: mainTheme,
            title: 'app',
            initialRoute: '/home',
            locale: const Locale('ru'),
            routes: {
              '/': (context) => const HomeScreen(),
            }));
  }
}
