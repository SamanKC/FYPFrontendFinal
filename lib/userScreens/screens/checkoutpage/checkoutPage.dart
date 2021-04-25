import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:medicalpasal/constants.dart';
import 'package:medicalpasal/userScreens/api/api.dart';
import 'package:medicalpasal/userScreens/components/default_button.dart';
import 'package:medicalpasal/userScreens/provider/productsprovider.dart';
import 'package:provider/provider.dart';
import 'dart:convert';

class CheckOut extends StatefulWidget {
  static String routeName = "/checkout";
  final totalAmount;
  final totalDiscount;
  final totalSp;
  final orderTotalAmount;
  final productDetails;
  final totalPaidPrice;

  const CheckOut({
    Key key,
    this.totalAmount,
    this.totalDiscount,
    this.totalSp,
    this.orderTotalAmount,
    this.productDetails,
    this.totalPaidPrice,
  }) : super(key: key);
  @override
  _CheckOutState createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();
  int selectedRadioTile;
  setSelectedRadioTile(int val) {
    setState(() {
      selectedRadioTile = val;
    });
  }

  @override
  void initState() {
    super.initState();
    // selectedRadio = 0;
    selectedRadioTile = 0;
  }

  Future getUserData() async {
    try {
      var response = await Api().getData('user');
      var user = json.decode(response.body);
      return user;
    } on SocketException {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    ProductData providerData = Provider.of<ProductData>(context);
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('CheckOut'),
      ),
      body: FutureBuilder(
        future: getUserData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var mydata = snapshot.data;
            return Column(
              children: <Widget>[
                Expanded(
                  child: Container(
                    child: ListView(
                      children: <Widget>[
                        checkoutItem(mydata: mydata),
                        Container(
                          margin: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                          ),
                          child: Card(
                            child: RadioListTile(
                              value: 0,
                              groupValue: selectedRadioTile,
                              title: Row(
                                children: [
                                  Text("Cash on Delivery"),
                                ],
                              ),
                              onChanged: (val) {
                                print("Radio Tile pressed $val");
                                setSelectedRadioTile(val);
                                print(selectedRadioTile);
                              },
                              activeColor: kPrimaryColor,
                              autofocus: true,
                          
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                          ),
                          child: Card(
                            child: RadioListTile(
                              value: 1,
                              groupValue: selectedRadioTile,
                              title: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                             
                                  Text("Esewa")
                                ],
                              ),
                              onChanged: (val) {
                                print("Radio Tile pressed $val");
                                setSelectedRadioTile(val);
                                print(selectedRadioTile);
                              },
                              activeColor: kPrimaryColor,
                           
                            ),
                          ),
                        ),
                        priceSection(providerData)
                      ],
                    ),
                  ),
                  flex: 90,
                ),
           
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
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(18.0),
        child: DefaultButton(
          text: 'Confirm',
          color: kPrimaryColor,
          textColor: Colors.white,
          press: () async {
            Map data = {
              'total': widget.totalPaidPrice,
              'transaction_type': selectedRadioTile,
              'products': widget.productDetails,
         
            };

            var response = await Api().postData(data, 'invoice');
            var result = json.decode(response.body);
            print(result);
            if (result['code'] == 200) {
              _showDialog(context);
            } else {
              Get.snackbar(
                "Sorry",
                "Unable to order the product",
                icon: Icon(Icons.shopping_bag_rounded),
                shouldIconPulse: true,
                barBlur: 20,
                isDismissible: true,
                duration: Duration(seconds: 3),
              );
            }
          },
        ),
      ),
    );
  }

  checkoutItem({mydata}) {
    return Container(
      margin: EdgeInsets.all(4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(4))),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              border: Border.all(color: Colors.grey.shade200)),
          padding: EdgeInsets.only(left: 12, top: 8, right: 12, bottom: 8),
          child: Container(
              margin: EdgeInsets.symmetric(vertical: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Your details"),
                  SizedBox(
                    height: 10,
                  ),
                  RichText(
                    text: TextSpan(children: [
                      TextSpan(
                          text: "Name : ",
                          style: textFormFieldMedium.copyWith(
                              fontSize: 14, color: Colors.grey.shade800)),
                      TextSpan(
                          text: mydata['name'],
                          style: textFormFieldBold.copyWith(
                              color: Colors.black, fontSize: 14)),
                    ]),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  RichText(
                    text: TextSpan(children: [
                      TextSpan(
                          text: "Mobile : ",
                          style: textFormFieldMedium.copyWith(
                              fontSize: 14, color: Colors.grey.shade800)),
                      TextSpan(
                          text: mydata['phone'].toString(),
                          style: textFormFieldBold.copyWith(
                              color: Colors.black, fontSize: 14)),
                    ]),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  RichText(
                    text: TextSpan(children: [
                      TextSpan(
                          text: "Address : ",
                          style: textFormFieldMedium.copyWith(
                              fontSize: 14, color: Colors.grey.shade800)),
                      TextSpan(
                          text: mydata['city'] +
                              ', ' +
                              mydata['area'] +
                              ', ' +
                              mydata['ward'] +
                              ', ' +
                              mydata['address'],
                          style: textFormFieldBold.copyWith(
                              color: Colors.black, fontSize: 14)),
                    ]),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  // RaisedButton(
                  //   onPressed: () {},
                  //   child: Text(
                  //     'Edit Address',
                  //     style: TextStyle(color: kPrimaryColor),
                  //   ),
                  //   color: Colors.white,
                  // )
                ],
              )),
        ),
      ),
    );
  }

  priceSection(ProductData productData) {
    return Container(
      margin: EdgeInsets.all(4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(4))),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              border: Border.all(color: Colors.grey.shade200)),
          padding: EdgeInsets.only(left: 12, top: 8, right: 12, bottom: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 4,
              ),
              Text(
                "PRICE DETAILS",
                style: textFormFieldMedium.copyWith(
                    fontSize: 12,
                    color: Colors.black,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 4,
              ),
              Container(
                width: double.infinity,
                height: 0.5,
                margin: EdgeInsets.symmetric(vertical: 4),
                color: Colors.grey.shade400,
              ),
              SizedBox(
                height: 8,
              ),
              createPriceItem("Total MRP", widget.totalAmount.toString(),
                  Colors.grey.shade700),
              createPriceItem("Bag discount", widget.totalDiscount.toString(),
                  Colors.teal.shade300),
              createPriceItem("Order Total", widget.totalSp.toString(),
                  Colors.grey.shade700),
              createPriceItem(
                  "Delievery Charges", "FREE", Colors.teal.shade300),
              SizedBox(
                height: 8,
              ),
              Container(
                width: double.infinity,
                height: 0.5,
                margin: EdgeInsets.symmetric(vertical: 4),
                color: Colors.grey.shade400,
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Total",
                    style: textFormFieldSemiBold.copyWith(
                        color: Colors.black, fontSize: 14),
                  ),
                  Text(
                    widget.orderTotalAmount.toString(),
                    style: textFormFieldMedium.copyWith(
                        color: Colors.black, fontSize: 14),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  createPriceItem(String key, String value, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            key,
            style: textFormFieldMedium.copyWith(
                color: Colors.grey.shade700, fontSize: 14),
          ),
          Text(
            value,
            style: textFormFieldMedium.copyWith(color: color, fontSize: 14),
          )
        ],
      ),
    );
  }
}

/// Card Popup if success payment
_showDialog(BuildContext ctx) {
  showDialog(
    context: ctx,
    barrierDismissible: true,
    child: SimpleDialog(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: 30.0, right: 60.0, left: 60.0),
          color: Colors.white,
          child: Image.asset(
            "assets/images/checklist.png",
            height: 110.0,
            color: Colors.lightGreen,
          ),
        ),
        Center(
            child: Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Text(
            "Yuppy!!",
            style: TextStyle(
              color: Colors.black54,
              fontSize: 23.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        )),
        Center(
            child: Padding(
          padding: const EdgeInsets.only(top: 30.0, bottom: 40.0),
          child: Text(
            "Payment Successful",
            style: TextStyle(
              color: Colors.black38,
              fontSize: 15.0,
              fontWeight: FontWeight.w500,
            ),
          ),
        )),
      ],
    ),
  );
}
