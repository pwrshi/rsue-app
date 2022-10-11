import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rsue_app/src/domain/usecases/data/schedule_snapshot.dart';
import 'package:rsue_app/src/presentation/widgets/app_bar.dart';
import 'package:rsue_app/src/presentation/widgets/schedule/schedule.dart';

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar.withBack(
          context: context,
          titleText: "Расписание",
        ),
        body: ScheduleViewer(
          snapshot: Provider.of<ScheduleServiceSnapshot>(context),
        ));
  }
}
