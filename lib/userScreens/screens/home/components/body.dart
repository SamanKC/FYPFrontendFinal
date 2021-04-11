import 'package:flutter/material.dart';

import 'TopPromoSlider.dart';
import 'categories.dart';
import 'home_header.dart';
import 'recent_product.dart';
import 'homeviewtext.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // SizedBox(height: getProportionateScreenWidth(20.0)),
          // DiscountBanner(),
          TopPromoSlider(),
          Categories(),
          // SpecialOffers(),
          SizedBox(height: 30.0),
          // SizedBox(height: getProportionateScreenWidth(30.0)),
          homeViewText(text: 'Recent Products', view: () {}),
          RecentProducts(),
          SizedBox(height: 30.0),
          // SizedBox(height: getProportionateScreenWidth(30.0)),
        ],
      ),
    );
  }
}
