// import 'package:flutter/material.dart';
// import 'package:medicalpasal/userScreens/screens/cart/cart_screen.dart';
// import 'package:medicalpasal/userScreens/screens/health_tips/healthtips.dart';
// import 'package:medicalpasal/userScreens/screens/home/home_screen.dart';
// import 'package:medicalpasal/userScreens/screens/profile/profile_screen.dart';

// import '../../constants.dart';
// import '../../enums.dart';

// class CustomBottomNavBar extends StatelessWidget {
//   const CustomBottomNavBar({
//     Key key,
//     @required this.selectedMenu,
//   }) : super(key: key);

//   final MenuState selectedMenu;

//   @override
//   Widget build(BuildContext context) {
//     final Color inActiveIconColor = Color(0xFFB6B6B6);
//     return Container(
//       padding: EdgeInsets.symmetric(vertical: 14),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         boxShadow: [
//           BoxShadow(
//             offset: Offset(0, -15),
//             blurRadius: 20,
//             color: Color(0xFFDADADA).withOpacity(0.15),
//           ),
//         ],
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(40),
//           topRight: Radius.circular(40),
//         ),
//       ),
//       child: SafeArea(
//           top: false,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               IconButton(
//                 // icon: SvgPicture.asset(
//                 //   "assets/icons/Shop Icon.svg",
//                 //   color: MenuState.home == selectedMenu
//                 //       ? kPrimaryColor
//                 //       : inActiveIconColor,
//                 // ),
//                 icon: Icon(
//                   Icons.dashboard_outlined,
//                   color: MenuState.home == selectedMenu
//                       ? kPrimaryColor
//                       : inActiveIconColor,
//                 ),
//                 onPressed: () =>
//                     Navigator.pushNamed(context, HomeScreen.routeName),
//               ),
//               IconButton(
//                 // icon: SvgPicture.asset("assets/icons/Heart Icon.svg"),
//                 icon: Icon(
//                   Icons.library_books_outlined,
//                   color: MenuState.home == selectedMenu
//                       ? kPrimaryColor
//                       : inActiveIconColor,
//                 ),
//                 onPressed: () =>
//                     Navigator.pushNamed(context, HealthTips.routeName),
//               ),
//               IconButton(
//                 // icon: SvgPicture.asset(
//                 //   "assets/icons/Conversation.svg",
//                 //   color: MenuState.healthtips == selectedMenu
//                 //       ? kPrimaryColor
//                 //       : inActiveIconColor,
//                 // ),
//                 // icon: FaIcon(FontAwesomeIcons.bookMedical),
//                 icon: Icon(
//                   Icons.add_shopping_cart_rounded,
//                   color: MenuState.home == selectedMenu
//                       ? kPrimaryColor
//                       : inActiveIconColor,
//                 ),

//                 onPressed: () {
//                   Navigator.pushNamed(context, CartScreen.routeName);
//                 },
//               ),
//               IconButton(
//                 // icon: SvgPicture.asset(
//                 //   "assets/icons/User Icon.svg",
//                 //   color: MenuState.profile == selectedMenu
//                 //       ? kPrimaryColor
//                 //       : inActiveIconColor,
//                 // ),
//                 icon: Icon(
//                   Icons.settings_applications_outlined,
//                   color: MenuState.home == selectedMenu
//                       ? kPrimaryColor
//                       : inActiveIconColor,
//                 ),
//                 onPressed: () =>
//                     Navigator.pushNamed(context, ProfileScreen.routeName),
//               ),
//             ],
//           )),
//     );
//   }
// }
