import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:rsue_app/src/di_and_navigation.dart';

void main() {
  initializeDateFormatting('ru').then((_) => runApp(const RsueApplication()));
}
