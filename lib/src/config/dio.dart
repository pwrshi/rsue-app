import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';

Dio getDio() {
  var dio = Dio();
  // Игнорирует всратый сертификат
  (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
      (HttpClient client) {
    // коллбэчит что всё ок
    client.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    return client;
  };
  return dio;
}
