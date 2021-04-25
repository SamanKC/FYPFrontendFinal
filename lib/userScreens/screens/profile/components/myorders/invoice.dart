import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medicalpasal/driverScreens/screens/orders/components/emptyOrders.dart';

import 'package:medicalpasal/userScreens/api/api.dart';
import 'package:medicalpasal/userScreens/screens/profile/components/myorders/orderitem.dart';

import '../../../../../constants.dart';

class Invoice extends StatefulWidget {
  @override
  _InvoiceState createState() => _InvoiceState();
}

class _InvoiceState extends State<Invoice> {
  var refreshkey = GlobalKey<RefreshIndicatorState>();

  Future getInvoiceData() async {
    try {
      var response = await Api().getData('invoice');
      var invoice = json.decode(response.body)['data'];
      print(invoice);
      return invoice;
    } on SocketException {
      return null;
    }
  }

  Future getInvoiceDetails(int id) async {
    try {
      var response = await Api().getData('invoicedetails/$id');
      var invoice = json.decode(response.body)['data'];
      print(invoice);
      // var data = json.decode(invoice);

      return invoice;
    } on SocketException {
      return null;
    }
  }

  @override
  void initState() {
    super.initState();
    refreshlist();
  }

  Future<Null> refreshlist() async {
    refreshkey.currentState?.show(
        atTop:
            true); // change atTop to false to show progress indicator at bottom

    await Future.delayed(Duration(seconds: 2)); //wait here for 2 second

    setState(() {
      getInvoiceData();
    });
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: Text(
          'My Orders',
        ),
      ),
      body: RefreshIndicator(
        key: refreshkey,
        child: ListView(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          // physics: AlwaysScrollableScrollPhysics(),
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                FutureBuilder(
                  future: getInvoiceData(),
                  initialData: [],
                  builder: (context, snapshot) {
                    if (snapshot.data.isEmpty) {
                      return EmptyOrders();
                    }
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                        break;
                      default:
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            ListView.builder(
                              // physics: const AlwaysScrollableScrollPhysics(),
                              physics: NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              primary: false,
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, index) {
                                var mydata = snapshot.data[index];

                                return Card(
                                  shadowColor: kPrimaryColor,
                                  elevation: 5,
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20, right: 10),
                                        child: ListTile(
                                          contentPadding:
                                              EdgeInsets.symmetric(vertical: 0),
                                          leading: Icon(
                                            Icons.person_pin,
                                            // color: Theme.of(context).hintColor,
                                          ),
                                          // isThreeLine: true,
                                          title: Text(
                                            'Invoice ID: #' +
                                                mydata['invoice_id'].toString(),
                                          ),
                                          subtitle: Text('Address: ' +
                                              mydata['city'] +
                                              ', ' +
                                              mydata['area'] +
                                              ', ' +
                                              mydata['ward'] +
                                              ', ' +
                                              mydata['address']),
                                          // trailing: Icon(Icons.arrow_forward),
                                        ),
                                      ),
                                      // Text(
                                      //   'Invoice ID: #' +
                                      //       mydata['invoice_id'].toString(),
                                      // ),
                                      Divider(),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: FutureBuilder(
                                          future: getInvoiceDetails(
                                              mydata['invoice_id']),
                                          // initialData: InitialData,
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              return ListView.builder(
                                                physics:
                                                    NeverScrollableScrollPhysics(),
                                                shrinkWrap: true,
                                                itemCount: snapshot.data.length,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  var data =
                                                      snapshot.data[index];
                                                  return Card(
                                                    child: OrderItemWidget(
                                                      id: data['invoice_id'],
                                                      productname:
                                                          data['product_name'],
                                                      productquantity:
                                                          data['quantity'],
                                                      sp: data['price'],
                                                      productimage:
                                                          data['product_image'],
                                                      createdat:
                                                          data['created_at'],
                                                    ),
                                                  );
                                                },
                                              );
                                            } else if (snapshot.hasError) {
                                              return Text(
                                                  'Cannot load at this time');
                                            } else {
                                              return Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              );
                                            }
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ],
                        );
                    }
                  },
                ),
              ],
            ),
          ],
        ),
        onRefresh: refreshlist,
      ),
    );
  }
}
