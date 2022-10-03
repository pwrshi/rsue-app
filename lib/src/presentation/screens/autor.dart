import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:rsue_app/src/presentation/widgets/app_bar.dart';
import 'package:url_launcher/url_launcher.dart';

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
                "Made by",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
              )),
            ),
            SizedBox(
              height: 200,
              width: double.infinity,
              child: Center(
                child: Image.asset("assets/images/me.png"),
              ),
            ),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: Center(
                child: SizedBox(
                  width: 160,
                  height: 50,
                  child: TextButton(
                      onPressed: () async {
                        var url = Uri.parse("https://github.com/pwrshi");
                        await launchUrl(url);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/images/gh.png",
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Text("pwrshi",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w700))
                        ],
                      )),
                ),
              ),
            ),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: Center(
                child: SizedBox(
                  width: 160,
                  height: 50,
                  child: TextButton(
                      onPressed: () async {
                        var url = Uri.parse("https://vk.com/pwrshi");
                        await launchUrl(url);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/images/vk.png",
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Text("pwrshi",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w700))
                        ],
                      )),
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            const SizedBox(
              height: 50,
              width: double.infinity,
              child: Center(
                  child: Text(
                "from",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
              )),
            ),
            SizedBox(
              height: 200,
              width: double.infinity,
              child: Center(
                child: Image.asset("assets/images/ktiib_short.png"),
              ),
            )
          ],
        ));
  }
}
