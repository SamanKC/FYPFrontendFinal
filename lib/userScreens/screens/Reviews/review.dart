// import 'package:flutter/material.dart';
// import 'package:medicalpasal/userScreens/api/api.dart';
// import 'package:medicalpasal/constants.dart';
// import 'dart:convert';
// import 'dart:io';

// Widget review(product) {
//   Future getReview() async {
//     try {
//       var response = await Api().getData("review/${product['id']}");
//       var reviews = json.decode(response.body)['data'];
//       print(reviews);
//       return reviews;
//     } on SocketException {
//       return null;
//     }
//   }

//   return FutureBuilder(
//       future: getReview(),
//       initialData: [],
//       builder: (context, snapshot) {
//         switch (snapshot.connectionState) {
//           case ConnectionState.waiting:
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//             break;
//           default:
//             return ListView.builder(
//                 shrinkWrap: true,
//                 physics: NeverScrollableScrollPhysics(),
//                 itemCount: snapshot.data.length,
//                 itemBuilder: (BuildContext context, int index) {
//                   var mydata = snapshot.data[index];
//                   return ListTile(
//                     leading: Container(
//                       height: 45.0,
//                       width: 45.0,
//                       decoration: BoxDecoration(
//                           image: DecorationImage(
//                               image: NetworkImage(apiLink + mydata['image']),
//                               fit: BoxFit.cover),
//                           borderRadius:
//                               BorderRadius.all(Radius.circular(50.0))),
//                     ),
//                     title: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: <Widget>[
//                         Text(mydata['name']),
//                         Text(
//                           mydata['review_date'],
//                           style: TextStyle(fontSize: 12.0),
//                         )
//                       ],
//                     ),
//                     subtitle: Text(
//                       mydata['comment'],
//                       style: detailText,
//                     ),
//                   );
//                 });
//         }
//       });
// }
