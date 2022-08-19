import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../lib_de/models/apis/response.dart';
import '../../../../lib_de/view_models/user.dart';
import '../../../../lib_de/views/home/portfolio/short_info/short_info.dart';

class PortfolioPage extends StatelessWidget {
  const PortfolioPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (context.watch<UserViewModel>().hasAuthorized) {
      case true:
        return Center(
            child: Column(children: const [Expanded(child: SubjectsView())]));
      case false:
        return Column(
          children: [
            TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/portfolio_auth");
                },
                child: const Text("Залогиниться")),
            const Text("PortfolioPage"),
          ],
        );
      default:
        return const Text("Неизвестное состояние");
    }
  }
}

class SubjectItem extends StatelessWidget {
  const SubjectItem(
      {Key? key,
      required this.label,
      required this.controlPoint2,
      required this.controlPoint1,
      required this.isClosed,
      required this.type,
      required this.deal})
      : super(key: key);

  final String label;
  final int controlPoint2, controlPoint1;
  final bool isClosed;
  final String type;
  final int deal;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      height: 180,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.blueGrey.shade100,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: const BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                padding: const EdgeInsets.all(3),
                child: Row(children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      controlPoint1.toString(),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: Colors.blueGrey.shade100,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(7))),
                    child: Text(controlPoint2.toString()),
                  )
                ]),
              ),
              Text(
                type,
                style: const TextStyle(
                    fontWeight: FontWeight.w600, letterSpacing: 2),
              )
            ],
          ),
          SizedBox(
            height: 70,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: AutoSizeText(
                    label,
                    minFontSize: 12,
                    style: const TextStyle(
                        fontFamily: "Rubik",
                        fontWeight: FontWeight.w300,
                        fontSize: 30),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(isClosed ? Icons.check_circle : Icons.watch_later),
                    const SizedBox(height: 5),
                    Text(
                      deal.toString(),
                      style: const TextStyle(fontSize: 8),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SubjectsView extends StatelessWidget {
  const SubjectsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var data = context.watch<UserViewModel>().perfomance;
    switch (data.status) {
      case Status.initial:
        context.read<UserViewModel>().fetchPerfomance();
        return const Text("0_O");
      case Status.loading:
        return const CircularProgressIndicator();
      case Status.completed:
        return ListView(children: [
          const ShortInfo(),
          for (var semester in data.data!.entries) ...[
            Center(
              child: Text(semester.key),
            ),
            for (var subject in semester.value)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SubjectItem(
                    label: subject.name,
                    controlPoint2: subject.controlPoint2,
                    controlPoint1: subject.controlPoint1,
                    isClosed: subject.isClosed,
                    type: subject.type,
                    deal: subject.statement),
              )
          ]
        ]);
      case Status.error:
        return const Text("err");
    }
  }
}
