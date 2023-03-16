import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:rsue_app/src/presentation/widgets/app_bar.dart';
import 'package:url_launcher/url_launcher_string.dart';

class AutorScreen extends StatefulWidget {
  const AutorScreen({super.key});

  @override
  State<StatefulWidget> createState() => _AutorScreenState();
}

class _AutorScreenState extends State<AutorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          leading: IconButton(
            icon: const Icon(FluentIcons.arrow_left_16_filled),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          titleText: "О приложении",
        ),
        body: ListView(
          children: [
            const SizedBox(
              height: 20,
            ),
            const SizedBox(
              height: 50,
              width: double.infinity,
              child: Center(
                  child: Text(
                "Сделано",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
              )),
            ),
            Center(
              child: Image.asset("assets/images/me.png"),
            ),
            const Center(
                child: Text(
              "pwrshi",
              style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.w700,
                  color: Colors.white),
            )),
            const Center(
                child: Text(
              "на полном энтузиазме",
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.white70),
            )),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () async {
                      await launchUrlString("https://github.com/pwrshi",
                          mode: LaunchMode.externalApplication);
                    },
                    child: Image.asset(
                      "assets/images/gh.png",
                      scale: 0.8,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      await launchUrlString("https://vk.com/pwrshi",
                          mode: LaunchMode.externalApplication);
                    },
                    child: Image.asset(
                      "assets/images/vk.png",
                      scale: 0.8,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 50,
              width: double.infinity,
              child: Center(
                  child: Text(
                "из",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
              )),
            ),
            SizedBox(
              height: 200,
              width: double.infinity,
              child: Center(
                child: Image.asset("assets/images/ktiib_short.png"),
              ),
            ),
            TextButton(
              onPressed: () async {
                Navigator.pushNamed(context, '/licenses');
              },
              child: const Text("Лицензии открытого ПО",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
            )
          ],
        ));
  }
}
