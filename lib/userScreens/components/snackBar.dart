import 'package:flutter/material.dart';
import 'package:medicalpasal/constants.dart';

void showInSnackBar(context, String value) {
  Scaffold.of(context).showSnackBar(SnackBar(
    backgroundColor: kPrimaryColor,
    duration: Duration(seconds: 1),
    content: new Text(value),
  ));
}
