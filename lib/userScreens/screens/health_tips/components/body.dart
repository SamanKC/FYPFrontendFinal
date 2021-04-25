import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:medicalpasal/userScreens/api/api.dart';
import 'package:medicalpasal/constants.dart';
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
                  return Card(
                    elevation: 2,
                    child: Column(
                      children: [
                        ListTile(
                          leading: Text(
                            mydata['id'].toString(),
                            style: TextStyle(color: Colors.white),
                          ),
                          title: Text(mydata['name'],
                              style: TextStyle(color: Colors.white),
                              textAlign: TextAlign.justify),
                          tileColor: kPrimaryColor,
                        ),
                        Container(
                          padding: EdgeInsets.all(12),
                          color: Colors.black12,
                          child: Text(mydata['description'],
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              ),
                              textAlign: TextAlign.justify),
                        ),
                      ],
                    ),
                  );
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
