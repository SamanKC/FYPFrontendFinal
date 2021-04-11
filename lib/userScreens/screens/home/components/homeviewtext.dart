import 'package:flutter/material.dart';

import '../../../../constants.dart';


Widget homeViewText({String text, Function view}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 20),
    // padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: TextStyle(
              color: kPrimaryColor, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        GestureDetector(
          onTap: view,
          child: Text('View All '),
        )
      ],
    ),
  );
}
