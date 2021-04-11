import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:medicalpasal/userScreens/api/api.dart';
import 'package:medicalpasal/userScreens/screens/wishlist/components/wishlistitem.dart';

class WishlistScreen extends StatelessWidget {
  static String routeName = "/wishlist";

  Future getWishlist() async {
    try {
      var response = await Api().getData('wishlist');
      var products = json.decode(response.body)['data'];
      print("====This is wishlist=======");

      print(products);
      return products;
    } on SocketException {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wishlist'),
      ),
      body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            height: 700,
            child: FutureBuilder(
                future: getWishlist(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          var alldata = snapshot.data[index];
                          // return Text(alldata.toString());

                          return WishListItemBody(alldata: alldata);
                        });
                  } else if (snapshot.hasError) {
                    return Text('Cannot load');
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
          )),
    );
  }
}
