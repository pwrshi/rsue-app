import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rsue_app/src/domain/entities/subject_entity.dart';
import 'package:rsue_app/src/presentation/providers/widget/short_info.dart';

const animationCurve = Curves.easeIn;
const animationSpeed = Duration(milliseconds: 200);
const animationCurveOut = Curves.easeOut;
const _colorOfInnerColumn = Color(0xFF0FCA7A);
const _colorOfOuterColumn = Color(0xFF334E68);

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
            duration: const Duration(milliseconds: 200),
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

  String calcString() {
    var result = "";
    if (entity.controlPoints.length == 1) {
      result += "ПР:\n${entity.controlPoints.first}";
    } else {
      var len = entity.controlPoints.length;
      for (var i = len - 1, ma = 0; i >= 0;) {
        ma = entity.controlPoints[i--];
        result += "КТ${i + 2}:\n$ma";
        if (i == 0) {
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
                height: (absoluteHeight <= 90 ? 90 : absoluteHeight).toDouble(),
                width: selected ? 55 : 23,
                alignment: Alignment.centerRight,
                curve: animationCurve,
                duration: animationSpeed,
                child: AnimatedSwitcher(
                  switchInCurve: animationCurve,
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
                switchInCurve: animationCurve,
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
                // curve: animationCurve,
                // duration: animationSpeed,
                clipBehavior: Clip.antiAlias,
                alignment: Alignment.topLeft,
                decoration: const BoxDecoration(
                    color: _colorOfOuterColumn,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Column(
                  children: [
                    for (var i = 0, mark = 990909;
                        i < entity.absoluteControlPoints.length;)
                      () {
                        bool isTop = (i + 1 == 1);
                        if (mark == 0) {
                          isTop = true;
                        }
                        mark = entity.absoluteControlPoints.reversed
                                .toList()[i++] *
                            2;
                        return ControlPointWidget(
                          isTop: isTop,
                          selected: selected,
                          mark: mark,
                          hasBottomMargin: (mark != 0) &&
                              (i != (entity.absoluteControlPoints.length - 1)),
                        );
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

class ControlPointWidget extends StatelessWidget {
  const ControlPointWidget({
    super.key,
    this.selected = false,
    this.hasBottomMargin = false,
    required this.mark,
    this.isTop = false,
  });
  final bool isTop;
  final bool selected;
  final int mark;
  final bool hasBottomMargin;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      curve: animationCurve,
      margin: hasBottomMargin
          ? const EdgeInsets.all(3)
          : mark == 0
              ? const EdgeInsets.only(left: 3, right: 3)
              : const EdgeInsets.only(top: 3, left: 3, right: 3),
      duration: animationSpeed,
      width: (selected ? 17 : 9),
      height: mark.toDouble(),
      decoration: BoxDecoration(
          color: isTop
              ? _colorOfInnerColumn
              : (selected ? _colorOfInnerColumn : _colorOfOuterColumn),
          borderRadius: const BorderRadius.all(Radius.circular(20))),
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
