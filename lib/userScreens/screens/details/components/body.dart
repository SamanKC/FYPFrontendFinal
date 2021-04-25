import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medicalpasal/constants.dart';
import 'package:medicalpasal/userScreens/api/api.dart';
import 'dart:convert';
import 'dart:io';
import 'package:medicalpasal/size_config.dart';
import 'package:medicalpasal/userScreens/screens/Reviews/ReviewsAll.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:medicalpasal/userScreens/provider/productsprovider.dart';
import 'package:medicalpasal/userScreens/screens/checkoutpage/checkoutPage.dart';
import 'package:provider/provider.dart';
import '../../../../constants.dart';

class Body extends StatefulWidget {
  final product;
  // final mydata;

  const Body({Key key, @required this.product}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int selectedImage = 0;
  int numOfItems = 1;
  var newList;
  var list1;
  var list2;
  bool favourite = false;
  int valueItemChart = 0;
  String valueText;

  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  TextEditingController _textFieldController = TextEditingController();

  Future getWishlist() async {
    try {
      var response = await Api().getData("wishlist/${widget.product['id']}");
      var products = json.decode(response.body)['data'];
      print(products);
      return products;
    } on SocketException {
      return null;
    }
  }

  int wishListId;

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


  /// BottomSheet for view more in specification
  void _bottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return SingleChildScrollView(
            child: Container(
              color: Colors.black26,
              child: Padding(
                padding: const EdgeInsets.only(top: 2.0),
                child: Container(
                  height: 1500.0,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0))),
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(padding: EdgeInsets.only(top: 20.0)),
                      Center(
                          child: Text(
                        "Description",
                        style: subHeaderCustomStyle,
                      )),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 20.0, left: 20.0, right: 20.0, bottom: 20.0),
                        child: Text(widget.product['description'],
                            style: detailText),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  Widget buildSmallProductPreview(BuildContext context) {
    SizeConfig().init(context);

    if (widget.product["detailImages"].length == 0) {
      list1 = [widget.product["image"]];
      newList = list1;
    } else {
      list1 = [widget.product["image"]];
      list2 = [
        apiLink + '/images/' + widget.product["detailImages"][0]["name"]
      ];
      setState(() {
        list2.clear();
      });
      for (var i = 0; i < widget.product["detailImages"].length; i++) {
        list2.add(
            apiLink + '/images/' + widget.product["detailImages"][i]["name"]);
      }

      // list2 = [productImageSource + widget.mydata["detailImages"][0]["name"]];
      setState(() {
        newList = list1 + list2;
      });
    }
    print(newList);
    print("==========this is new list===========");
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...List.generate(newList.length, (index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedImage = index;
                  });
                },
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 200),
                  margin: EdgeInsets.only(right: 15),
                  padding: EdgeInsets.all(8),
                  height: getProportionateScreenWidth(48),
                  width: getProportionateScreenWidth(48),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color: kPrimaryColor
                            .withOpacity(selectedImage == index ? 1 : 0)),
                  ),
                  child: Image.network(newList[index]),
                ),
              );
            }),
          ],
        ),
      ],
    );
  }

  Widget buildCarouselProducts(BuildContext context) {
    SizeConfig().init(context);

    if (widget.product["detailImages"].length == 0) {
      list1 = [widget.product["image"]];
      newList = list1;
    } else {
      list1 = [widget.product["image"]];
      list2 = [
        apiLink + '/images/' + widget.product["detailImages"][0]["name"]
      ];
      setState(() {
        list2.clear();
      });
      for (var i = 0; i < widget.product["detailImages"].length; i++) {
        list2.add(
            apiLink + '/images/' + widget.product["detailImages"][i]["name"]);
      }

      // list2 = [productImageSource + widget.mydata["detailImages"][0]["name"]];
      setState(() {
        newList = list1 + list2;
      });
    }
    print(newList);
    print("==========this is new list===========");

    return CarouselSlider.builder(
        itemCount: newList.length,
        itemBuilder: (BuildContext context, int index, itemIndex) {
          return Image.network(newList[index]);
        },
        options: CarouselOptions(
          height: 200,
          aspectRatio: 16 / 9,
          viewportFraction: 0.8,
          initialPage: 0,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: true,
          autoPlayInterval: Duration(seconds: 3),
          autoPlayAnimationDuration: Duration(milliseconds: 800),
          autoPlayCurve: Curves.fastOutSlowIn,
          enlargeCenterPage: true,
          scrollDirection: Axis.horizontal,
        ));
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    //
    return Scaffold(
      key: _key,
      backgroundColor: Color(0xFFF5F6F9),
      appBar: AppBar(
        title: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            widget.product['name'],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            buildCarouselProducts(context),

            /// Background white title,price and ratting
            Container(
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                  color: Color(0xFF656565).withOpacity(0.15),
                  blurRadius: 1.0,
                  spreadRadius: 0.2,
                )
              ]),
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0, top: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          widget.product['name'],
                          style: customTextStyle,
                        ),
                        Padding(padding: EdgeInsets.only(top: 5.0)),
                        widget.product['discount'] != 0
                            ? Row(
                                children: [
                                  Text(
                                    'Rs. ' + widget.product['price'].toString(),
                                    style: TextStyle(
                                      decoration: TextDecoration.lineThrough,
                                      color: Colors.red,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Rs. ' + widget.product['sp'].toString(),
                                    style: TextStyle(
                                      color: kPrimaryColor,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ],
                              )
                            : Text(
                                'Rs. ' + widget.product['sp'].toString(),
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                        Padding(padding: EdgeInsets.only(top: 10.0)),
                        Divider(
                          color: Colors.black12,
                          height: 1.0,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            /// Background white for chose Size and Color

            /// Background white for description
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Container(
                // height: 205.0,
                // width: 600.0,
                decoration: BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(
                    color: Color(0xFF656565).withOpacity(0.15),
                    blurRadius: 1.0,
                    spreadRadius: 0.2,
                  )
                ]),
                child: Padding(
                  padding: EdgeInsets.only(top: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Text(
                          "Description",
                          style: subHeaderCustomStyle,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 15.0, right: 20.0, bottom: 10.0, left: 20.0),
                        child: Text(widget.product['description'],
                            style: detailText),
                      ),
                      // Center(
                      //   child: InkWell(
                      //     onTap: () {
                      //       _bottomSheet();
                      //     },
                      //     child: Text(
                      //       "View More",
                      //       style: TextStyle(
                      //         color: Colors.indigoAccent,
                      //         fontSize: 15.0,
                      //         fontWeight: FontWeight.w700,
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: Text(
                              "Quantity",
                              style: subHeaderCustomStyle,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 18.0, left: 0.0, right: 20),
                            child: Container(
                              width: 112.0,
                              decoration: BoxDecoration(
                                  color: Colors.white70,
                                  border: Border.all(
                                      color: Colors.black12.withOpacity(0.1))),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  /// Decrease of value item
                                  InkWell(
                                    onTap: () {
                                      if (numOfItems > 1) {
                                        setState(() {
                                          numOfItems--;
                                          // payQuantity--;
                                          // payPrice =
                                          //     mydata.price -
                                          //         mydata.price;
                                        });
                                      }
                                    },
                                    child: Container(
                                      height: 30.0,
                                      width: 30.0,
                                      decoration: BoxDecoration(
                                          border: Border(
                                              right: BorderSide(
                                                  color: Colors.black12
                                                      .withOpacity(0.1)))),
                                      child: Center(child: Text("-")),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 18.0),
                                    child: Text(numOfItems.toString()),
                                  ),

                                  /// Increasing value of item
                                  InkWell(
                                    onTap: () {
                                      if (numOfItems >= 10) {
                                        Scaffold.of(context)
                                            .showSnackBar(SnackBar(
                                          content:
                                              Text("More Items Can't be added"),
                                          duration: Duration(seconds: 2),
                                          backgroundColor: Colors.redAccent,
                                        ));
                                      } else {
                                        setState(() {
                                          numOfItems++;
                                        });
                                      }
                                    },
                                    child: Container(
                                      height: 30.0,
                                      width: 28.0,
                                      decoration: BoxDecoration(
                                          border: Border(
                                              left: BorderSide(
                                                  color: Colors.black12
                                                      .withOpacity(0.1)))),
                                      child: Center(child: Text("+")),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                ),
              ),
            ),

            /// Background white for Ratting
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Container(
                // height: 415.0,
                // width: 600.0,
                decoration: BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(
                    color: Color(0xFF656565).withOpacity(0.15),
                    blurRadius: 1.0,
                    spreadRadius: 0.2,
                  )
                ]),
                child: Padding(
                  padding: EdgeInsets.only(top: 20.0, left: 20.0, bottom: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Reviews',
                            style: subHeaderCustomStyle,
                          ),
                          Container(
                            child: Row(
                              children: [
                                InkWell(
                                  child: Text(
                                    'View All',
                                    style: subHeaderCustomStyle.copyWith(
                                        color: Colors.indigoAccent,
                                        fontSize: 14.0),
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ReviewsAll(
                                                product: widget.product)));
                                  },
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: 15.0, top: 2.0),
                                  child: Icon(
                                    Icons.arrow_forward_ios,
                                    size: 18.0,
                                    color: Colors.black54,
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 20.0, top: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(widget.product['reviewCount'].toString() +
                                ' Reviews'),
                            InkWell(
                              onTap: () {
                                return showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text('Give a Review'),
                                        content: TextField(
                                          onChanged: (value) {
                                            setState(() {
                                              valueText = value;
                                            });
                                          },
                                          controller: _textFieldController,
                                          decoration: InputDecoration(
                                              hintText:
                                                  "Write your opinion about this product!"),
                                        ),
                                        actions: <Widget>[
                                          FlatButton(
                                            color: Color(0xFFB71C1C),
                                            textColor: Colors.white,
                                            child: Text('CANCEL'),
                                            onPressed: () {
                                              setState(() {
                                                Navigator.pop(context);
                                              });
                                            },
                                          ),
                                          FlatButton(
                                            color: kPrimaryColor,
                                            textColor: Colors.white,
                                            child: Text('POST'),
                                            onPressed: () async {
                                              setState(() {
                                                Navigator.pop(context);
                                              });
                                              Map data = {
                                                "product_id":
                                                    widget.product['id'],
                                                "comment":
                                                    _textFieldController.text
                                              };
                                              var response = await Api()
                                                  .postData(data, 'review');
                                              var result =
                                                  jsonDecode(response.body);
                                              print(result);
                                              _textFieldController.text = "";
                                              Get.snackbar(
                                                "Thank You",
                                                "Thank you for your valuable feedback!",
                                                icon: Icon(Icons.shopping_cart),
                                                shouldIconPulse: true,
                                                barBlur: 20,
                                                isDismissible: true,
                                                duration: Duration(seconds: 3),
                                              );
                                            },
                                          ),
                                        ],
                                      );
                                    });
                              },
                              child: Text(
                                "Give a Review",
                                style: TextStyle(
                                  color: kPrimaryColor,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 0.0, right: 20.0, top: 15.0, bottom: 7.0),
                        child: _line(),
                      ),
                      // review(widget.product),
                      Padding(padding: EdgeInsets.only(bottom: 20.0)),
                    ],
                  ),
                ),
              ),
            ),

            // _suggestedItem
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 5.0),
        child: Container(
          color: Colors.white,
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                height: 40.0,
                width: 60.0,
                decoration: BoxDecoration(
                    color: Colors.white12.withOpacity(0.1),
                    border: Border.all(color: Colors.black12)),
                child: InkWell(
                  onTap: () {
                    Provider.of<ProductData>(context).addProduct(
                      id: widget.product["id"].toString(),
                      name: widget.product["name"],
                      price: widget.product["price"],
                      quantity: numOfItems,
                      // discount: widget.mydata['discount'],
                      image: widget.product["image"],
                      sellingPrice: widget.product["sp"],
                    );
                    setState(() {
                      valueItemChart++;
                    });
                    Get.snackbar(
                      "Added",
                      "Added to Cart",
                      icon: Icon(Icons.shopping_cart),
                      shouldIconPulse: true,
                      barBlur: 20,
                      isDismissible: true,
                      duration: Duration(seconds: 3),
                    );
                    // _key.currentState.showSnackBar(snackbar);
                  },
                  child: Center(
                    child: Image.asset(
                      "assets/icons/shopping-cart.png",
                      height: 23.0,
                    ),
                  ),
                ),
              ),

              /// Chat Icon
              Container(
                height: 40.0,
                width: 60.0,
                decoration: BoxDecoration(
                    color: Colors.white12.withOpacity(0.1),
                    border: Border.all(color: Colors.black12)),
                child: Center(
                  child: FutureBuilder(
                    future: getWishlist(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return InkWell(
                          onDoubleTap: () {
                            print("taped");
                            return null;
                          },
                          child: IconButton(
                              icon: Icon(
                                Icons.favorite,
                                color: favourite == true ||
                                        snapshot.data.length == 1
                                    ? Colors.red
                                    : Colors.grey,
                              ),
                              onPressed: () async {
                                if (snapshot.data.length == 0) {
                                  favourite = false;
                                  if (favourite == false) {
                                    //insert code
                                    Map data = {
                                      'product_id': widget.product['id'],
                                      'flags': 1,
                                    };
                                    var response =
                                        await Api().postData(data, 'wishlist');
                                    print(response.statusCode);
                                    favourite = true;

                                    setState(() {});
                                    // showInSnackBar(
                                    //     context, 'Added to Wishlist');
                                    Get.snackbar(
                                      "Added",
                                      "Added to Wishlist",
                                      icon: Icon(Icons.favorite),
                                      shouldIconPulse: true,
                                      barBlur: 20,
                                      isDismissible: true,
                                      duration: Duration(seconds: 3),
                                    );
                                    print(favourite);
                                  }
                                } else if (snapshot.data.length >= 1) {
                                  favourite = true;
                                  if (favourite == true) {
                                    deleteWishlist(snapshot.data[0]['id']);
                                    favourite = false;
                                    setState(() {});
                                    // Scaffold.of(context)
                                    //     .showSnackBar(SnackBar(
                                    //   content: Text("Wishlist Removed"),
                                    //   duration: Duration(seconds: 2),
                                    //   backgroundColor: Colors.redAccent,
                                    // ));
                                    Get.snackbar(
                                      "Removed",
                                      "Removed from Wishlist",
                                      icon: Icon(Icons.favorite_outline),
                                      shouldIconPulse: true,
                                      barBlur: 20,
                                      isDismissible: true,
                                      duration: Duration(seconds: 3),
                                    );

                                    print(favourite);
                                  }
                                }
                              }),
                        );
                      } else {
                        return CircularProgressIndicator();
                      }
                    },
                  ),
                ),
              ),

              /// Button Pay
              Container(
                height: 45.0,
                width: 200.0,
                decoration: BoxDecoration(
                  color: Colors.indigoAccent,
                ),
                child: Center(
                  child: widget.product['stock'] == 1
                      ? InkWell(
                          onTap: () {
                            Get.snackbar(
                              "Message",
                              "You can only pay for an item at a time!",
                              icon: Icon(Icons.shopping_bag_rounded),
                              shouldIconPulse: true,
                              barBlur: 20,
                              isDismissible: true,
                              duration: Duration(seconds: 3),
                            );
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CheckOut(
                                  totalPaidPrice: widget.product['sp'],
                                  totalAmount: widget.product["price"],
                                  totalDiscount: widget.product["price"] -
                                      widget.product["sp"],
                                  totalSp: widget.product["sp"],
                                  orderTotalAmount: widget.product["sp"],
                                  productDetails: [
                                    {
                                      'product_id': widget.product['id'],
                                      'quantity': numOfItems,
                                      'price': widget.product["sp"],
                                    },
                                  ],
                                ),
                              ),
                            );
                          },
                          child: Text(
                            "Pay",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700),
                          ),
                        )
                      : Text(
                          "Out of Stock",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w700),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _line() {
  return Container(
    height: 0.9,
    width: double.infinity,
    color: Colors.black12,
  );
}

// Padding(
//                                         padding: EdgeInsets.only(
//                                             left: 0.0,
//                                             right: 20.0,
//                                             top: 15.0,
//                                             bottom: 7.0),
//                                         child: _line(),
//                                       ),
