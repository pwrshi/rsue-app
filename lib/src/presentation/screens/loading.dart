import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rsue_app/src/domain/repositories/portfolio_repository.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<PortfolioRepository>().isAuthorized().then((value) {
      if (value) {
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
