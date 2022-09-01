import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class TopLeftInfoWidget extends StatelessWidget {
  const TopLeftInfoWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 110,
        height: 150,
        decoration: const BoxDecoration(
            color: Color(0xFF486581),
            borderRadius: BorderRadius.all(Radius.circular(15))),
        child: CarouselSlider(
          items: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                Text(("Нужно сдать")),
                Text(
                  "3/4",
                  style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.w700,
                      fontFamily: "Rubik"),
                ),
                Text("Зачетов")
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                Text("Нужно сдать"),
                Text(
                  "12/13",
                  style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.w700,
                      fontFamily: "Rubik"),
                ),
                Text("Экзаменов")
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
        ));
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
        decoration: const BoxDecoration(
            color: Color(0xFF486581),
            borderRadius: BorderRadius.all(Radius.circular(15))),
        child: CarouselSlider(
          items: const [
            CircularChartInfoWidget(
              topText: "По экзаменам",
              score: 76,
            ),
            CircularChartInfoWidget(
              topText: "По зачётам",
              score: 98,
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
        ));
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
