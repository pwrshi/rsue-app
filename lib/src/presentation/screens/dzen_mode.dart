import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rsue_app/src/domain/usecases/schedule_snapshot.dart';
import 'package:rsue_app/src/presentation/widgets/app_bar.dart';
import 'package:rsue_app/src/presentation/widgets/schedule/schedule.dart';

class DzenModeScreen extends StatelessWidget {
  const DzenModeScreen({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          titleText: "Расписание",
          actions: [
            IconButton(
              icon: const Icon(FluentIcons.person_16_filled),
              onPressed: () {
                Navigator.pushNamed(context, '/autor');
              },
            ),
            IconButton(
              icon: const Icon(
                FluentIcons.sign_out_24_filled,
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/introduction');
              },
            ),
          ],
        ),
        body: ScheduleViewer(
          snapshot: Provider.of<ScheduleServiceSnapshot>(context),
        ));
  }
}
