import 'package:flutter/material.dart';
import 'package:rsue_app/src/core/api/response.dart';
import 'package:rsue_app/src/core/error/error.dart';
import 'package:rsue_app/src/domain/entities/subject_entity.dart';
import 'package:rsue_app/src/presentation/providers/data/portfolio_snapshot.dart';

class NumberForm {
  const NumberForm(this.topText, this.centerText, this.bottomText);
  final String topText, centerText, bottomText;
}

class CircularForm {
  const CircularForm(this.topText, this.score, this.bottomText);
  final String topText, bottomText;
  final int score;
}

class ShortInfoProvider extends ChangeNotifier {
  ShortInfoProvider(this.snapshot) {
    state = snapshot?.data.status ?? ResponseStatus.init;
  }
  var state = ResponseStatus.init;
  AcademicPerfomanceSnapshot? snapshot;
  bool _checkData() {
    if ((snapshot!.data.status == ResponseStatus.done) ||
        (snapshot!.data.status == ResponseStatus.restored)) {
      return true;
    }
    notifyListeners();

    return false;
  }

  NumberForm get _countCreditsNeedToPass {
    if (_checkData()) {
      var lastSemester = snapshot!.data.content?.entries.first.value;
      var passed = lastSemester!
          .where((element) =>
              (element.type == SessionType.credit) & element.isClosed)
          .length;
      var needToPass = lastSemester
          .where((element) =>
              (element.type == SessionType.credit) & !element.isClosed)
          .length;
      if (passed == 0) {
        return NumberForm("Нужно сдать", "$needToPass", "зачета");
      } else if (needToPass == 0) {
        return NumberForm("Сдано", "$passed", "зачета");
      } else {
        return NumberForm(
            "Нужно сдать", "$needToPass/${passed + needToPass}", "зачета");
      }
    }
    throw const RsError(name: "Нет данных, а ты их просишь");
  }

  NumberForm get _countExamsNeedToPass {
    if (_checkData()) {
      var lastSemester = snapshot!.data.content?.entries.first.value;
      var passed = lastSemester!
          .where((element) =>
              (element.type == SessionType.exam) & element.isClosed)
          .length;
      var needToPass = lastSemester
          .where((element) =>
              (element.type == SessionType.exam) & !element.isClosed)
          .length;
      if (passed == 0) {
        return NumberForm("Нужно сдать", "$needToPass", "экзамена");
      } else if (needToPass == 0) {
        return NumberForm("Сдано", "$passed", "экзамена");
      } else {
        return NumberForm(
            "Нужно сдать", "$needToPass/${passed + needToPass}", "экзамена");
      }
    }
    throw const RsError(name: "Нет данных, а ты их просишь");
  }

  List<NumberForm> get numberWidgetData {
    return [_countCreditsNeedToPass, _countExamsNeedToPass];
  }

  CircularForm get _averageExamsScore {
    if (_checkData()) {
      var lastSemester = snapshot!.data.content?.entries.first.value;
      int count = 0;
      int summary = lastSemester!.fold<int>(0, (p, element) {
        if (element.type == SessionType.exam) {
          count++;
          p += element.finalMark;
        }
        return p;
      });
       int average = (count > 0 ? summary ~/
              count: 0);

      return CircularForm("По экзаменам", average, "средний балл");
    }
    throw const RsError(name: "Нет данных, а ты их просишь");
  }

  CircularForm get _averageCreditsScore {
    if (_checkData()) {
      var lastSemester = snapshot!.data.content?.entries.first.value;
      int count = 0;
      int summary = lastSemester!.fold<int>(0, (p, element) {
                if (element.type == SessionType.credit) {
                  count++;
                  p += element.finalMark;
                }
                return p;
              });
      int average = (count > 0 ? summary ~/
              count: 0); 

      return CircularForm(
          "По зачётам",
           average,
          "средний балл");
    }
    throw const RsError(name: "Нет данных, а ты их просишь");
  }

  List<CircularForm> get circularWidgetData {
    return [_averageCreditsScore, _averageExamsScore];
  }

  List<SubjectEntity> get listOf5MostLowRatedSubject {
    if (_checkData()) {
      var lastSemester = snapshot!.data.content!.entries.first.value;
      lastSemester.sort((a, b) => a.finalMark.compareTo(b.finalMark));

      return (lastSemester.length > 5? lastSemester.sublist(0, 5): lastSemester);
    }
    throw const RsError(name: "Нет данных, а ты их просишь");
  }
}
