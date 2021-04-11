// import 'package:flutter/material.dart';
//
// import 'package:medicalpasal/models/searchModel.dart';
// import '../../../constants.dart';
// import 'icon_btn_with_counter.dart';
//
// // Future searchData(String query) async {
// //   var response = await Api().getData('searchProduct?name=$query');
// //   var data = json.decode(response.body);
// //   print(data);
// //   return data;
// // }
//
// class HomeHeader extends StatelessWidget {
//   const HomeHeader({
//     Key key,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     //Get search data
//
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 20),
//       // EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Container(
//             child: kAppLogo,
//             //  height: getProportionateScreenWidth(46),
//             width: 130,
//             // width: getProportionateScreenWidth(130),
//           ),
//           Container(
//             child: Row(
//               children: [
//                 IconBtnWithCounter(
//                   svgSrc: "assets/icons/Search Icon.svg",
//                   press: () {
//                     showSearch(context: context, delegate: DataSearch());
//                   },
//                 ),
//                 SizedBox(
//                   width: 10,
//                   // width: getProportionateScreenWidth(10),
//                 ),
//                 IconBtnWithCounter(
//                   svgSrc: "assets/icons/Cart Icon.svg",
//                   numOfitem: 3,
//                   // press: () =>
//                   //     Navigator.pushNamed(context, CartScreen.routeName),
//                   press: () {},
//                 ),
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
