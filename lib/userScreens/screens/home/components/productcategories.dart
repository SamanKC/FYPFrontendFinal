import 'dart:convert';
import 'dart:io';
import 'package:medicalpasal/size_config.dart';
import 'package:flutter/material.dart';
import 'package:medicalpasal/userScreens/api/api.dart';

class ProductsCategories extends StatelessWidget {
  final catid;

  const ProductsCategories({Key key, this.catid}) : super(key: key);
  Future getProductData() async {
    try {
      var response = await Api().getData('categories/$catid');
      var category = json.decode(response.body)['data'];
      print('........................................');
      print(category);
      return category;
    } on SocketException {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FutureBuilder(
              future: getProductData(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  // return Row(
                  //   children: [
                  //     ...List.generate(snapshot.data.length, (index) {
                  //       var mydata = snapshot.data[index];
                  //       return Container(
                  //         width: getProportionateScreenWidth(150),
                  //         child: Card(
                  //           elevation: 2,
                  //           shadowColor: Colors.black,
                  //           color: Color(0xFFf6f6f6),
                  //           child: Column(
                  //             children: [
                  //               SizedBox(
                  //                 height: 10,
                  //               ),
                  //               InkWell(
                  //                 onTap: () {
                  //                   // Navigator.push(
                  //                   //   context,
                  //                   //   MaterialPageRoute(
                  //                   //       builder: (context) =>
                  //                   //           ProductDetailScreen(
                  //                   //             mydata: mydata,
                  //                   //           )),
                  //                   // );
                  //                 },
                  //                 child: Column(
                  //                   children: [
                  //                     Hero(
                  //                       tag: mydata["id"],
                  //                       child: Image(
                  //                         image: NetworkImage(mydata["image"]),
                  //                         height: 70,
                  //                         fit: BoxFit.contain,
                  //                       ),
                  //                     ),
                  //                     SizedBox(
                  //                       height: 10,
                  //                     ),
                  //                     RichText(
                  //                       overflow: TextOverflow.ellipsis,
                  //                       strutStyle: StrutStyle(
                  //                         fontSize: 14,
                  //                         fontWeight: FontWeight.w500,
                  //                       ),
                  //                       text: TextSpan(
                  //                           style: TextStyle(
                  //                             color: Colors.black45,
                  //                           ),
                  //                           text: mydata["name"]),
                  //                     ),
                  //                     //SizedBox
                  //                     // Text(
                  //                     //   mydata["name"],

                  //                     //   textAlign: TextAlign.center,
                  //                     //   style: TextStyle(
                  //                     //     fontSize: 14,
                  //                     //     color: Colors.black45,
                  //                     //     fontWeight: FontWeight.w500,
                  //                     //   ), //Textstyle
                  //                     // ),
                  //                   ],
                  //                 ),
                  //               ),
                  //               //Text
                  //               SizedBox(
                  //                 height: 10,
                  //               ), //SizedBox
                  //               Text(
                  //                 'Rs: ' + mydata["price"].toString(),
                  //                 style: TextStyle(
                  //                     fontSize: 14,
                  //                     color: Color(0xFF6c63ff),
                  //                     fontWeight: FontWeight.bold), //Textstyle
                  //               ), //Text
                  //               SizedBox(
                  //                 height: 10,
                  //               ), //SizedBox
                  //               SizedBox(
                  //                 width: getProportionateScreenWidth(100),
                  //                 height: getProportionateScreenHeight(30),
                  //                 child: FlatButton(
                  //                   color: Colors.white,
                  //                   shape: RoundedRectangleBorder(
                  //                     side: BorderSide(
                  //                         color: Color(0xFFB71C1C), width: 2),
                  //                   ),
                  //                   onPressed: () {
                  //                     // Navigator.push(
                  //                     //   context,
                  //                     //   MaterialPageRoute(
                  //                     //       builder: (context) =>
                  //                     //           CheckoutPage(
                  //                     //             totalAmount:
                  //                     //                 mydata["price"],
                  //                     //             totalDiscount:
                  //                     //                 mydata["discount"],
                  //                     //             totalSp:
                  //                     //                 mydata["sellingPrice"],
                  //                     //           )),
                  //                     //);
                  //                   },
                  //                   child: Padding(
                  //                     padding: const EdgeInsets.symmetric(
                  //                         vertical: 5.0),
                  //                     child: Text(
                  //                       'Buy Now',
                  //                       style:
                  //                           TextStyle(color: Color(0xFFB71C1C)),
                  //                     ),
                  //                   ),
                  //                 ),
                  //               ),
                  //               SizedBox(
                  //                 height: 5,
                  //               ), //SizedBox
                  //             ],
                  //           ), //Padding
                  //           //SizedBox
                  //         ),
                  //       );
                  //     }),
                  //   ],
                  // );
                  //   return GridView.count(
                  // shrinkWrap: true,
                  // padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                  // crossAxisSpacing: 10.0,
                  // mainAxisSpacing: 17.0,
                  // childAspectRatio: 0.545,
                  // crossAxisCount: 2,
                  // primary: false,
                  // children: List.generate(
                  //   gridItemArray.length,
                  //       (index) => ItemGrid(gridItemArray[index]),
                  // ))
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
      ),
    );
  }
}
