import 'package:flutter/material.dart';
import 'package:medicalpasal/userScreens/components/coustom_bottom_nav_bar.dart';

import '../../../enums.dart';
import 'components/body.dart';


class HealthTips extends StatefulWidget {
  static String routeName = "/healthtips";

  @override
  _HealthTipsState createState() => _HealthTipsState();
}

class _HealthTipsState extends State<HealthTips> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Health Tips"),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: Body(),
        ),
        bottomNavigationBar:
            CustomBottomNavBar(selectedMenu: MenuState.healthtips),
      ),
    );
  }
}
