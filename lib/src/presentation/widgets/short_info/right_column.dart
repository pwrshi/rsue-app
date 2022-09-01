import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChartWhatNeedsToBeImproved extends StatefulWidget {
  const ChartWhatNeedsToBeImproved({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => ChartWhatNeedsToBeImprovedState();
}

class ChartWhatNeedsToBeImprovedState
    extends State<ChartWhatNeedsToBeImproved> {
  int? selectedItem;
  String? nameOfSelectedItem;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedSwitcher(
            duration: const Duration(milliseconds: 80),
            child: SizedBox(
              key: ValueKey(nameOfSelectedItem),
              height: 30,
              child: AutoSizeText(nameOfSelectedItem ?? "Можно подтянуть",
                  maxLines: 2,
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontFamily: "Rubik",
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  )),
            )),
        SizedBox(
            height: 242,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  RadioPerfomanceButton(
                      label: "some",
                      firstPoint: 100,
                      secondPoint: 100,
                      selected: selectedItem == 1,
                      onTap: () {
                        setState(() {
                          if (selectedItem == 1) {
                            nameOfSelectedItem = null;
                            selectedItem = null;
                          } else {
                            nameOfSelectedItem = "some";
                            selectedItem = 1;
                          }
                        });
                      }),
                  RadioPerfomanceButton(
                      label: "some",
                      firstPoint: 100,
                      secondPoint: 100,
                      selected: selectedItem == 2,
                      onTap: () {
                        setState(() {
                          if (selectedItem == 2) {
                            nameOfSelectedItem = null;
                            selectedItem = null;
                          } else {
                            nameOfSelectedItem = "some";
                            selectedItem = 2;
                          }
                        });
                      }),
                  RadioPerfomanceButton(
                      label: "some",
                      firstPoint: 100,
                      secondPoint: 100,
                      selected: selectedItem == 3,
                      onTap: () {
                        setState(() {
                          if (selectedItem == 3) {
                            nameOfSelectedItem = null;
                            selectedItem = null;
                          } else {
                            nameOfSelectedItem = "some";
                            selectedItem = 3;
                          }
                        });
                      }),
                  RadioPerfomanceButton(
                      label: "some",
                      firstPoint: 100,
                      secondPoint: 100,
                      selected: selectedItem == 4,
                      onTap: () {
                        setState(() {
                          if (selectedItem == 4) {
                            nameOfSelectedItem = null;
                            selectedItem = null;
                          } else {
                            nameOfSelectedItem = "some";
                            selectedItem = 4;
                          }
                        });
                      }),
                  RadioPerfomanceButton(
                      label: "some",
                      firstPoint: 100,
                      secondPoint: 100,
                      selected: selectedItem == 5,
                      onTap: () {
                        setState(() {
                          if (selectedItem == 5) {
                            nameOfSelectedItem = null;
                            selectedItem = null;
                          } else {
                            nameOfSelectedItem = "some";
                            selectedItem = 5;
                          }
                        });
                      })
                ])),
      ],
    );
  }
}

class RadioPerfomanceButton extends StatelessWidget {
  RadioPerfomanceButton(
      {Key? key,
      required this.label,
      required this.firstPoint,
      required this.secondPoint,
      this.onTap,
      this.selected = false})
      : super(key: key);

  final int firstPoint, secondPoint;
  final bool selected;
  final void Function()? onTap;
  final String label;
  static const animationSpeed = Duration(milliseconds: 200);

  static const animationCurveIn = Curves.easeIn;
  static const animationCurveOut = Curves.easeOut;
  final _colorOfInnerColumn = Color(0xFF0FCA7A);
  final _colorOfOuterColumn = Color(0xFF334E68);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.white,
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            AnimatedContainer(
                height: ((firstPoint + secondPoint < 70)
                        ? 70
                        : firstPoint + secondPoint)
                    .toDouble(),
                width: selected ? 58 : 18,
                alignment: Alignment.centerRight,
                curve: animationCurveIn,
                duration: animationSpeed,
                child: AnimatedSwitcher(
                  switchInCurve: animationCurveIn,
                  switchOutCurve: animationCurveOut,
                  duration: animationSpeed,
                  child: Text("КТ2:\n$secondPoint\n\nКТ1:\n$firstPoint",
                      key: ValueKey(selected),
                      style: TextStyle(
                          color: selected ? Colors.white : Colors.transparent,
                          fontSize: 12)),
                )),
            Column(mainAxisAlignment: MainAxisAlignment.end, children: [
              AnimatedSwitcher(
                switchInCurve: animationCurveIn,
                switchOutCurve: animationCurveOut,
                duration: animationSpeed,
                child: Padding(
                  key: ValueKey(selected),
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: (selected
                      ? const Icon(
                          Icons.arrow_downward,
                          size: 17,
                          color: Colors.white,
                        )
                      : Text(
                          ((firstPoint + secondPoint) / 2).round().toString(),
                          style: const TextStyle(color: Colors.white),
                        )),
                ),
              ),
              Container(
                // curve: animationCurveIn,
                // duration: animationSpeed,
                clipBehavior: Clip.antiAlias,
                alignment: Alignment.topLeft,
                decoration: BoxDecoration(
                    color: _colorOfOuterColumn,
                    borderRadius: const BorderRadius.all(Radius.circular(20))),
                child: Column(
                  children: [
                    AnimatedContainer(
                      curve: animationCurveIn,
                      margin: const EdgeInsets.only(top: 3, left: 3, right: 3),
                      duration: animationSpeed,
                      width: (selected ? 17 : 9),
                      height: (selected ? secondPoint : secondPoint).toDouble(),
                      decoration: BoxDecoration(
                          color: _colorOfInnerColumn,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20))),
                    ),
                    AnimatedContainer(
                      curve: animationCurveIn,
                      margin: const EdgeInsets.all(3),
                      duration: animationSpeed,
                      width: (selected ? 17 : 9),
                      height: (selected ? firstPoint : firstPoint).toDouble(),
                      decoration: BoxDecoration(
                          color: selected
                              ? _colorOfInnerColumn
                              : _colorOfOuterColumn,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20))),
                    ),
                  ],
                ),
              ),
            ])
          ],
        ),
      ),
    );
  }
}

class RightColumnInfoWidget extends StatelessWidget {
  const RightColumnInfoWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(15.0),
        width: 220,
        height: 310,
        decoration: const BoxDecoration(
            color: Color(0xFF486581),
            borderRadius: BorderRadius.all(Radius.circular(15))),
        child: const ChartWhatNeedsToBeImproved()
        // ChartComplete(chart.data!.asMap());
        );
  }
}
