import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:medicalpasal/size_config.dart';
import 'package:medicalpasal/userScreens/api/api.dart';
import 'package:medicalpasal/userScreens/provider/productsprovider.dart';
import 'package:medicalpasal/userScreens/screens/details/details_screen.dart';

import 'package:provider/provider.dart';
import 'package:showcaseview/showcase.dart';
import 'package:showcaseview/showcase_widget.dart';

import '../../../../constants.dart';

class DiscountProducts extends StatefulWidget {
  static String routeName = "/DiscountProducts";
  //Get Products data
  @override
  _DiscountProductsState createState() => _DiscountProductsState();
}

class _DiscountProductsState extends State<DiscountProducts> {
  List<dynamic> products = [];
  int numOfItems = 1;
  Future getProductsData() async {
    try {
      var response = await Api().getData('discountProducts');
      var products = json.decode(response.body)['data'];
      print(products);
      return products;
    } on SocketException {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    // final ApiProvider = Provider.of(context,listen: )

    SizeConfig().init(context);
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Column(
        children: [
          FutureBuilder(
            future: getProductsData(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Row(
                  children: [
                    ...List.generate(snapshot.data.length, (index) {
                      var mydata = snapshot.data[index];

                      return Padding(
                        padding: const EdgeInsets.only(
                            top: 20.0, left: 10.0, bottom: 10.0, right: 0.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DetailsScreen(
                                        mydata: mydata,
                                      )),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0xFF656565).withOpacity(0.15),
                                    blurRadius: 2.0,
                                    spreadRadius: 1.0,
                                  )
                                ]),
                            child: Wrap(
                              children: <Widget>[
                                Container(
                                  width: 180.0,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Stack(
                                        children: <Widget>[
                                          Container(
                                            height: 185.0,
                                            width: 180.0,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(7.0),
                                                    topRight:
                                                        Radius.circular(7.0)),
                                                image: DecorationImage(
                                                    image: NetworkImage(
                                                        mydata['image']),
                                                    fit: BoxFit.cover)),
                                          ),
                                          mydata['discount'].toString() != '0'
                                              ? Container(
                                                  height: 25.5,
                                                  width: 85.0,
                                                  decoration: BoxDecoration(
                                                      color: Color(0xFFD7124A),
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          20.0),
                                                              topLeft: Radius
                                                                  .circular(
                                                                      5.0))),
                                                  child: Center(
                                                      child: Text(
                                                    mydata['discount']
                                                            .toString() +
                                                        '% off',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  )),
                                                )
                                              : SizedBox()
                                        ],
                                      ),
                                      Padding(
                                          padding: EdgeInsets.only(
                                              top:
                                                  // top: getProportionateScreenHeight(
                                                  7.0)),
                                      Container(
                                        height:
                                            getProportionateScreenHeight(35),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 15.0, right: 15.0),
                                          child: Text(
                                            mydata['name'],
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                letterSpacing: 0.5,
                                                color: Colors.black54,
                                                fontFamily: "Sans",
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16.0),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                          padding: EdgeInsets.only(top: 1.0)),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 15.0, right: 15.0),
                                              child: Text(
                                                'Rs.' +
                                                    mydata['price'].toString(),
                                                style: TextStyle(
                                                    fontFamily: "Sans",
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 14.0),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                bottom: 10.0,
                                              ),
                                              child: Container(
                                                height: 30,
                                                width: 30,
                                                decoration: BoxDecoration(
                                                    color: kPrimaryColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            2)),
                                                // child: Icon(
                                                //   FontAwesome.cart_plus,
                                                //   color: Colors.white,
                                                //   size: 14.0,
                                                // ),
                                                child: IconButton(
                                                  icon: Icon(
                                                    FontAwesome.cart_plus,
                                                    color: Colors.white,
                                                    size: 14.0,
                                                  ),
                                                  onPressed: () {
                                                    Provider.of<ProductData>(
                                                            context)
                                                        .addProduct(
                                                      id: mydata["id"]
                                                          .toString(),
                                                      name: mydata["name"],
                                                      price: mydata["price"],
                                                      quantity: numOfItems,
                                                      // discount: widget.mydata['discount'],
                                                      image: mydata["image"],
                                                      sellingPrice:
                                                          mydata["sp"],
                                                    );
                                                    Scaffold.of(context)
                                                        .showSnackBar(SnackBar(
                                                      content:
                                                          Text("Cart Added"),
                                                      duration:
                                                          Duration(seconds: 2),
                                                      backgroundColor:
                                                          Colors.green,
                                                    ));

                                                    // Provider.of<ProductData>(
                                                    //         context)
                                                    //     .addProduct(
                                                    //   id: mydata['id']
                                                    //       .toString(),
                                                    //   name: mydata['name'],
                                                    //   price: mydata['price'],
                                                    //   quantity: numOfItems,
                                                    //   image: mydata['image'],
                                                    // );
                                                    // print(mydata);
                                                  },
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),

                    // SizedBox(width: 20),
                    SizedBox(width: getProportionateScreenWidth(20)),
                  ],
                );
              } else if (snapshot.hasError) {
                return Text('Cannot load at this time');
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
