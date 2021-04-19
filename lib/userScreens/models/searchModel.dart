import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:medicalpasal/userScreens/api/api.dart';
import 'package:medicalpasal/userScreens/screens/details/details_screen.dart';
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
              return snapshot.data.length == 0
                  ? _fileNotFound(context)
                  : ListView.builder(
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
                            // showResults(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  // builder: (context) => ProductDetailScreen(
                                  //       product: mydata,
                                  //     )),
                                  builder: (context) => DetailsScreen(
                                        mydata: mydata,
                                      )),
                            );
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
                                  fontSize: 15, fontWeight: FontWeight.w500)),
                          // trailing: Icon(Icons.arrow_forward),
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

Widget _fileNotFound(BuildContext context) {
  MediaQueryData mediaQueryData = MediaQuery.of(context);

  return Container(
    width: 500.0,
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
              padding:
                  EdgeInsets.only(top: mediaQueryData.padding.top + 100.0)),
          Image.asset(
            "assets/imgIllustration/IlustrasiCart.png",
            height: 200.0,
          ),
          Padding(padding: EdgeInsets.only(bottom: 30.0)),
          Text(
            "Searched product not found",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 18.5,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    ),
  );
}
