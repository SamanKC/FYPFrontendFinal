import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:medicalpasal/driverScreens/bottomNavBar.dart';
import 'package:medicalpasal/userScreens/api/api.dart';
import 'package:medicalpasal/userScreens/screens/home/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:medicalpasal/userScreens/bottomNavBar.dart';

import '../../../constants.dart';
import '../../../selectionPage.dart';

class SplashPage extends StatefulWidget {
  static String routeName = "/splash";

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    getuserDetails();
    checkToken();
  }

  int user_type;
  Future getuserDetails() async {
    var response = await Api().getData('user');
    var data = json.decode(response.body);
    user_type = data['user_type'];
    setState(() {});
    return data;
  }

  void checkToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String token = preferences.getString('token');
    print(token);

    // preferences.remove('token');
    // print(token);
    if (token == null) {
      Future.delayed(Duration(seconds: 5), () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => SelectionPage()));
      });
    } else {
      Future.delayed(Duration(seconds: 5), () async {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.getString('token');
        // getuserDetails();
        print(user_type.toString());
        if (user_type == 1) {
          Navigator.popAndPushNamed(context, LandingPage.routeName);
        } else if (user_type == 2) {
          Navigator.popAndPushNamed(context, DriverLandingPage.routeName);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Container(
        child: kAppLogo,
        // height: 250,
        height: MediaQuery.of(context).size.height / 6,
        // height: getProportionateScreenWidth(250),
        // width: getProportionateScreenHeight(20),
        // width: 300,
        width: MediaQuery.of(context).size.height / 4,
      ),
      // Text('Medical Pasal'),
    ));
  }
}
