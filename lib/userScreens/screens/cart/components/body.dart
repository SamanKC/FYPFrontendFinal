import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:medicalpasal/userScreens/provider/productsprovider.dart';

import 'package:provider/provider.dart';

import '../../../../size_config.dart';
import 'emptycart.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int payTotal;
  int totalCardTotal = 0;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var providerData = Provider.of<ProductData>(context);
    print(providerData.index);
    return providerData.product.length <= 0
        ? EmptyCart()
        : ListView.builder(
            itemCount: providerData.product.length,
            itemBuilder: (context, index) {
              var mydata = providerData.product[index];
              int payPrice = mydata.price;
              int payQuantity = mydata.quantity;
              int oneCartTotal = payPrice * payQuantity;
              for (var i = 0; i < providerData.product.length; i++) {
                totalCardTotal = totalCardTotal + oneCartTotal;
              }

              mydata.amount = payTotal;
              print("total");
              print(totalCardTotal);
              print(mydata.id);

              ///
              /// Widget for list view slide delete
              ///
              // return Slidable(
              //   delegate: SlidableDrawerDelegate(),
              //   actionExtentRatio: 0.25,
              //   secondaryActions: <Widget>[
              //     IconSlideAction(
              //       key: Key(mydata.id),
              //       caption: 'Delete',
              //       color: Colors.red,
              //       icon: Icons.delete,
              //       onTap: () {
              //         setState(() {
              //           Provider.of<ProductData>(context)
              //               .removeProduct(mydata.id);
              //         });
              //         Scaffold.of(context).showSnackBar(SnackBar(
              //           content: Text("Items Cart Deleted"),
              //           duration: Duration(seconds: 2),
              //           backgroundColor: Colors.redAccent,
              //         ));

              //         ///
              //         /// SnackBar show if cart delet
              //         ///
              //       },
              //     ),
              //   ],
              return Dismissible(
                key: Key(mydata.id.toString()),
                direction: DismissDirection.endToStart,
                onDismissed: (direction) {
                  // deleteWishlist(widget.alldata['wishListId']);
                  setState(() {
                    providerData.removeProduct(mydata.id);
                  });
                },
                background: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Color(0xFFFFE6E6),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.only(top: 1.0, left: 13.0, right: 13.0),

                  /// Background Constructor for card
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12.withOpacity(0.1),
                          blurRadius: 3.5,
                          spreadRadius: 0.4,
                        )
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                                padding: EdgeInsets.all(10.0),

                                /// Image item
                                child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.1),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.black12
                                                  .withOpacity(0.1),
                                              blurRadius: 0.5,
                                              spreadRadius: 0.1)
                                        ]),
                                    child: Image.network(
                                      mydata.image,
                                      height: 100.0,
                                      width: 100.0,
                                      fit: BoxFit.cover,
                                    ))),
                            Flexible(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 15.0, left: 10.0, right: 5.0),
                                child: Column(
                                  /// Text Information Item
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      mydata.name,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black87,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Padding(
                                        padding: EdgeInsets.only(top: 10.0)),
                                    // Text(
                                    //   '${items[position].desc}',
                                    //   style: TextStyle(
                                    //     color: Colors.black54,
                                    //     fontWeight: FontWeight.w500,
                                    //     fontSize: 12.0,
                                    //   ),
                                    // ),
                                    Padding(
                                        padding: EdgeInsets.only(top: 10.0)),
                                    Text('Rs. ' + mydata.price.toString()),
                                    Text('Quantity: ' +
                                        mydata.quantity.toString()),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        // Padding(padding: EdgeInsets.only(top: 8.0)),
                        // Divider(
                        //   height: 2.0,
                        //   color: Colors.black12,
                        // ),
                        // Padding(
                        //   padding: const EdgeInsets.only(
                        //       top: 9.0, left: 10.0, right: 10.0),
                        //   child: Row(
                        //     mainAxisAlignment:
                        //         MainAxisAlignment.spaceBetween,
                        //     children: <Widget>[
                        //       Padding(
                        //         padding: const EdgeInsets.only(left: 10.0),

                        //         /// Total price of item buy
                        //         child: Text(
                        //           "Total : Rs. " + oneCartTotal.toString(),
                        //           style: TextStyle(
                        //             color: Colors.black,
                        //             fontWeight: FontWeight.w500,
                        //             fontSize: 15.5,
                        //           ),
                        //         ),
                        //       ),
                        //       InkWell(
                        //         onTap: () {},
                        //         child: Padding(
                        //           padding:
                        //               const EdgeInsets.only(right: 10.0),
                        //           child: Container(
                        //             height: 40.0,
                        //             width: 120.0,
                        //             decoration: BoxDecoration(
                        //               color: Color(0xFFA3BDED),
                        //             ),
                        //             child: Center(
                        //               child: Text(
                        //                 "Pay",
                        //                 style: TextStyle(
                        //                     color: Colors.white,
                        //                     fontFamily: "Sans",
                        //                     fontWeight: FontWeight.w600),
                        //               ),
                        //             ),
                        //           ),
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
              );
            },
            scrollDirection: Axis.vertical,
          );
  }
}
