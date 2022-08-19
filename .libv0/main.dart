import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:get/get.dart';
import 'app/routes/app_pages.dart';

part 'app/themes/light/light.dart';
part 'app/themes/dark/dark.dart';

void main() {
  initializeDateFormatting().then((_) => runApp(
        GetMaterialApp(
          theme: darkTheme,
          locale: const Locale('ru'),
          title: "Application",
          initialRoute: AppPages.initital,
          getPages: AppPages.routes,
        ),
      ));
}
