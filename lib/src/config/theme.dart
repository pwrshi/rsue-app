import 'package:flutter/material.dart';

const backgroundColor = Color(0xFF243b53);
const surfaceColor = Color(0xFF486581);
var mainTheme = ThemeData(
    fontFamily: "Rubik",
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: backgroundColor,
    colorScheme: const ColorScheme.dark(
            primary: Color(0xFFBCCCDC), primaryContainer: Color(0xFF486581))
        .copyWith(background: backgroundColor));
