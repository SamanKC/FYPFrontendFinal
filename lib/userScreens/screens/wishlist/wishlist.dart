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
                initialData: [],
                builder: (context, snapshot) {
                  if (snapshot.data.isEmpty) {
                    return Column(
                      children: [
                        SizedBox(
                          height: 100,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 3,
                          child: Image.asset(
                            'assets/imgIllustration/IlustrasiCart.png',
                            height: 300.0,
                          ),
                        ),
                        SizedBox(
                          height: 1,
                        ),
                        Text(
                          "Oops! Your wishlist is empty!!",
                        )
                      ],
                    );
                  }
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                      break;
                    default:
                      return ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            var alldata = snapshot.data[index];
                            // return Text(alldata.toString());

                            return WishListItemBody(alldata: alldata);
                          });
                  }
                }),
          )),
    );
  }
}
