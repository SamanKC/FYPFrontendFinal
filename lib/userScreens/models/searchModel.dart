import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:medicalpasal/userScreens/api/api.dart';
import 'package:medicalpasal/userScreens/screens/home/components/searchitems.dart';

import '../../constants.dart';

class DataSearch extends SearchDelegate<String> {
  //Get Products data
  Future getProductsData(String query) async {
    var response = await Api().getData('searchProduct?name=$query');
    var data = json.decode(response.body);
    print(data);
    return data;
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Scaffold(
      body: SearchItem(query: query),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
          future: getProductsData(query),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data.length,
                itemBuilder: (context, int index) {
                  var mydata = snapshot.data[index];
                  TextField(
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter a search term'),
                  );
                  return ListTile(
                    onTap: () {
                      // Navigator.push(context,
                      //     MaterialPageRoute(builder: (context) => ItemCard()));
                      this.query = mydata['name'];
                      showResults(context);
                    },
                    // leading: Icon(
                    //   Icons.settings_system_daydream,

                    //   color: Colors.black,
                    // ),
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                          apiLink + '/' + snapshot.data[index]['image']),
                    ),
                    title: Text(mydata['name'],
                        style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w500)),
                    trailing: Icon(Icons.arrow_forward),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text('Error');
            } else {
              return Text('Loading');
            }
          },
        ),
      ),
    );
  }
}
