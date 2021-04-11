import 'package:flutter/material.dart';
import 'package:medicalpasal/driverScreens/components/drawerWidget.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'components/body.dart';

class Orders extends StatefulWidget {
  static String routeName = "/ordersdriver";

  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  String text = 'Hello';
  @override
  Widget build(BuildContext context) {
    // return Scaffold(drawer: DrawerWidget());
    return SafeArea(
      child: Scaffold(
        body: text == null
            ? CircularProgressIndicator()
            : Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  Container(
                    // margin: EdgeInsets.only(
                    //     bottom: _con.order.orderStatus.id == '5' ? 147 : 200),
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 8),
                            decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.9),
                              boxShadow: [
                                BoxShadow(
                                    color: Theme.of(context)
                                        .focusColor
                                        .withOpacity(0.1),
                                    blurRadius: 5,
                                    offset: Offset(0, 2)),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                // _con.order.orderStatus.id == '5'
                                // ? Container(
                                //     width: 60,
                                //     height: 60,
                                //     decoration: BoxDecoration(
                                //         shape: BoxShape.circle,
                                //         color:
                                //             Colors.green.withOpacity(0.2)),
                                //     child: Icon(
                                //       Icons.check_circle_outline,
                                //       color: Colors.green,
                                //       size: 32,
                                //     ),
                                //   )
                                Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Theme.of(context)
                                          .hintColor
                                          .withOpacity(0.1)),
                                  child: Icon(
                                    Icons.update,
                                    color: Theme.of(context)
                                        .hintColor
                                        .withOpacity(0.8),
                                    size: 30,
                                  ),
                                ),
                                SizedBox(width: 15),
                                Flexible(
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              // S.of(context).order_id +
                                              //     "#${_con.order.id}",
                                              "Helo",
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subhead,
                                            ),
                                            Text(
                                              // _con.order.payment?.method ??
                                              //     S
                                              //         .of(context)
                                              //         .cash_on_delivery,
                                              "Helo",
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .caption,
                                            ),
                                            Text(
                                              // DateFormat('yyyy-MM-dd HH:mm')
                                              //     .format(_con.order.dateTime),
                                              "2071",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .caption,
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(width: 8),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: <Widget>[
                                          // Helper.getPrice(_con.total,
                                          //     style: Theme.of(context)
                                          //         .textTheme
                                          //         .display1),
                                          // "Api",
                                          Text(
                                            // 'Items: ${_con.order.foodOrders.length}',
                                            'Items:}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .caption,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20, right: 10),
                            child: ListTile(
                              contentPadding: EdgeInsets.symmetric(vertical: 0),
                              leading: Icon(
                                Icons.person_pin,
                                color: Theme.of(context).hintColor,
                              ),
                              title: Text(
                                'Customer',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.display1,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                    // _con.order.user.name,
                                    "Name",
                                    style: Theme.of(context).textTheme.body2,
                                  ),
                                ),
                                SizedBox(width: 20),
                                SizedBox(
                                  width: 42,
                                  height: 42,
                                  child: FlatButton(
                                    padding: EdgeInsets.all(0),
                                    disabledColor: Theme.of(context)
                                        .focusColor
                                        .withOpacity(0.4),
                                    //onPressed: () {
//                                    Navigator.of(context).pushNamed('/Profile',
//                                        arguments: new RouteArgument(param: _con.order.deliveryAddress));
                                    //},
                                    child: Icon(
                                      Icons.person,
                                      color: Theme.of(context).primaryColor,
                                      size: 24,
                                    ),
                                    color: Theme.of(context)
                                        .accentColor
                                        .withOpacity(0.9),
                                    shape: StadiumBorder(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                    // _con.order.deliveryAddress?.address ??
                                    //     S
                                    //         .of(context)
                                    //         .address_not_provided_please_call_the_client,
                                    "Call",
                                    style: Theme.of(context).textTheme.body2,
                                  ),
                                ),
                                SizedBox(width: 20),
                                SizedBox(
                                  width: 42,
                                  height: 42,
                                  child: FlatButton(
                                    padding: EdgeInsets.all(0),
                                    disabledColor: Theme.of(context)
                                        .focusColor
                                        .withOpacity(0.4),
//                                      onPressed: () {
//                                        Navigator.of(context).pushNamed('/Map',
//                                            arguments: new RouteArgument(param: _con.order.deliveryAddress));
//                                      },
                                    child: Icon(
                                      Icons.directions,
                                      color: Theme.of(context).primaryColor,
                                      size: 24,
                                    ),
                                    color: Theme.of(context)
                                        .accentColor
                                        .withOpacity(0.9),
                                    shape: StadiumBorder(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                    // _con.order.user.phone,
                                    "Phone",
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context).textTheme.body2,
                                  ),
                                ),
                                SizedBox(width: 10),
                                SizedBox(
                                  width: 42,
                                  height: 42,
                                  child: FlatButton(
                                    padding: EdgeInsets.all(0),
                                    onPressed: () {
                                      // launch("tel:${_con.order.user.phone}");
                                    },
                                    child: Icon(
                                      Icons.call,
                                      color: Theme.of(context).primaryColor,
                                      size: 24,
                                    ),
                                    color: Theme.of(context)
                                        .accentColor
                                        .withOpacity(0.9),
                                    shape: StadiumBorder(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20, right: 10),
                            child: ListTile(
                              contentPadding: EdgeInsets.symmetric(vertical: 0),
                              leading: Icon(
                                Icons.fastfood,
                                color: Theme.of(context).hintColor,
                              ),
                              title: Text(
                                // S.of(context).foods_ordered,
                                "Ordered",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.display1,
                              ),
                            ),
                          ),
                          ListView.separated(
                            padding: EdgeInsets.only(bottom: 50),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            primary: false,
                            itemCount: 1,
                            separatorBuilder: (context, index) {
                              return SizedBox(height: 15);
                            },
                            itemBuilder: (context, index) {
                              // return OrderItemWidget(
                              //     heroTag: 'my_orders',
                              //     order: _con.order,
                              //     foodOrder:
                              //         _con.order.foodOrders.elementAt(index));
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: Container(
                      height: 230,
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20),
                              topLeft: Radius.circular(20)),
                          boxShadow: [
                            BoxShadow(
                                color: Theme.of(context)
                                    .focusColor
                                    .withOpacity(0.15),
                                offset: Offset(0, -2),
                                blurRadius: 5.0)
                          ]),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width - 40,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                      // S.of(context).subtotal,
                                      // style: Theme.of(context).textTheme.body2,
                                      "Total"),
                                ),
                                // Helper.getPrice(_con.subTotal,
                                //     style: Theme.of(context).textTheme.subhead)
                              ],
                            ),
                            SizedBox(height: 5),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                    "dsf",
                                    // "${S.of(context).tax} (${setting.defaultTax}%)",
                                    style: Theme.of(context).textTheme.body2,
                                  ),
                                ),
                                // Helper.getPrice(_con.taxAmount,
                                //     style: Theme.of(context).textTheme.subhead)
                              ],
                            ),
                            Divider(height: 30),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: Text("sf"
                                      // S.of(context).total,
                                      // style: Theme.of(context).textTheme.title,
                                      ),
                                ),
                                // Helper.getPrice(_con.total,
                                //     style: Theme.of(context).textTheme.title)
                              ],
                            ),
                            SizedBox(height: 20),
                            // _con.order.orderStatus.id != '5'
                            //     ? SizedBox(
                            //         width:
                            //             MediaQuery.of(context).size.width - 40,
                            //         child: FlatButton(
                            //           onPressed: () {
                            //             showDialog(
                            //                 context: context,
                            //                 builder: (context) {
                            //                   return AlertDialog(
                            //                     title: Text(S
                            //                         .of(context)
                            //                         .delivery_confirmation),
                            //                     content: Text(S
                            //                         .of(context)
                            //                         .would_you_please_confirm_if_you_have_delivered_all_meals),
                            //                     actions: <Widget>[
                            //                       // usually buttons at the bottom of the dialog
                            //                       FlatButton(
                            //                         child: new Text(
                            //                             S.of(context).confirm),
                            //                         onPressed: () {
                            //                           _con.doDeliveredOrder(
                            //                               _con.order);
                            //                           Navigator.of(context)
                            //                               .pop();
                            //                         },
                            //                       ),
                            //                       FlatButton(
                            //                         child: new Text(
                            //                             S.of(context).dismiss),
                            //                         onPressed: () {
                            //                           Navigator.of(context)
                            //                               .pop();
                            //                         },
                            //                       ),
                            //                     ],
                            //                   );
                            //                 });
                            //           },
                            //           padding:
                            //               EdgeInsets.symmetric(vertical: 14),
                            //           color: Theme.of(context).accentColor,
                            //           shape: StadiumBorder(),
                            //           child: Text(
                            //             S.of(context).delivered,
                            //             textAlign: TextAlign.start,
                            //             style: TextStyle(
                            //                 color:
                            //                     Theme.of(context).primaryColor),
                            //           ),
                            //         ),
                            //       )
                            //     : SizedBox(height: 0),
                            SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
      ),
    );
    // body: Body(),);
  }
}
