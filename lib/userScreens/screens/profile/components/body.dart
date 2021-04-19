import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:medicalpasal/userScreens/api/api.dart';
import 'package:medicalpasal/userScreens/screens/aboutUs/aboutUs.dart';
import 'package:medicalpasal/userScreens/screens/profile/components/myorders/invoice.dart';
import 'package:medicalpasal/userScreens/screens/sign_in/sign_in_screen.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'notifications/notifications_screen.dart';
import 'package:medicalpasal/userScreens/screens/profile/components/accountSettings.dart';

import 'profile_menu.dart';
import 'profileUpdate.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          ProfileUpdate(),
          SizedBox(height: 20),
          ProfileMenu(
            text: "Notifications",
            icon: "assets/icons/Bell.svg",
            press: () {
              Navigator.pushNamed(context, Notifications.routeName);
            },
          ),
          ProfileMenu(
            text: "Settings",
            icon: "assets/icons/Shop Icon.svg",
            press: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Invoice()));
            },
          ),
          ProfileMenu(
            text: "Settings",
            icon: "assets/icons/Settings.svg",
            press: () {
              Navigator.pushNamed(context, AccountSettings.routeName);
            },
          ),
          ProfileMenu(
            text: "About Us",
            icon: "assets/icons/User.svg",
            press: () {
              Navigator.pushNamed(context, AboutUs.routeName);
            },
          ),
          ProfileMenu(
            text: "Log Out",
            icon: "assets/icons/Log out.svg",
            press: () async {
              Map data = {};
              var response = await Api().postData(data, 'logout');
              var result = json.decode(response.body);
              if (result['code'] == 200) {
                SharedPreferences preferences =
                    await SharedPreferences.getInstance();
                preferences.remove('token');
                Navigator.popAndPushNamed(context, SignInScreen.routeName);
              } else {
                print(result['code']);
              }
              // print(result['code']);
            },
          ),
        ],
      ),
    );
  }
}
