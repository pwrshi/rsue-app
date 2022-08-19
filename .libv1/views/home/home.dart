import 'package:flutter/material.dart';
import 'news/news.dart';
import 'portfolio/portfolio.dart';
import 'schedule/schedule.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => HomeState();
}

class HomeState extends State<Home> {
  int _pageId = 0;

  @override
  Widget build(BuildContext context) {
    return HomeView(
        pageId: _pageId,
        onChangePage: (id) {
          setState(() {
            _pageId = id;
          });
        });
  }
}

class HomeView extends StatelessWidget {
  final int pageId;
  final void Function(int) onChangePage;
  const HomeView({Key? key, required this.pageId, required this.onChangePage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      //   title: Text(
      //     ['Расписание', 'Новости', 'Портфолио'][pageId],
      //     style: const TextStyle(
      //         color: Colors.black,
      //         fontSize: 24,
      //         fontWeight: FontWeight.w900,
      //         letterSpacing: 1.4),
      //   ),
      // ),
      body: Center(
        child:
            // const Divider(
            //   indent: 10,
            //   endIndent: 10,
            //   height: 1,
            //   color: Colors.black12,
            // ),
            [const ScheduleBody(), const NewsPage(), const PortfolioPage()][pageId],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: pageId,
        destinations: const [
          NavigationDestination(
              icon: Icon(Icons.schedule), label: 'Расписание'),
          NavigationDestination(icon: Icon(Icons.newspaper), label: 'Новости'),
          NavigationDestination(icon: Icon(Icons.person), label: 'Портфолио')
        ],
        onDestinationSelected: onChangePage,
      ),
    );
  }
}
