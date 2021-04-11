import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:medicalpasal/userScreens/api/api.dart';

import '../../../../size_config.dart';


class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    //get healthtips data
    Future getHealthTips() async {
      try {
        var response = await Api().getData('healthtips');
        var health = json.decode(response.body)['data'];
        print(health);
        return health;
      } on SocketException {
        return null;
      }
    }

    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        child: FutureBuilder(
          future: getHealthTips(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  var mydata = snapshot.data[index];
                  return InkWell(
                      onTap: () {
                        print('tip pressed');
                      },
                      child: Card(
                        elevation: 2,
                        child: ListTile(
                          leading: Text(mydata['id'].toString()),
                          title: Text(mydata['name']),
                          subtitle: RichText(
                            overflow: TextOverflow.ellipsis,
                            strutStyle: StrutStyle(fontSize: 12.0),
                            text: TextSpan(
                                style: TextStyle(color: Colors.black),
                                text: mydata['description']),
                          ),
                        ),
                      ));
                },
              );
            } else if (snapshot.hasError) {
              return Text('Cannot load at this time');
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
