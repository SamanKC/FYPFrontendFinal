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
            Container(
              height: 40,
              child: Row(
                children: [
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
                            image: widget.image,
                            sellingPrice: widget.price,
                          );
                        });
                      },
                      color: kPrimaryColor,
                      textColor: Colors.white,
                      shape: CircleBorder(side: BorderSide.none),
                      child: Icon(Icons.add),
                    ),
                  ),
                ],
              ),
            ),
          ],
        )
      ],
    );
  }
}
