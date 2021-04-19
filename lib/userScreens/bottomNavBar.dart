import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showcaseview/showcase.dart';
import 'package:showcaseview/showcase_widget.dart';
import '../constants.dart';

import 'package:medicalpasal/userScreens/screens/cart/cart_screen.dart';
import 'package:medicalpasal/userScreens/screens/health_tips/healthtips.dart';
import 'package:medicalpasal/userScreens/screens/home/home_screen.dart';
import 'package:medicalpasal/userScreens/screens/profile/profile_screen.dart';

class LandingPage extends StatefulWidget {
  static String routeName = "/landingPage";
  static const PREFERENCES_IS_FIRST_LAUNCH_STRING =
      "PREFERENCES_IS_FIRST_LAUNCH_STRING";

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  int _cIndex = 0;

  final tabs = [
    HomeScreen(),
    HealthTips(),
    CartScreen(),
    ProfileScreen(),
    // Center(
    //   child: Text("5"),
    // ),
  ];
  final _keyOne = GlobalKey();
  final _keyTwo = GlobalKey();
  final _keyThree = GlobalKey();
  final _keyFour = GlobalKey();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance
        .addPostFrameCallback((_) => _isFirstLaunch().then((result) {
              if (result)
                ShowCaseWidget.of(context).startShowCase([
                  _keyOne,
                  _keyTwo,
                  _keyThree,
                  _keyFour,
                ]);
            }));

    WidgetsBinding.instance.addPostFrameCallback((_) {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[_cIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _cIndex,
        selectedIconTheme: IconThemeData(color: kPrimaryColor, size: 25),
        type: BottomNavigationBarType.fixed,
        iconSize: 20.0,
        // selectedItemColor: Colors.deepPurple,
        // unselectedItemColor: Colors.greenAccent,
        selectedLabelStyle: TextStyle(
          fontWeight: FontWeight.bold,
        ),

        items: [
          BottomNavigationBarItem(
            icon: CustomShowcaseWidget(
              globalKey: _keyOne,
              description: 'HomePage',
              child: Icon(Icons.dashboard_outlined),
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: CustomShowcaseWidget(
              globalKey: _keyTwo,
              description: 'Tips',
              child: Icon(Icons.library_books_outlined),
            ),
            label: 'Health Tips',
          ),
          BottomNavigationBarItem(
              icon: CustomShowcaseWidget(
                globalKey: _keyFour,
                description: 'Your Cart',
                child: Icon(Icons.add_shopping_cart_rounded),
              ),
              label: 'Cart'),
          BottomNavigationBarItem(
              icon: CustomShowcaseWidget(
                globalKey: _keyThree,
                description: 'Your Settings',
                child: Icon(Icons.settings_applications_outlined),
              ),
              label: 'Settings'),
        ],
        onTap: (index) {
          setState(() {
            _cIndex = index;
          });
        },
      ),
    );
  }

  Future<bool> _isFirstLaunch() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    bool isFirstLaunch = sharedPreferences
            .getBool(LandingPage.PREFERENCES_IS_FIRST_LAUNCH_STRING) ??
        true;

    if (isFirstLaunch)
      sharedPreferences.setBool(
          LandingPage.PREFERENCES_IS_FIRST_LAUNCH_STRING, false);

    return isFirstLaunch;
  }
}
