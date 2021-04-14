// // import 'package:flutter/material.dart';
// // import 'package:medicalpasal/userScreens/api/api.dart';
// // import 'package:medicalpasal/userScreens/provider/productsprovider.dart';
// // import 'package:provider/provider.dart';
// // import 'dart:convert';

// // class CheckOut extends StatefulWidget {
// //   static String routeName = "/checkout";
// //   @override
// //   _CheckOutState createState() => _CheckOutState();
// // }

// // class _CheckOutState extends State<CheckOut> {
// //   GlobalKey<FormState> _key = GlobalKey<FormState>();
// //   @override
// //   Widget build(BuildContext context) {
// //     ProductData providerData = Provider.of<ProductData>(context);

// //     return SafeArea(
// //       child: Scaffold(
// //         body: Column(
// //           children: [
// //             Form(
// //               key: _key,
// //               child: RaisedButton(
// //                 onPressed: () async {
// //                   Map data = {
// //                     'total': providerData.totalAmount,
// //                     'transaction_type': 0,
// //                     'products': providerData.product.map((e) {
// //                       return {
// //                         'product_id': e.id,
// //                         'quantity': e.quantity,
// //                         'price': e.price,
// //                       };
// //                     }).toList()
// //                   };

// //                   var response = await Api().postData(data, 'invoice');
// //                   var result = json.decode(response.body);
// //                   print(result);
// //                 },
// //                 child: Text('Confirm'),
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }

// //TODO: form show details and delivery address

// // import 'dart:convert';

// // import 'package:flutter/material.dart';
// // import 'package:hello_mobiles/Api/Api.dart';
// // import 'package:hello_mobiles/provider/product.dart';
// // import 'package:provider/provider.dart';

// // class CheckOutScreen extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     var providerData = Provider.of<ProductData>(context);
// //     return Container(
// //       child: RaisedButton(
// //         onPressed: () async {
// //           Map data = {
// //             'total': providerData.totalAmount,
// //             'transaction_type': 0,
// //             'products': providerData.product.map((e) {
// //               return {
// //                 'product_id': e.id,
// //                 'quantity': e.quantity,
// //                 'price': e.price,
// //               };
// //             }).toList()
// //           };

// //           var response = await Api().postData(data, 'invoice');
// //           var result = json.decode(response.body);
// //           print(result);
// //         },
// //         child: Text('Confirm'),
// //       ),
// //     );
// //   }
// // }

// import 'dart:convert';
// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:medicalpasal/userScreens/api/api.dart';
// import 'package:medicalpasal/userScreens/provider/productsprovider.dart';

// import 'package:provider/provider.dart';

// class CheckOut extends StatefulWidget {
//   static String routeName = "/checkout";

//   final totalAmount;
//   final totalDiscount;
//   final orderTotalAmount;
//   final totalSp;

//   const CheckOut({
//     Key key,
//     this.totalAmount,
//     this.totalDiscount,
//     this.orderTotalAmount,
//     this.totalSp,
//   }) : super(key: key);
//   @override
//   _CheckOutState createState() => _CheckOutState();
// }

// class _CheckOutState extends State<CheckOut> {
//   GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();
//   Future getUserData() async {
//     try {
//       var response = await Api().getData('user');
//       var user = json.decode(response.body);
//       return user;
//     } on SocketException {
//       return null;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     ProductData providerData = Provider.of<ProductData>(context);
//     return Scaffold(
//       key: _scaffoldKey,
//       resizeToAvoidBottomPadding: false,
//       appBar: AppBar(
//         title: Text("CheckOut"),
//       ),
//       body: FutureBuilder(
//         future: getUserData(),
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             var mydata = snapshot.data;
//             return Column(
//               children: <Widget>[
//                 Expanded(
//                   child: Container(
//                     child: ListView(
//                       children: <Widget>[
//                         selectedAddressSection(mydata),
//                         // checkoutItem(),
//                         priceSection(providerData)
//                       ],
//                     ),
//                   ),
//                   flex: 90,
//                 ),
//                 Expanded(
//                   child: Container(
//                     width: double.infinity,
//                     margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
//                     child: RaisedButton(
//                       /*Navigator.of(context).push(new MaterialPageRoute(
//                           builder: (context) => OrderPlacePage()));*/
//                       onPressed: () async {
//                         Map data = {
//                           'total': providerData.totalAmount,
//                           'transaction_type': 0,
//                           'products': providerData.product.map((e) {
//                             return {
//                               'product_id': 1,
//                               'quantity': 1,
//                               'price': e.price,
//                             };
//                           }).toList()
//                         };

//                         var response = await Api().postData(data, 'invoice');
//                         var result = json.decode(response.body);
//                         print(result);
//                         // showThankYouBottomSheet(context);
//                       },
//                       child: Text(
//                         "Place Order",
//                         // style: textFormFieldMedium.copyWith(
//                         //     color: Colors.white,
//                         //     fontSize: 14,
//                         //     fontWeight: FontWeight.bold),
//                       ),
//                       color: Colors.pink,
//                       textColor: Colors.white,
//                     ),
//                   ),
//                   flex: 10,
//                 )
//               ],
//             );
//           } else if (snapshot.hasError) {
//             return Text('Cannot load at this time');
//           } else {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//         },
//       ),
//     );
//   }

//   showThankYouBottomSheet(BuildContext context) {
//     return _scaffoldKey.currentState.showBottomSheet((context) {
//       return Container(
//         height: 400,
//         decoration: BoxDecoration(
//             color: Colors.white,
//             border: Border.all(color: Colors.grey.shade200, width: 2),
//             borderRadius: BorderRadius.only(
//                 topRight: Radius.circular(16), topLeft: Radius.circular(16))),
//         child: Column(
//           children: <Widget>[
//             Expanded(
//               child: Container(
//                 child: Align(
//                   alignment: Alignment.bottomCenter,
//                   child: Image(
//                     image: AssetImage("assets/images/emptyCard.png"),
//                     width: 300,
//                   ),
//                 ),
//               ),
//               flex: 5,
//             ),
//             Expanded(
//               child: Container(
//                 margin: EdgeInsets.only(left: 16, right: 16),
//                 child: Column(
//                   children: <Widget>[
//                     RichText(
//                         textAlign: TextAlign.center,
//                         text: TextSpan(children: [
//                           TextSpan(
//                             text:
//                                 "\n\nThank you for your purchase. Our company values each and every customer. We strive to provide state-of-the-art devices that respond to our clients’ individual needs. If you have any questions or feedback, please don’t hesitate to reach out.",
//                             // style: textFormFieldMedium.copyWith(
//                             //     fontSize: 14, color: Colors.grey.shade800),
//                           )
//                         ])),
//                     SizedBox(
//                       height: 24,
//                     ),
//                     RaisedButton(
//                       onPressed: () {},
//                       padding: EdgeInsets.only(left: 48, right: 48),
//                       child: Text(
//                         "Track Order",
//                         // style:
//                         //     textFormFieldMedium.copyWith(color: Colors.white),
//                       ),
//                       color: Colors.pink,
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.all(Radius.circular(24))),
//                     )
//                   ],
//                 ),
//               ),
//               flex: 5,
//             )
//           ],
//         ),
//       );
//     },
//         shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(16), topRight: Radius.circular(16))),
//         backgroundColor: Colors.white,
//         elevation: 2);
//   }

//   selectedAddressSection(mydata) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Container(
//           margin: EdgeInsets.all(4),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.all(Radius.circular(4)),
//           ),
//           child: Card(
//             elevation: 0,
//             shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.all(Radius.circular(4))),
//             child: Container(
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.all(Radius.circular(4)),
//                   border: Border.all(color: Colors.grey.shade200)),
//               padding: EdgeInsets.only(left: 12, top: 8, right: 12),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   SizedBox(
//                     height: 6,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: <Widget>[
//                       Text(
//                         // mydata['name'],
//                         "hello",
//                         // style: textFormFieldSemiBold.copyWith(fontSize: 14),
//                       ),
//                       Container(
//                         padding: EdgeInsets.only(
//                             left: 8, right: 8, top: 4, bottom: 4),
//                         decoration: BoxDecoration(
//                             shape: BoxShape.rectangle,
//                             color: Colors.grey.shade300,
//                             borderRadius:
//                                 BorderRadius.all(Radius.circular(16))),
//                         child: Text(
//                           "HOME",
//                           // style: textFormFieldBlack.copyWith(
//                           //     color: Colors.indigoAccent.shade200, fontSize: 8),
//                         ),
//                       )
//                     ],
//                   ),
//                   createAddressText(
//                       "431, Commerce House, Nagindas Master, Fort", 16),
//                   createAddressText("Mumbai - 400023", 6),
//                   createAddressText("Maharashtra", 6),
//                   SizedBox(
//                     height: 6,
//                   ),
//                   RichText(
//                       text: TextSpan(children: [
//                     TextSpan(
//                       text: "Mobile : ",
//                       // style: textFormFieldMedium.copyWith(
//                       //     fontSize: 12, color: Colors.grey.shade800)),
//                     ),
//                     TextSpan(
//                       text: "02222673745",
//                       // style: textFormFieldBold.copyWith(
//                       //     color: Colors.black, fontSize: 12)),
//                       // ]),
//                     ),
//                   ])),
//                   SizedBox(
//                     height: 16,
//                   ),
//                   Container(
//                     color: Colors.grey.shade300,
//                     height: 1,
//                     width: double.infinity,
//                   ),
//                   addressAction()
//                 ],
//               ),
//             ),
//           ),
//         ),
//         SizedBox(width: 20),
//       ],
//     );
//   }

//   createAddressText(String strAddress, double topMargin) {
//     return Container(
//       margin: EdgeInsets.only(top: topMargin),
//       child: Text(
//         strAddress,
//         // style: textFormFieldMedium.copyWith(
//         //     fontSize: 12, color: Colors.grey.shade800),
//       ),
//     );
//   }

//   addressAction() {
//     return Container(
//       child: Row(
//         children: <Widget>[
//           Spacer(
//             flex: 2,
//           ),
//           FlatButton(
//             onPressed: () {},
//             child: Text(
//               "Edit / Change",
//               // style: textFormFieldSemiBold.copyWith(
//               //     fontSize: 12, color: Colors.indigo.shade700),
//             ),
//             splashColor: Colors.transparent,
//             highlightColor: Colors.transparent,
//           ),
//           Spacer(
//             flex: 3,
//           ),
//           Container(
//             height: 20,
//             width: 1,
//             color: Colors.grey,
//           ),
//           Spacer(
//             flex: 3,
//           ),
//           FlatButton(
//             onPressed: () {},
//             child: Text(
//               "Add New Address",
//               // style: textFormFieldSemiBold.copyWith(
//               //     fontSize: 12, color: Colors.indigo.shade700)),
//             ),
//             splashColor: Colors.transparent,
//             highlightColor: Colors.transparent,
//           ),
//           Spacer(
//             flex: 2,
//           ),
//         ],
//       ),
//     );
//   }

//   checkoutItem() {
//     return Container(
//       margin: EdgeInsets.all(4),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.all(Radius.circular(4)),
//       ),
//       child: Card(
//         elevation: 0,
//         shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.all(Radius.circular(4))),
//         child: Container(
//           decoration: BoxDecoration(
//               borderRadius: BorderRadius.all(Radius.circular(4)),
//               border: Border.all(color: Colors.grey.shade200)),
//           padding: EdgeInsets.only(left: 12, top: 8, right: 12, bottom: 8),
//           child: ListView.builder(
//             itemBuilder: (context, position) {
//               return checkoutListItem();
//             },
//             itemCount: 3,
//             shrinkWrap: true,
//             primary: false,
//             scrollDirection: Axis.vertical,
//           ),
//         ),
//       ),
//     );
//   }

//   checkoutListItem() {
//     return Container(
//       margin: EdgeInsets.symmetric(vertical: 4),
//       child: Row(
//         children: <Widget>[
//           Container(
//             child: Image(
//               image: AssetImage(
//                 "assets/images/emptyCard.png",
//               ),
//               width: 35,
//               height: 45,
//               fit: BoxFit.fitHeight,
//             ),
//             decoration:
//                 BoxDecoration(border: Border.all(color: Colors.grey, width: 1)),
//           ),
//           SizedBox(
//             width: 8,
//           ),
//           RichText(
//             text: TextSpan(children: [
//               TextSpan(
//                 text: "Estimated Delivery : ",
//                 // style: textFormFieldMedium.copyWith(fontSize: 12)),
//               ),
//               TextSpan(
//                 text: "21 Jul 2019 ",
//                 // style: textFormFieldMedium.copyWith(
//                 //     fontSize: 12, fontWeight: FontWeight.w600))
//               )
//             ]),
//           )
//         ],
//       ),
//     );
//   }

//   priceSection(ProductData productData) {
//     return Container(
//       margin: EdgeInsets.all(4),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.all(Radius.circular(4)),
//       ),
//       child: Card(
//         elevation: 0,
//         shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.all(Radius.circular(4))),
//         child: Container(
//           decoration: BoxDecoration(
//               borderRadius: BorderRadius.all(Radius.circular(4)),
//               border: Border.all(color: Colors.grey.shade200)),
//           padding: EdgeInsets.only(left: 12, top: 8, right: 12, bottom: 8),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               SizedBox(
//                 height: 4,
//               ),
//               Text(
//                 "PRICE DETAILS",
//                 // style: textFormFieldMedium.copyWith(
//                 //     fontSize: 12,
//                 //     color: Colors.black,
//                 //     fontWeight: FontWeight.w600),
//               ),
//               SizedBox(
//                 height: 4,
//               ),
//               Container(
//                 width: double.infinity,
//                 height: 0.5,
//                 margin: EdgeInsets.symmetric(vertical: 4),
//                 color: Colors.grey.shade400,
//               ),
//               SizedBox(
//                 height: 8,
//               ),
//               createPriceItem("Total MRP", widget.totalAmount.toString(),
//                   Colors.grey.shade700),
//               createPriceItem("Bag discount", widget.totalDiscount.toString(),
//                   Colors.teal.shade300),
//               // productData.totalDiscount.toString(), Colors.teal.shade300),
//               createPriceItem("Tax", '96', Colors.grey.shade700),
//               // createPriceItem("Order Total", productData.totalAmount.toString(),
//               createPriceItem("Order Total", widget.totalSp.toString(),
//                   Colors.grey.shade700),
//               createPriceItem(
//                   "Delievery Charges", "FREE", Colors.teal.shade300),
//               SizedBox(
//                 height: 8,
//               ),
//               Container(
//                 width: double.infinity,
//                 height: 0.5,
//                 margin: EdgeInsets.symmetric(vertical: 4),
//                 color: Colors.grey.shade400,
//               ),
//               SizedBox(
//                 height: 8,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   Text(
//                     "Total",
//                     // style: textFormFieldSemiBold.copyWith(
//                     //     color: Colors.black, fontSize: 12),
//                   ),
//                   Text(
//                     productData.totalAmount.toString(),
//                     // style: textFormFieldMedium.copyWith(
//                     //     color: Colors.black, fontSize: 12),
//                   )
//                 ],
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   // String getFormattedCurrency(double amount) {
//   //   FlutterMoneyFormatter fmf = new FlutterMoneyFormatter(amount: amount);
//   //   fmf.symbol = "₹";
//   //   fmf.thousandSeparator = ",";
//   //   fmf.decimalSeparator = ".";
//   //   fmf.spaceBetweenSymbolAndNumber = true;
//   //   return fmf.formattedLeftSymbol;
//   // }

//   createPriceItem(String key, String value, Color color) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 0, vertical: 3),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: <Widget>[
//           Text(
//             key,
//             // style: textFormFieldMedium.copyWith(
//             //     color: Colors.grey.shade700, fontSize: 12),
//           ),
//           Text(
//             value,
//             // style: textFormFieldMedium.copyWith(color: color, fontSize: 12),
//           )
//         ],
//       ),
//     );
//   }
// }
