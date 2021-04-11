import 'package:flutter/material.dart';
import 'package:medicalpasal/userScreens/provider/productsprovider.dart';

import 'package:provider/provider.dart';

import 'components/body.dart';
import 'components/check_out_card.dart';

class CartScreen extends StatelessWidget {
  static String routeName = "/cart";
  @override
  Widget build(BuildContext context) {
    var providerData = Provider.of<ProductData>(context);
    var data = providerData.totalItems.toString();
    return Scaffold(
      appBar: buildAppBar(context),
      body: Body(),
      bottomNavigationBar: data != 0.toString() ? CheckoutCard() : SizedBox(),
    );
  }

  buildAppBar(BuildContext context) {
    var providerData = Provider.of<ProductData>(context);
    return AppBar(
      title: Column(
        children: [
          Text(
            "Your Cart",
            style: TextStyle(color: Colors.black),
          ),
          Text(
            providerData.totalItems.toString() + "items",
            style: Theme.of(context).textTheme.caption,
          )
        ],
      ),
    );
  }
}
