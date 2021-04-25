import 'package:flutter/material.dart';
import 'package:medicalpasal/constants.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:medicalpasal/size_config.dart';
import 'package:medicalpasal/userScreens/provider/productsprovider.dart';
import 'package:medicalpasal/userScreens/screens/details/details_screen.dart';

import 'package:provider/provider.dart';

class ItemGrid extends StatefulWidget {
  final mydata;

  const ItemGrid({Key key, this.mydata}) : super(key: key);

  @override
  _ItemGridState createState() => _ItemGridState();
}

class _ItemGridState extends State<ItemGrid> {
  int numOfItems = 1;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          top: 20.0, left: 10.0, bottom: 10.0, right: 0.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailsScreen(
                      mydata: widget.mydata,
                    )),
          );
        },
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
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
                // height: MediaQuery.of(context).size.height / 3,
                width: MediaQuery.of(context).size.width / 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        Container(
                          height: 185.0,
                          width: 180.0,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(7.0),
                                  topRight: Radius.circular(7.0)),
                              image: DecorationImage(
                                  image: NetworkImage(widget.mydata['image']),
                                  fit: BoxFit.cover)),
                        ),
                        widget.mydata['discount'].toString() != '0'
                            ? Container(
                                height: 25.5,
                                width: 85.0,
                                decoration: BoxDecoration(
                                    color: Color(0xFFD7124A),
                                    borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(20.0),
                                        topLeft: Radius.circular(5.0))),
                                child: Center(
                                    child: Text(
                                  widget.mydata['discount'].toString() +
                                      '% off',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600),
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
                      height: getProportionateScreenHeight(35),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                        child: Text(
                          widget.mydata['name'],
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
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 15.0, right: 15.0),
                            child: Text(
                              'Rs.' + widget.mydata['price'].toString(),
                              style: TextStyle(
                                  fontFamily: "Sans",
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14.0),
                            ),
                          ),
                          Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                                color: kPrimaryColor,
                                borderRadius: BorderRadius.circular(2)),
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
                                Provider.of<ProductData>(context).addProduct(
                                  id: widget.mydata["id"].toString(),
                                  name: widget.mydata["name"],
                                  price: widget.mydata["price"],
                                  quantity: numOfItems,
                                  // discount: widget.mydata['discount'],
                                  image: widget.mydata["image"],
                                  sellingPrice: widget.mydata["sp"],
                                );
                                Scaffold.of(context).showSnackBar(SnackBar(
                                  content: Text("Cart Added"),
                                  duration: Duration(seconds: 2),
                                  backgroundColor: Colors.green,
                                ));
                              },
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
  }
}
