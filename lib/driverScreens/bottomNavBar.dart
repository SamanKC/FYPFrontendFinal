import 'package:flutter/material.dart';
import '../constants.dart';

import 'package:medicalpasal/driverScreens/screens/orders/orders.dart';
import 'package:medicalpasal/driverScreens/screens/profile/profile.dart';

class DriverLandingPage extends StatefulWidget {
  static String routeName = "/landingPage";

  @override
  _DriverLandingPageState createState() => _DriverLandingPageState();
}

class _DriverLandingPageState extends State<DriverLandingPage> {
  int _cIndex = 0;

  final tabs = [
    Orders(),
    DriverProfile(),

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
            label: "Orders",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
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
