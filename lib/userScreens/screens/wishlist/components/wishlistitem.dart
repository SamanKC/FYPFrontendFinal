import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:medicalpasal/userScreens/components/snackBar.dart';
import 'package:medicalpasal/userScreens/screens/details/details_screen.dart';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:medicalpasal/constants.dart';
import 'package:medicalpasal/userScreens/api/api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:medicalpasal/userScreens/provider/productsprovider.dart';
import 'package:medicalpasal/userScreens/models/Product.dart';

class WishListItemBody extends StatefulWidget {
  final alldata;

  const WishListItemBody({Key key, this.alldata}) : super(key: key);

  @override
  _WishListItemBodyState createState() => _WishListItemBodyState();
}

class _WishListItemBodyState extends State<WishListItemBody> {
  Future deleteWishlist(int wishlistId) async {
    try {
      var response = await Api().deleteData("wishlist/$wishlistId");
      var products = json.decode(response.body)['data'];
      print("===========");

      print(products);
      return products;
    } on SocketException {
      return null;
    }
  }

  int numOfItems = 1;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(widget.alldata['id'].toString()),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        deleteWishlist(widget.alldata['id']);
        // Provider.of<ProductData>(context).removeProduct(id);
        showInSnackBar(
            context, "${widget.alldata['name']} deleted from wishlist");
      },
      background: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: Color(0xFFFFE6E6),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            Spacer(),
            Icon(
              FontAwesome.trash,
              color: kPrimaryColor,
            ),
          ],
        ),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 5,
          ),
          Container(
            padding: const EdgeInsets.only(
                top: 2.0, left: 5.0, bottom: 2.0, right: 1.0),
            height: 180,
            child: Card(
              elevation: 1.0,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DetailsScreen(
                              mydata: widget.alldata,
                            )),
                  );
                },
                child: Row(
                  children: [
                    Container(
                      height: 130,
                      width: 135,
                      padding: EdgeInsets.all(30),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(0),
                        image: DecorationImage(
                          image: NetworkImage(
                              apiLink + '/' + widget.alldata['image']),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(
                          left: 30, top: 10.0, bottom: 10.0, right: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            overflow: TextOverflow.ellipsis,
                            strutStyle: StrutStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w500,
                            ),
                            text: TextSpan(
                              style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                              text: widget.alldata['name'],
                            ),
                          ),
                          // Text(
                          //   alldata['product']['name'],
                          //   style: TextStyle(
                          //       fontSize: 15,
                          //       fontFamily: 'Montserrat',
                          //       fontWeight:
                          //           FontWeight.bold),
                          // ),

                          SizedBox(
                            height: 5,
                          ),

                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                    text: 'Rs: ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey,
                                    )),
                                TextSpan(
                                    text: widget.alldata['price'].toString() +
                                        '  ',
                                    style: TextStyle(
                                      decoration: TextDecoration.lineThrough,
                                      fontStyle: FontStyle.italic,
                                      color: Color(0xFF6c63ff),
                                    )),
                                TextSpan(
                                    text: widget.alldata['sp'].toString(),
                                    style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      color: kPrimaryColor,
                                    )),
                              ],
                            ),
                          ),

                          RichText(
                            text: TextSpan(children: [
                              TextSpan(text: 'Status'),
                              TextSpan(
                                  text: widget.alldata["availableStatus"] == 1
                                      ? 'On Stock '
                                      : 'Out of Stock')
                            ]),
                          ),
                          SizedBox(
                            height: 8,
                          ),

                          widget.alldata["availableStatus"] == 1
                              ? OutlinedButton.icon(
                                  icon: Icon(
                                    Icons.shopping_cart_outlined,
                                    color: kPrimaryColor,
                                  ),
                                  label: Text(
                                    "Add to Cart",
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                  onPressed: () {
                                    Provider.of<ProductData>(context)
                                        .addProduct(
                                      id: widget.alldata["id"].toString(),
                                      name: widget.alldata["name"],
                                      price: widget.alldata["price"],
                                      quantity: numOfItems,
                                      // discount: widget.mydata['discount'],
                                      image: widget.alldata['image'],
                                      sellingPrice: widget.alldata["sp"],
                                    );
                                    showInSnackBar(context,
                                        "${widget.alldata['name']} Added to  Cart");
                                  },
                                  style: ElevatedButton.styleFrom(
                                    side: BorderSide(
                                        width: 2.0, color: Colors.black),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(32.0),
                                    ),
                                  ),
                                )
                              : Container(),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
