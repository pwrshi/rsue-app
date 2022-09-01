import 'package:flutter/material.dart';
import '../lib_de/views/portfolio_auth/portfolio_auth.dart';
import 'views/home/home.dart';
import 'view_models/user.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';

void main() {
  initializeDateFormatting().then((_) => runApp(const App()));
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  Widget routestub(context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(ModalRoute.of(context)?.settings.name ?? "default"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
      create: (context) => UserViewModel(),
      child: MaterialApp(
        title: 'app',
        initialRoute: '/home',
        locale: const Locale('ru'),
        routes: {
          '/home': (context) => const Home(),
          '/intro': routestub,
          '/portfolio_auth': (context) => const PortfolioAuth(),
          '/schedule_auth': routestub
        },
      ));
}
