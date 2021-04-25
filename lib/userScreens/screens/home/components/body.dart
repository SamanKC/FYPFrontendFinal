import 'package:flutter/material.dart';
import 'package:medicalpasal/userScreens/screens/home/components/discountproducts.dart';
import 'package:medicalpasal/constants.dart';
import 'package:medicalpasal/size_config.dart';
import 'TopPromoSlider.dart';
import 'categories.dart';
import 'recent_product.dart';
import 'homeviewtext.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          // SizedBox(height: getProportionateScreenWidth(20.0)),
          // DiscountBanner(),
          TopPromoSlider(),
          Categories(),

          SizedBox(height: getProportionateScreenWidth(30.0)),
          homeViewText(text: 'Recent Products'),

          RecentProducts(),
          SizedBox(height: 30.0),
          homeViewText(text: 'Discount Sale'),
          DiscountProducts(),
          SizedBox(height: getProportionateScreenWidth(30.0)),
        ],
      ),
    );
  }
}
