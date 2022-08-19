import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:rsue_schedule_api/get_schedule.dart';
import '../models/apis/response.dart';
import '../../lib_de/models/services/portfolio/portfolio.dart';
import 'package:rsue_schedule_api/schedule_type.dart';

class Group {
  Group(this.facult, this.course, this.group);
  int group, facult, course;
}

class AcademicPerfomanceChart {
  AcademicPerfomanceChart(this.creditsNeedToBePassed, this.creditsArePassed,
      this.examsArePassed, this.examsNeedToBePassed);
  int examsNeedToBePassed,
      examsArePassed,
      creditsNeedToBePassed,
      creditsArePassed;
}

class PerfomanceChartSubject {
  PerfomanceChartSubject(String subjectName, this.cp1, this.cp2) {
    RegExp rx = RegExp(" ([А-Яа-я0-9])");
    abbr = "";
    rx.allMatches(" $subjectName").forEach((element) {
      abbr += element[1]!;
    });
    if (abbr.length > 2) {
      abbr = abbr.substring(0, 2);
    }
    abbr = subjectName;
  }
  late String abbr;
  int cp1, cp2;
}

class CircularChart {
  CircularChart(this.averageCreditsScore, this.averageExamsScore);
  int averageExamsScore, averageCreditsScore;
}

class UserViewModel with ChangeNotifier {
  // Schedule services
  Group? group;
  ApiResponse<Schedule> schedule = ApiResponse<Schedule>.initial("empty");

  void setGroup(f, c, g) {
    group = Group(f, c, g);
    notifyListeners();
    fetchSchedule();
  }

  Future<void> fetchSchedule() async {
    int facult = 1, course = 1, group = 1;
    schedule = ApiResponse<Schedule>.loading("Загрузка расписания");
    Schedule? sch;
    try {
      sch = await getSchedule(facult, course, group);
      //test
      var n = sch!.onDay(DateTime.now());
    } catch (e) {
      schedule =
          ApiResponse<Schedule>.error(": не удалось загрузить расписание");
      notifyListeners();
      fetchScheduleFromBackup();
      return;
    }
    schedule = ApiResponse<Schedule>.completed(sch);
    notifyListeners();
  }

  Future<void> fetchScheduleFromBackup() async {
    schedule = ApiResponse<Schedule>.loading("Загрузка расписания с бэкапа");
    Schedule? sch;
    try {
      var data = await Dio().get(
          "http://6272a1d9d94690211eb0dbe5--brilliant-pegasus-e3bfbe.netlify.app/%D0%9F%D0%A0%D0%98-312.json");
      sch = Schedule.fromJson(data.data);
      //test
      var n = sch.onDay(DateTime.now());
    } catch (e) {
      schedule = ApiResponse<Schedule>.error(": нет бэкапа");
      notifyListeners();
      return;
    }
    schedule = ApiResponse<Schedule>.completed(sch);
    notifyListeners();
  }

  // Portfolio services
  bool hasAuthorized = false;
  String? login;
  String? password;
  ApiResponse<Perfomance> perfomance = ApiResponse.initial("");
  ApiResponse<Bills> bills = ApiResponse.initial("");
  ApiResponse<StudentInfo> studentInfo = ApiResponse.initial("");
  ApiResponse<CircularChart> circularChart = ApiResponse.initial("");
  ApiResponse<List<PerfomanceChartSubject>> perfomanceChartSubjects =
      ApiResponse.initial("");
  ApiResponse<AcademicPerfomanceChart> academicPerfomanceChart =
      ApiResponse.initial("");

  Future<bool> authorize(login, password) async {
    StudentInfo? a = await getStudentInfo(username: login, password: password);

    if (a != null) {
      this.login = login;
      this.password = password;
      hasAuthorized = true;
      notifyListeners();
      studentInfo = ApiResponse.completed(a);
      return true;
    }
    notifyListeners();
    return false;
  }

  Future<void> fetchBills() async {
    if ((login == null) || (password == null)) {
      return;
    }
    bills = ApiResponse.loading("loading");
    Bills? res = (await getBills(
        username: login as String, password: password as String));
    if (res == null) {
      bills = ApiResponse.error("error of loading");
    }
    bills = ApiResponse.completed(res);
    notifyListeners();
  }

  Future<void> fetchStudentInfo() async {
    if ((login == null) || (password == null)) {
      return;
    }
    perfomance = ApiResponse.loading("loading");

    Map<String, String>? res = (await getStudentInfo(
        username: login as String, password: password as String));
    if (res == null) {
      studentInfo = ApiResponse.error("error of loading");
    }
    studentInfo = ApiResponse.completed(res);
    notifyListeners();
  }

  Future<void> fetchPerfomance() async {
    if ((login == null) || (password == null)) {
      return;
    }
    perfomanceChartSubjects = ApiResponse.loading("loading");
    perfomance = ApiResponse.loading("loading");
    academicPerfomanceChart = ApiResponse.loading("loading");
    circularChart = ApiResponse.loading("loading");
    Perfomance? res = await getAcademicPerformance(
        username: login as String, password: password as String);

    if (res == null) {
      perfomance = ApiResponse.error("error of loading");
    }

    int examsNeedToBePassed = 0,
        examsArePassed = 0,
        creditsNeedToBePassed = 0,
        creditsArePassed = 0;
    double averageExamsScored = 0, averageCreditsScored = 0;

    for (var subject in res!.entries.first.value) {
      if (subject.type == "Зачет") {
        averageCreditsScored +=
            (subject.controlPoint1 + subject.controlPoint2) / 2;

        if (subject.isClosed) {
          creditsArePassed++;
        } else {
          creditsNeedToBePassed++;
        }
      } else if (subject.type == "Экзамен") {
        averageExamsScored +=
            (subject.controlPoint1 + subject.controlPoint2) / 2;

        if (subject.isClosed) {
          examsArePassed++;
        } else {
          examsNeedToBePassed++;
        }
      }
    }
    circularChart = ApiResponse.completed(CircularChart(
        (averageCreditsScored / (creditsNeedToBePassed + creditsArePassed))
            .round(),
        (averageExamsScored / (examsNeedToBePassed + examsArePassed)).round()));
    academicPerfomanceChart = ApiResponse.completed(AcademicPerfomanceChart(
        creditsNeedToBePassed,
        creditsArePassed,
        examsArePassed,
        examsNeedToBePassed));

    perfomance =
        ApiResponse<Map<String, List<SubjectPerfomance>>>.completed(res);

    List<SubjectPerfomance> sp = res.values.first;
    sp.sort((a, b) => (a.controlPoint1 + a.controlPoint2)
        .compareTo((b.controlPoint1 + b.controlPoint2)));
    sp.removeRange(4, sp.length - 1);
    List<PerfomanceChartSubject> lsp = [];
    for (var element in sp) {
      lsp.add(PerfomanceChartSubject(
          element.name, element.controlPoint1, element.controlPoint2));
    }

    perfomanceChartSubjects = ApiResponse.completed(lsp);
    notifyListeners();
  }
}
