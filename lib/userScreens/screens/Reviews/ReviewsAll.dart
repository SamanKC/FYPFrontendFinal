import 'package:flutter/material.dart';
import 'package:medicalpasal/size_config.dart';
import 'package:medicalpasal/constants.dart';
import 'package:medicalpasal/userScreens/api/api.dart';
import 'dart:convert';
import 'dart:io';

class ReviewsAll extends StatefulWidget {
  final product;

  const ReviewsAll({Key key, this.product}) : super(key: key);
  @override
  _ReviewsAllState createState() => _ReviewsAllState();
}

class _ReviewsAllState extends State<ReviewsAll> {
  int reviewCount;
  Future getReview() async {
    try {
      var response = await Api().getData("review/${widget.product['id']}");
      var reviews = json.decode(response.body)['data'];
      print(reviews);
      return reviews;
    } on SocketException {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Reviews"),
        centerTitle: true,
        leading: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.black87,
            )),
        elevation: 0.0,
      ),
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, left: 20.0),
                  child: Text(
                    "Reviews",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5.0, left: 20.0),
                  child: Row(
                    children: <Widget>[
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(width: 5.0),
                            Text(widget.product['reviewCount'].toString())
                          ]),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: 20.0, right: 20.0, top: 15.0, bottom: 7.0),
                  child: _line(),
                ),
                FutureBuilder(
                  future: getReview(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            var mydata = snapshot.data[index];
                            return ListTile(
                              leading: Container(
                                height: 45.0,
                                width: 45.0,
                                decoration: BoxDecoration(
                                  image: mydata['image'] == null
                                      ? DecorationImage(
                                          image: AssetImage(
                                              'assets/images/userimage.png'),
                                          fit: BoxFit.cover)
                                      : DecorationImage(
                                          image: NetworkImage(apiLink +
                                              '/profileImage/' +
                                              mydata['image']),
                                          fit: BoxFit.cover),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(50.0),
                                  ),
                                ),
                              ),
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(mydata['name']),
                                  Text(
                                    mydata['review_date'],
                                    style: TextStyle(fontSize: 12.0),
                                  )
                                ],
                              ),
                              subtitle: Text(
                                mydata['comment'],
                                style: detailText,
                              ),
                            );
                          });
                    } else {
                      return LinearProgressIndicator();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget _line() {
  return Container(
    height: 0.9,
    width: double.infinity,
    color: Colors.black12,
  );
}
