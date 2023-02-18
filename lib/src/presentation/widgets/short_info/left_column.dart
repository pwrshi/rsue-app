import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rsue_app/src/presentation/providers/widget/short_info.dart';

class TopLeftInfoWidget extends StatelessWidget {
  const TopLeftInfoWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 110,
        height: 140,
        decoration: const BoxDecoration(
            color: Color(0xFF486581),
            borderRadius: BorderRadius.all(Radius.circular(15))),
        child: Builder(
          builder: (context) {
            var l = context.watch<ShortInfoProvider>();

            return CarouselSlider(
              items: [
                for (var el in l.numberWidgetData) NumberWidget(data: el)
              ],
              options: CarouselOptions(
                autoPlayInterval: const Duration(milliseconds: 10000),
                enlargeCenterPage: true,
                autoPlay: true,
                height: 150,
                initialPage: 1,
                viewportFraction: 1,
              ),
            );
          },
        ));
  }
}

class NumberWidget extends StatelessWidget {
  const NumberWidget({super.key, required this.data});
  final NumberForm data;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          data.topText,
          style: const TextStyle(color: Colors.white70),
        ),
        Text(
          data.centerText,
          style: const TextStyle(
              fontSize: 30, fontWeight: FontWeight.w700, fontFamily: "Rubik"),
        ),
        Text(data.bottomText, style: const TextStyle(color: Colors.white70))
      ],
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
        height: 160,
        decoration: const BoxDecoration(
            color: Color(0xFF486581),
            borderRadius: BorderRadius.all(Radius.circular(15))),
        child: Builder(
          builder: (context) {
            var list = context.watch<ShortInfoProvider>().circularWidgetData;
            return CarouselSlider(
              items: [for (var e in list) CircularChartInfoWidget(data: e)],
              options: CarouselOptions(
                enlargeCenterPage: true,
                reverse: true,
                autoPlayInterval: const Duration(milliseconds: 10000),
                autoPlay: true,
                height: 150,
                initialPage: 1,
                viewportFraction: 1,
              ),
            );
          },
        ));
  }
}

class CircularChartInfoWidget extends StatelessWidget {
  const CircularChartInfoWidget({Key? key, required this.data})
      : super(key: key);

  final CircularForm data;
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
                    value: data.score / 100,
                    color: Colors.white,
                    backgroundColor: Colors.white.withAlpha(70),
                  ))),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(data.topText,
                    style:
                        const TextStyle(color: Colors.white70, fontSize: 14)),
                Text(data.score.toString(),
                    style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w400,
                        fontFamily: "Rubik",
                        color: Colors.white)),
                Text(data.bottomText,
                    style: const TextStyle(color: Colors.white70, fontSize: 14))
              ],
            ),
          ),
        )
      ],
    );
  }
}
