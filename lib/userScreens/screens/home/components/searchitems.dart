import 'package:flutter/material.dart';

import 'dart:convert';

import 'package:medicalpasal/userScreens/api/api.dart';

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
                return Text(mydata['name']);
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
