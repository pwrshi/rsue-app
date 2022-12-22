import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:rsue_app/src/di_and_navigation.dart';

void main() async {
  // await initHive();
  // OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

  // OneSignal.shared.setAppId("YOUR_ONESIGNAL_APP_ID");

// The promptForPushNotificationsWithUserResponse function will show the iOS or Android push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
  // OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
  //   print("Accepted permission: $accepted");
  // });
  initializeDateFormatting('ru').then((_) => runApp(const RsueApplication()));
}
