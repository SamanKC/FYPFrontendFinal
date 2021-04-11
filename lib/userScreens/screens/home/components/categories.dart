import 'dart:convert';
import 'dart:io';
import 'package:medicalpasal/userScreens/screens/home/components/productcategories.dart';
import 'package:flutter/material.dart';
import 'package:medicalpasal/userScreens/api/api.dart';

class Categories extends StatelessWidget {
  Future getCategoryData() async {
    try {
      var response = await Api().getData('categories');
      var category = json.decode(response.body)['data'];
      print(category);
      return category;
    } on SocketException {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FutureBuilder(
            future: getCategoryData(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...List.generate(snapshot.data.length, (index) {
                      var mydata = snapshot.data[index];

                      return Padding(
                        padding: const EdgeInsets.only(
                            top: 20.0, left: 10.0, bottom: 10.0, right: 0.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  // builder: (context) => ProductDetailScreen(
                                  //       product: mydata,
                                  //     )),
                                  builder: (context) => ProductsCategories(
                                        catid: mydata['id'].toString(),
                                      )),
                            );
                            print('category pressed');
                          },
                          child: Container(
                            width: 100,
                            // width: getProportionateScreenWidth(100),
                            // height: getProportionateScreenHeight(70),
                            child: Column(
                              children: [
                                Card(
                                  elevation: 2,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  child: Image.network(
                                    mydata['image'],
                                    fit: BoxFit.fill,
                                    height: 80,
                                    // height: getProportionateScreenHeight(80),
                                  ),
                                ),
                                Text(
                                  mydata['name'],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                        // if (mydata[index].isPopular)

                        // return SizedBox
                        //     .shrink(); // here by default width and height is 0
                        // return ProductCard(product: mydata);
                        // return Column(
                        //   children: [Text(snapshot.data[index]['name'])],
                        // );5
                        // return Text(mydata.length.toString());

                        ),
                    SizedBox(width: 20),
                    // SizedBox(width: getProportionateScreenWidth(20)),
                  ],
                );
                // return Text(mydata.length.toString());
                // return Text(snapshot.data[0]['discount'].toString());
                // return ListView.builder(
                //   physics: NeverScrollableScrollPhysics(),
                //   shrinkWrap: true,
                //   itemCount: snapshot.data.length,
                //   itemBuilder: (context, index) {
                //     var mydata = snapshot.data[index];
                //     return Text(mydata['discount'].toString());
                //   },
                // );
              } else if (snapshot.hasError) {
                return Text('Cannot load at this time');
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
