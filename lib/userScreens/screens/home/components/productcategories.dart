import 'dart:convert';
import 'dart:io';
import 'package:medicalpasal/size_config.dart';
import 'package:flutter/material.dart';
import 'package:medicalpasal/userScreens/api/api.dart';
import 'itemgrid.dart';

class ProductsCategories extends StatelessWidget {
  final catid;

  const ProductsCategories({Key key, this.catid}) : super(key: key);
  Future getProductData() async {
    try {
      var response = await Api().getData('categories/$catid');
      var category = json.decode(response.body)['data'];
      print('........................................');
      print(category);
      return category;
    } on SocketException {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FutureBuilder(
              future: getProductData(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                    break;
                  default:
                    return GridView.count(
                      shrinkWrap: true,

                      // crossAxisSpacing: 10.0,
                      // mainAxisSpacing: 17.0,
                      childAspectRatio: 0.605,
                      crossAxisCount: 2,
                      primary: false,
                      children: List.generate(
                        snapshot.data.length,
                        (index) {
                          var mydata = snapshot.data[index];

                          return ItemGrid(mydata: mydata);
                        },
                      ),
                    );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
