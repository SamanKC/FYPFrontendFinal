import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:medicalpasal/constants.dart';
import 'package:medicalpasal/userScreens/models/searchModel.dart';
import 'package:showcaseview/showcase.dart';
import 'package:showcaseview/showcase_widget.dart';

import '../home_screen.dart';
import 'icon_btn_with_counter.dart';

Widget appBarWidget(context) {
  return AppBar(
    elevation: 0.0,
    centerTitle: true,
    backgroundColor: Colors.white,
    title: Text(
      'Medical Pasal',
      style: TextStyle(color: kPrimaryColor),
    ),
    actions: <Widget>[
      IconBtnWithCounter(
        icon: Icons.search,
        press: () {
          showSearch(context: context, delegate: DataSearch());
        },
      ),
    ],
  );
}
