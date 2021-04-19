import 'package:flutter/material.dart';

import 'dart:convert';

import 'package:medicalpasal/userScreens/api/api.dart';
import 'package:medicalpasal/userScreens/screens/details/details_screen.dart';

import '../../../../constants.dart';

class SearchItem extends StatefulWidget {
  final query;

  SearchItem({this.query});
  @override
  _SearchItemState createState() => _SearchItemState();
}

class _SearchItemState extends State<SearchItem> {
  //Get Products data
  Future getProductsData(String query) async {
    var response = await Api().getData('searchProduct?name=$query');
    var data = json.decode(response.body);
    print(data);
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getProductsData(widget.query),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                var mydata = snapshot.data[index];
                return ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailsScreen(
                                  mydata: mydata,
                                )),
                      );
                      // this.query = mydata['name'].toString();
                      // showResults(context);
                    },
                    leading: CircleAvatar(
                      backgroundImage:
                          NetworkImage(apiLink + '/' + mydata['image']),
                    ),
                    // Image.network(mydata["featureImage"]),
                    title: Text(mydata['name'].toString()),
                    subtitle: Text("Rs. " + mydata['sp'].toString()));
              },
            );
          } else if (snapshot.hasError) {
            return Text('Error');
          } else {
            return Text('Loading');
          }
        },
      ),
    );
  }
}
