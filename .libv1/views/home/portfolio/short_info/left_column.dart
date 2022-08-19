import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../lib_de/models/apis/response.dart';
import '../../../../../lib_de/view_models/user.dart';

class TopLeftInfoWidget extends StatelessWidget {
  const TopLeftInfoWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var chart = context.watch<UserViewModel>().academicPerfomanceChart;

    return Container(
      width: 110,
      height: 150,
      decoration: BoxDecoration(
          color: Colors.lightBlue.shade100,
          borderRadius: const BorderRadius.all(Radius.circular(15))),
      child: Builder(builder: (context) {
        switch (chart.status) {
          case Status.completed:
            return CarouselSlider(
              items: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text((chart.data!.creditsArePassed >
                            chart.data!.creditsNeedToBePassed
                        ? "Сдано"
                        : "Нужно сдать")),
                    Text(
                      () {
                        if (chart.data!.creditsArePassed == 0) {
                          return chart.data!.creditsNeedToBePassed.toString();
                        } else if (chart.data!.creditsNeedToBePassed == 0) {
                          return chart.data!.creditsArePassed.toString();
                        } else if (chart.data!.creditsArePassed >
                            chart.data!.creditsNeedToBePassed) {
                          return "${chart.data!.creditsArePassed}/${chart.data!.creditsNeedToBePassed + chart.data!.creditsArePassed}";
                        } else {
                          return "${chart.data!.creditsNeedToBePassed}/${chart.data!.creditsNeedToBePassed + chart.data!.creditsArePassed}";
                        }
                      }.call(),
                      style: const TextStyle(
                          fontSize: 55,
                          fontWeight: FontWeight.w700,
                          fontFamily: "Rubik"),
                    ),
                    const Text("Зачетов")
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text((chart.data!.examsArePassed >
                            chart.data!.examsNeedToBePassed
                        ? "Сдано"
                        : "Нужно сдать")),
                    Text(
                      () {
                        if (chart.data!.examsArePassed == 0) {
                          return chart.data!.examsNeedToBePassed.toString();
                        } else if (chart.data!.examsNeedToBePassed == 0) {
                          return chart.data!.examsArePassed.toString();
                        } else if (chart.data!.examsArePassed >
                            chart.data!.examsNeedToBePassed) {
                          return "${chart.data!.examsArePassed}/${chart.data!.examsNeedToBePassed + chart.data!.examsArePassed}";
                        } else {
                          return "${chart.data!.examsNeedToBePassed}/${chart.data!.examsNeedToBePassed + chart.data!.examsArePassed}";
                        }
                      }.call(),
                      style: const TextStyle(
                          fontSize: 55,
                          fontWeight: FontWeight.w700,
                          fontFamily: "Rubik"),
                    ),
                    const Text("Экзаменов")
                  ],
                )
              ],
              options: CarouselOptions(
                enlargeCenterPage: true,
                autoPlay: true,
                height: 150,
                initialPage: 1,
                viewportFraction: 1,
              ),
            );
          case Status.loading:
            return const Center(
              child: CircularProgressIndicator(),
            );
          case Status.initial:
            context.read<UserViewModel>().fetchPerfomance();
            return const Center(
              child: Text("0_O"),
            );
          case Status.error:
            return const Center(
              child: Text("Ошибка"),
            );
        }
      }),
    );
  }
}

class BottomLeftInfoWidget extends StatelessWidget {
  const BottomLeftInfoWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      height: 150,
      decoration: BoxDecoration(
          color: Colors.deepOrange.shade300,
          borderRadius: const BorderRadius.all(Radius.circular(15))),
      child: Builder(builder: (context) {
        var chart = context.watch<UserViewModel>().circularChart;
        switch (chart.status) {
          case Status.initial:
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [Text("0_O")],
            );
          case Status.loading:
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                CircularProgressIndicator(
                  color: Colors.white,
                )
              ],
            );
          case Status.error:
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text(chart.message ?? "Ошибка")],
            );
          case Status.completed:
            return CarouselSlider(
              items: [
                CircularChartInfoWidget(
                  topText: "По экзаменам",
                  score: chart.data!.averageExamsScore,
                ),
                CircularChartInfoWidget(
                  topText: "По зачётам",
                  score: chart.data!.averageCreditsScore,
                )
              ],
              options: CarouselOptions(
                enlargeCenterPage: true,
                reverse: true,
                autoPlay: true,
                height: 150,
                initialPage: 1,
                viewportFraction: 1,
              ),
            );
        }
      }),
    );
  }
}

class CircularChartInfoWidget extends StatelessWidget {
  const CircularChartInfoWidget(
      {Key? key, required this.topText, required this.score})
      : super(key: key);

  final String topText;
  final int score;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: RotatedBox(
              quarterTurns: 90,
              child: SizedBox(
                  height: 80,
                  width: 80,
                  child: CircularProgressIndicator(
                    value: score / 100,
                    color: Colors.white,
                    backgroundColor: Colors.white.withAlpha(70),
                  ))),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(topText,
                    style:
                        const TextStyle(color: Colors.white70, fontSize: 12)),
                Text(score.toString(),
                    style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w400,
                        fontFamily: "Rubik",
                        color: Colors.white)),
                const Text("средний балл",
                    style: TextStyle(color: Colors.white70, fontSize: 12))
              ],
            ),
          ),
        )
      ],
    );
  }
}

class LeftColumnInfoWidget extends StatelessWidget {
  const LeftColumnInfoWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        children: const [TopLeftInfoWidget(), BottomLeftInfoWidget()]);
  }
}
