import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../size_config.dart';


class SocalCard extends StatelessWidget {
  final String icon;
  final Function press;
  final Color buttonColor;

  final Color borderColor;
  final Color textColor;

  final String buttonName;
  final Color color;

  const SocalCard(
      {Key key,
      @required this.icon,
      @required this.press,
      @required this.buttonColor,
      @required this.borderColor,
      @required this.textColor,
      this.color,
      this.buttonName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: FlatButton(
        color: buttonColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
          side: BorderSide(color: borderColor),
        ),
        onPressed: press,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              icon,
              color: color,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              buttonName,
              style: TextStyle(color: textColor),
            ),
          ],
        ),
      ),
    );
  }
}
// Expanded(
//         child: Container(
//           height: 50,
//           padding:  EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
//           child: FlatButton(

//             decoration: BoxDecoration(
//           color: Color(0xFFF5F6F9),
//           shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(25),
//               side: BorderSide(color: borderColor),
//             ),
//         ),
//             onPressed: onPressed,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 SvgPicture.asset(icon),
//                 SizedBox(
//                   width: 10,
//                 ),
//                 Text(
//                   buttonName,
//                   style: TextStyle(color: textColor),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
