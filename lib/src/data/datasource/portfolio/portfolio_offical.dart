import 'package:rsue_app/src/core/error/datasource_error.dart';
import 'package:rsue_app/src/data/repositories/portfolio_datasource.dart';
import 'package:rsue_app/src/domain/entities/subject_entity.dart';
import 'package:rsue_app/src/domain/entities/payment_entity.dart';
import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';

const academicPerformanceURL =
    'https://portfolio.rsue.ru/portfolio/index.php?section=23';
const loginURL = 'https://portfolio.rsue.ru/login/index.php';
const reportURL = 'https://portfolio.rsue.ru/portfolio/index.php?view=1';
const whoamiURL = 'https://portfolio.rsue.ru/portfolio/index.php?section=11';
const accountingURL = 'https://portfolio.rsue.ru/accounting/index.php';

class PortfolioOfficalDataSource extends PortfolioDataSource {
  late Dio http;
  PortfolioOfficalDataSource() {
    http = Dio();

    // Игнорирует всратый сертификат
    (http.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      // коллбэчит что всё ок
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };

    //Сохранение кук
    var cookieJar = CookieJar();
    http.interceptors.add(CookieManager(cookieJar));
  }

  bool? _checkAuthByDataRaw(String data) {
    if (data.contains(
        '<script type="text/javascript">document.location.replace("/login/index.php");</script>')) {
      return false;
    }
    if (data.contains(
        "document.documentElement.style.backgroundImage = \"url('/style/images/background.png')\";")) {
      return true;
    }
    return null;
  }

  Future<String> _getRawPage(String url) async {
    Response<String> resp;
    try {
      resp = await http.get<String>(url);
    } catch (e) {
      throw const DatasourceError(name: "Ошибка получения данныйх из сети");
    }

    if (resp.statusCode == 200) {
      if (resp.data == null) {
        throw const DatasourceError(name: "Код 200, а данных нет :)");
      }
      return resp.data!;
    }
    throw const DatasourceError(name: "Код != 200");
  }

  Future<String> getPage(String url, String username, String password) async {
    if (await _autorize(username, password)) {
      var raw = await _getRawPage(url);
      var check = _checkAuthByDataRaw(raw);
      switch (check) {
        case null:
          throw const DatasourceError(name: "Похоже, сайт УСПЕШНО сломался (");
        case false:
          throw const DatasourceError(name: "Похоже, авторизация сломалась :|");
        default:
          return raw;
      }
    }
    throw const DatasourceError(name: "Авторизация провалена");
  }

  Future<bool> _autorize(String username, String password) async {
    try {
      var resp = await http.post<String>(loginURL,
          data: {
            'password': password,
            'username': username,
            'loginbtn': 'Вход'
          },
          options: Options(contentType: "application/x-www-form-urlencoded"));
      if (resp.statusCode == 200) {
        var result = _checkAuthByDataRaw(resp.data!);
        if (result == null) {
          throw const DatasourceError(name: "Похоже, сайт УСПЕШНО сломался (");
        }
        return result;
      }
      throw DatasourceError(
          name: "Портфолио отвечает кодом: ${resp.statusCode}");
    } catch (e) {
      throw DatasourceError(name: "Ошибка входа: + $e");
    }
  }

  @override
  Future<bool> checkCredentials(String username, String password) {
    return _autorize(username, password);
  }

  SubjectEntity _parseSubject(Element raw) {
    try {
      String text = raw.children[0].children[0].text;

      String name, teacher;
      SessionType type;
      int statement, controlPoint1, controlPoint2;
      bool isClosed = true;

      if (text.contains(" (Экзамен)")) {
        name = text.replaceAll(" (Экзамен)", "");
        type = SessionType.exam;
      } else if (text.contains(" (Зачет)")) {
        name = text.replaceAll(" (Зачет)", "");
        type = SessionType.credit;
      } else {
        name = text.replaceAll(" (Практика)", "");
        type = SessionType.practice;
      }

      text = raw.children[0].children[2].text;

      if (text.contains("не закрыта")) {
        isClosed = false;
      }
      statement = int.parse(RegExp(r'\d+').firstMatch(text)?[0] ?? '0');

      teacher = RegExp(r'<i>Преподаватель:<\/i> ([^\n]+)')
              .firstMatch(raw.children[0].innerHtml)?[1] ??
          '';

      controlPoint1 = int.parse(
          RegExp(r'КТ1 = (\d+)').firstMatch(raw.children[0].innerHtml)?[1] ??
              '0');
      controlPoint2 = int.parse(
          RegExp(r'КТ2 = (\d+)').firstMatch(raw.children[0].innerHtml)?[1] ??
              '0');

      //
      return SubjectEntity(
          name: name,
          teachersname: teacher,
          type: type,
          isClosed: isClosed,
          statement: statement,
          controlPoints: [controlPoint1, controlPoint2]);
    } catch (e) {
      throw const DatasourceError(name: "Ошибка парсинга успеваемости");
    }
  }

  Map<String, List<SubjectEntity>> _academicPerformanceParser(String raw) {
    List<Element>? tbody = parse(raw).getElementsByTagName('tbody')[0].children;
    tbody.removeAt(0);
    Map<String, List<SubjectEntity>> result = {};
    String? key;
    List<SubjectEntity> value = [];
    for (var element in tbody) {
      if (element.children[0].className == "cell-style-1") {
        if (key != null) {
          result[key] = value;
        }
        key = element.text;
        value = [];
      } else {
        value.add(_parseSubject(element));
      }
    }
    if ((key != null) && !result.containsKey(key)) {
      result[key] = value;
    }
    return result;
  }

  @override
  Future<Map<String, List<SubjectEntity>>> getAcademicPerfomance(
      String username, String password) async {
    var raw = await getPage(academicPerformanceURL, username, password);
    return _academicPerformanceParser(raw);
  }

  DateTime _parseDate(String str) {
    var res = RegExp(r'\d+').allMatches(str).toList();
    return DateTime(
      int.parse(res[2][0]!),
      int.parse(res[1][0]!),
      int.parse(res[0][0]!),
    );
  }

  List<PaymentEntity>? _accountingParser(String raw) {
    List<Element> body =
        parse(raw).getElementById('body')!.children[1].children;

    Map? result = {};

    String? nameOfColumn;
    List<PaymentEntity> column = [];
    for (var element in body) {
      if (element.localName == "h4") {
        if (nameOfColumn == null) {
          nameOfColumn = element.text;
        } else {
          result[nameOfColumn] = column;
          nameOfColumn = element.text;
          column = [];
        }
      } else if (element.localName == "a") {
        String? link = element.attributes['href'];
        if (link != null) {
          link = "https://portfolio.rsue.ru$link";
        }
        var dates =
            RegExp(r'([1234567890.]+)').allMatches(element.text).toList();
        column.add(PaymentEntity(
            name: nameOfColumn!,
            url: link!,
            dateOfReceiptFormation: _parseDate(dates[2][1]!),
            dateOfServiceEnding: _parseDate(dates[1][1]!),
            dateOfServiceStarting: _parseDate(dates[0][1]!)));
      }
    }
    // {
    //       "start": dates[0][1],
    //       "end": dates[1][1],
    //       "created": dates[2][1],
    //       "link": link
    //     }
    result[nameOfColumn] = column;
    List<PaymentEntity> onelist = [];
    for (var element in result.values) {
      onelist.addAll(element);
    }
    return onelist;
  }

  @override
  Future<List<PaymentEntity>> getPayments(
      String username, String password) async {
    var raw = await getPage(accountingURL, username, password);
    return _accountingParser(raw)!;
  }

  /// Парсит основную информацию о пользователе
  Map<String, String> _whoamiParser(String raw) {
    try {
      Map<String, String> result = {};

      var document = parse(raw);

      List<String> keys = document
          .getElementsByClassName("grid-cell-left")
          .map((e) => e.text)
          .toList();

      List<String> values = document
          .getElementsByClassName("grid-cell")
          .map((e) => e.text)
          .toList();

      if (keys.length != values.length) {
        throw Exception("Количество ключей и значений не совпадает");
      } else {
        for (var i = 0; i < keys.length; i++) {
          result[keys[i]] = values[i];
        }
        return result;
      }
    } catch (e) {
      throw const DatasourceError(name: "Ошибка парсинга whoami");
    }
  }

  @override
  Future<Map<String, String>> whoami(String username, String password) async {
    String page = await getPage(whoamiURL, username, password);
    return _whoamiParser(page);
  }
}
