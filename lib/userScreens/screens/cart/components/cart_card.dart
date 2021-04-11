import 'package:flutter/material.dart';
import 'package:medicalpasal/userScreens/provider/productsprovider.dart';
import 'package:provider/provider.dart';

import '../../../../constants.dart';
import '../../../../size_config.dart';

class CartCard extends StatefulWidget {
  final String id;
  final String name;
  final int price;
  final int quantity;
  final int amount;
  final String image;

  const CartCard(
      {Key key,
      this.id,
      this.name,
      this.price,
      this.quantity,
      this.amount,
      this.image})
      : super(key: key);

  @override
  _CartCardState createState() => _CartCardState();
}

class _CartCardState extends State<CartCard> {
  int numOfItems = 1;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Row(
      children: [
        SizedBox(
          width: 88,
          child: AspectRatio(
            aspectRatio: 0.88,
            child: Container(
              padding: EdgeInsets.all(getProportionateScreenWidth(10)),
              decoration: BoxDecoration(
                color: Color(0xFFF5F6F9),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Image.network(widget.image),
            ),
          ),
        ),
        SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.name,
              style: TextStyle(color: Colors.black, fontSize: 16),
              maxLines: 2,
            ),
            SizedBox(height: 10),
            // Text.rich(
            //   TextSpan(
            //     text: "\$${cart.product.price}",
            //     style: TextStyle(
            //         fontWeight: FontWeight.w600, color: kPrimaryColor),
            //     children: [
            //       TextSpan(
            //           text: " x${cart.numOfItem}",
            //           style: Theme.of(context).textTheme.bodyText1),
            //     ],
            //   ),
            // )
            Container(
              height: 40,
              child: Row(
                children: [
                  // ButtonTheme(
                  //   minWidth: 50,
                  //   child: OutlineButton.icon(
                  //     onPressed: () {},
                  //     icon: Icon(Icons.add),
                  //     label: Text('Add'),
                  //     padding: EdgeInsets.zero,
                  //     shape: RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.circular(20)),
                  //   ),
                  // ),
                  Container(
                    width: 70,
                    height: 70,
                    child: RaisedButton(
                      onPressed: () {
                        if (numOfItems > 1) {
                          setState(() {
                            numOfItems--;
                          });
                        }
                      },
                      color: Colors.deepOrange,
                      textColor: Colors.white,
                      shape: CircleBorder(side: BorderSide.none),
                      child: Icon(Icons.remove),
                    ),
                  ),
                  // FloatingActionButton(
                  //   heroTag: "btn1",
                  //   elevation: 2,
                  //   onPressed: () {},
                  //   child: Icon(Icons.add),
                  //   backgroundColor: kPrimaryColor,
                  // ),
                  Text(
                    numOfItems.toString(),
                    style: TextStyle(fontSize: 18),
                  ),
                  Container(
                    width: 70,
                    height: 70,
                    child: RaisedButton(
                      onPressed: () {
                        setState(() {
                          numOfItems++;
                          Provider.of<ProductData>(context).addProduct(
                            id: widget.id.toString(),
                            name: widget.name,
                            price: widget.price,
                            quantity: numOfItems,
                            // discount: widget.mydata['discount'],
                            image: widget.image,
                            sellingPrice: widget.price,
                          );

                          //                         id;
                          // final String name;
                          // final int price;
                          // final int quantity;
                          // final int amount;
                          // final String image;
                        });
                      },
                      color: kPrimaryColor,
                      textColor: Colors.white,
                      shape: CircleBorder(side: BorderSide.none),
                      child: Icon(Icons.add),
                    ),
                  ),
                  // FloatingActionButton(
                  //   heroTag: "btn2",
                  //   elevation: 2,
                  //   onPressed: () {},
                  //   child: Icon(
                  //     Icons.remove,
                  //   ),
                  //   backgroundColor: Colors.red,
                  // ),
                ],
              ),
            ),
          ],
        )
      ],
    );
  }
}
