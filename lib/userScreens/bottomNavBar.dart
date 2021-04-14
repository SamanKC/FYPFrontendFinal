import 'package:flutter/material.dart';
import '../constants.dart';

import 'package:medicalpasal/userScreens/screens/cart/cart_screen.dart';
import 'package:medicalpasal/userScreens/screens/health_tips/healthtips.dart';
import 'package:medicalpasal/userScreens/screens/home/home_screen.dart';
import 'package:medicalpasal/userScreens/screens/profile/profile_screen.dart';

class LandingPage extends StatefulWidget {
  static String routeName = "/landingPage";

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

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
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
            icon: Icon(Icons.dashboard_outlined),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_books_outlined),
            label: 'Health Tips',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_shopping_cart_rounded), label: 'Cart'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings_applications_outlined),
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
}
