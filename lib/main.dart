import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showcaseview/showcase_widget.dart';
import 'routes.dart';
import 'theme.dart';
import 'userScreens/provider/productsprovider.dart';
import 'userScreens/screens/splash/splash_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          builder: (context) => ProductData(),
        )
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  BuildContext myContext;
  @override
  void initState() {
    super.initState();
    //Remove this method to stop OneSignal Debugging
    OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
    OneSignal.shared.init("163899cb-ee03-4b7f-9f09-20d0d6106b02", iOSSettings: {
      OSiOSSettings.autoPrompt: false,
      OSiOSSettings.inAppLaunchUrl: false
    });
    OneSignal.shared
        .setInFocusDisplayType(OSNotificationDisplayType.notification);

// The promptForPushNotificationsWithUserResponse function will show the iOS push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
    OneSignal.shared
        .promptUserForPushNotificationPermission(fallbackToSettings: true);
    // oneSignal();
    //
    //
  }

  @override
  Widget build(BuildContext context) {
    return ShowCaseWidget(
      builder: Builder(
          builder: (context) => GetMaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Medical Pasal',
                theme: theme(),
                // home: SplashScreen(),
                // We use routeName so that we dont need to remember the name
                initialRoute: SplashPage.routeName,
                routes: routes,
              )),
      autoPlay: false,
      autoPlayDelay: Duration(seconds: 1),
      autoPlayLockEnable: false,
    );
  }
}
