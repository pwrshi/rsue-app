import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rsue_app/src/domain/repositories/portfolio_repository.dart';
import 'package:rsue_app/src/domain/repositories/schedule_repository.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.sync(() async => [
          await context.read<PortfolioRepository>().isAuthorized(),
          await context.read<ScheduleRepository>().isAuthorized()
        ]).then((List<bool> value) {
      if (value[0] && value[1]) {
        Navigator.pushNamedAndRemoveUntil(context, "/home", (route) => false);
      } else {
        Navigator.pushNamedAndRemoveUntil(
            context, "/introduction", (route) => false);
      }
    });
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
