import 'package:flutter/material.dart';
import 'package:medicalpasal/size_config.dart';
import 'package:medicalpasal/userScreens/components/expandedDetailReviews.dart';

class ReviewsAll extends StatefulWidget {
  @override
  _ReviewsAllState createState() => _ReviewsAllState();
}

class _ReviewsAllState extends State<ReviewsAll> {
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
                        fontFamily: "Popins",
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
                            Text('8 Reviews')
                          ]),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: 20.0, right: 20.0, top: 15.0, bottom: 7.0),
                  child: _line(),
                ),
                ListTile(
                  leading: Container(
                    height: 45.0,
                    width: 45.0,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/images/userimage.png"),
                            fit: BoxFit.cover),
                        borderRadius: BorderRadius.all(Radius.circular(50.0))),
                  ),
                  title: Row(
                    children: <Widget>[
                      SizedBox(width: 8.0),
                      Text(
                        "01 Jan 2019",
                        style: TextStyle(fontSize: 12.0),
                      )
                    ],
                  ),
                  subtitle: ExpansionTileReview(
                    title: Text(
                      'Item delivered in good condition. I will recommend to other buyer',
                      style: TextStyle(
                          color: Colors.black54,
                          letterSpacing: 0.3,
                          wordSpacing: 0.5),
                    ),
                    children: [
                      SizedBox(height: 10.0),
                      Text(
                        "Very Recommended item i love it very love it",
                        style: TextStyle(
                            color: Colors.black54,
                            letterSpacing: 0.3,
                            wordSpacing: 0.5),
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        "Item delivered in good condition. I will recommend to other buyer.",
                        style: TextStyle(
                            color: Colors.black54,
                            letterSpacing: 0.3,
                            wordSpacing: 0.5),
                      ),
                    ],
//                              child: Text("Read More",style: _subHeaderCustomStyle.copyWith(fontSize: 13.0,color: Colors.blueAccent),
//                              textAlign: TextAlign.end,
//                              ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: 20.0, right: 20.0, top: 15.0, bottom: 7.0),
                  child: _line(),
                ),
                _buildReviews(
                    '18 Nov 2018',
                    'Item delivered in good condition. I will recommend to other buyer.',
                    (rating) {},
                    "assets/images/userimage.png"),
                Padding(
                  padding: EdgeInsets.only(
                      left: 20.0, right: 20.0, top: 15.0, bottom: 7.0),
                  child: _line(),
                ),
                _buildReviews(
                    '18 Nov 2018',
                    'Item delivered in good condition. I will recommend to other buyer.',
                    (rating) {},
                    "assets/images/userimage.png"),
                Padding(
                  padding: EdgeInsets.only(
                      left: 20.0, right: 20.0, top: 15.0, bottom: 7.0),
                  child: _line(),
                ),
                _buildReviews(
                    '18 Nov 2018',
                    'Item delivered in good condition. I will recommend to other buyer.',
                    (rating) {},
                    "assets/images/userimage.png"),
                Padding(
                  padding: EdgeInsets.only(
                      left: 20.0, right: 20.0, top: 15.0, bottom: 7.0),
                  child: _line(),
                ),
                _buildReviews(
                    '18 Nov 2018',
                    'Item delivered in good condition. I will recommend to other buyer.',
                    (rating) {},
                    "assets/images/userimage.png"),
                Padding(
                  padding: EdgeInsets.only(
                      left: 20.0, right: 20.0, top: 15.0, bottom: 7.0),
                  child: _line(),
                ),
                _buildReviews(
                    '18 Nov 2018',
                    'Item delivered in good condition. I will recommend to other buyer.',
                    (rating) {},
                    "assets/images/userimage.png"),
                SizedBox(
                  height: 10.0,
                ),
                _line(),
                Padding(padding: EdgeInsets.only(bottom: 40.0)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildReviews(
    String date, String details, Function changeRating, String image) {
  return ListTile(
    leading: Container(
      height: 45.0,
      width: 45.0,
      decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover),
          borderRadius: BorderRadius.all(Radius.circular(50.0))),
    ),
    title: Row(
      children: <Widget>[
        Text(
          date,
          style: TextStyle(fontSize: 12.0),
        )
      ],
    ),
    subtitle: Text(
      details,
      style: TextStyle(
          color: Colors.black54, letterSpacing: 0.3, wordSpacing: 0.5),
    ),
  );
}

Widget _line() {
  return Container(
    height: 0.9,
    width: double.infinity,
    color: Colors.black12,
  );
}
