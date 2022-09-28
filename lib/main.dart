import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:rsue_app/src/data/datasource/portfolio/portfolio_cache.dart';
import 'package:rsue_app/src/di_and_navigation.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(StorageAcademicPerfomanceAdapter());
  Hive.registerAdapter(StoragePaymentsAdapter());
  Hive.registerAdapter(StorageOfCredentialsAdapter());
  initializeDateFormatting('ru').then((_) => runApp(const RsueApplication()));
}
