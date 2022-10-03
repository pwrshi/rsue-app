import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rsue_app/src/domain/entities/subject_entity.dart';
import 'package:rsue_app/src/presentation/providers/widget/short_info.dart';

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
        Expanded(
          child: Builder(
            builder: (context) {
              var list =
                  context.watch<ShortInfoProvider>().listOf5MostLowRatedSubject;
              return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    for (var el in list)
                      RadioPerfomanceButton(
                        selected: selectedItem == el.hashCode,
                        onTap: () {
                          setState(() {
                            if (selectedItem == el.hashCode) {
                              nameOfSelectedItem = null;
                              selectedItem = null;
                            } else {
                              nameOfSelectedItem = el.name;
                              selectedItem = el.hashCode;
                            }
                          });
                        },
                        entity: el,
                      ),
                  ]);
            },
          ),
        ),
      ],
    );
  }
}

class RadioPerfomanceButton extends StatelessWidget {
  const RadioPerfomanceButton(
      {Key? key, required this.entity, this.onTap, this.selected = false})
      : super(key: key);

  final SubjectEntity entity;
  final bool selected;
  final void Function()? onTap;
  static const animationSpeed = Duration(milliseconds: 200);

  static const animationCurveIn = Curves.easeIn;
  static const animationCurveOut = Curves.easeOut;
  final _colorOfInnerColumn = const Color(0xFF0FCA7A);
  final _colorOfOuterColumn = const Color(0xFF334E68);
  String calcString() {
    var result = "";
    if (entity.controlPoints.length == 1) {
      result += "ЭКЗ:\n${entity.controlPoints.first}";
    } else {
      for (var i = 0, ma = 0; i < entity.controlPoints.length;) {
        ma = entity.controlPoints[i++];
        result += "КТ$i:\n$ma";
        if (i == (entity.controlPoints.length - 1)) {
          result += "\n\n";
        }
      }
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    var absoluteHeight = entity.controlPoints.fold<int>(
            0, (previousValue, element) => previousValue + element) ~/
        entity.controlPoints.length *
        2;
    return InkWell(
      splashColor: Colors.white,
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            AnimatedContainer(
                height: (absoluteHeight <= 70 ? 70 : absoluteHeight).toDouble(),
                width: selected ? 55 : 23,
                alignment: Alignment.centerRight,
                curve: animationCurveIn,
                duration: animationSpeed,
                child: AnimatedSwitcher(
                  switchInCurve: animationCurveIn,
                  switchOutCurve: animationCurveOut,
                  duration: animationSpeed,
                  child: Text(calcString(),
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
                          entity.finalMark.toString(),
                          style: const TextStyle(
                              color: Colors.white, fontSize: 12),
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
                    for (var i = 0, mark = 0;
                        i < entity.absoluteControlPoints.length;)
                      () {
                        mark = entity.absoluteControlPoints[i++] * 2;
                        return (i == 1
                            ? AnimatedContainer(
                                curve: animationCurveIn,
                                margin: entity.absoluteControlPoints.length == 1
                                    ? const EdgeInsets.all(3)
                                    : const EdgeInsets.only(
                                        top: 3, left: 3, right: 3),
                                duration: animationSpeed,
                                width: (selected ? 17 : 9),
                                height: mark.toDouble(),
                                decoration: BoxDecoration(
                                    color: _colorOfInnerColumn,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(20))),
                              )
                            : AnimatedContainer(
                                curve: animationCurveIn,
                                margin: const EdgeInsets.all(3),
                                duration: animationSpeed,
                                width: (selected ? 17 : 9),
                                height: mark.toDouble(),
                                decoration: BoxDecoration(
                                    color: selected
                                        ? _colorOfInnerColumn
                                        : _colorOfOuterColumn,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(20))),
                              ));
                      }.call(),
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
        width: 230,
        height: 310,
        decoration: const BoxDecoration(
            color: Color(0xFF486581),
            borderRadius: BorderRadius.all(Radius.circular(15))),
        child: const ChartWhatNeedsToBeImproved()
        // ChartComplete(chart.data!.asMap());
        );
  }
}
