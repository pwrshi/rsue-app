import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:rsue_app/src/presentation/widgets/app_bar.dart';

class SubjectInfoScreen extends StatefulWidget {
  const SubjectInfoScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SubjectInfoScreenState();
}

class _SubjectInfoScreenState extends State<SubjectInfoScreen> {
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
          titleText: ModalRoute.of(context)!.settings.arguments as String,
        ),
        body: ListView());
  }
}
