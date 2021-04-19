import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:medicalpasal/userScreens/components/coustom_bottom_nav_bar.dart';
import 'package:showcaseview/showcase.dart';
import 'package:showcaseview/showcase_widget.dart';
import 'dart:async';
import 'dart:io';
import '../../../enums.dart';
import 'components/DrawerWidget.dart';
import 'components/appBar.dart';
import 'components/body.dart';
import 'package:medicalpasal/userScreens/components/snackBar.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = "/home";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<bool> _onWillPop() {
    return showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Are you sure?'),
            content: Text('Do you want to exit the App?'),
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('No'),
              ),
              FlatButton(
                onPressed: () => exit(0),
                /*Navigator.of(context).pop(true)*/
                child: Text('Yes'),
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        drawer: DrawerWidget(),
        appBar: appBarWidget(context),
        body: Body(),

        // bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.home),
      ),
    );
  }
}

class CustomShowcaseWidget extends StatelessWidget {
  final Widget child;
  final String description;
  final GlobalKey globalKey;

  const CustomShowcaseWidget({
    @required this.description,
    @required this.child,
    @required this.globalKey,
  });

  @override
  Widget build(BuildContext context) => Showcase(
        key: globalKey,
        showcaseBackgroundColor: Colors.green.shade500,
        // contentPadding: EdgeInsets.all(12),
        disableAnimation: true,
        showArrow: false,

        // title: 'Hello',
        // titleTextStyle: TextStyle(color: Colors.white, fontSize: 32),
        description: description,
        descTextStyle: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),

        // overlayColor: Colors.white,
        // overlayOpacity: 0.7,
        child: child,
      );
}
