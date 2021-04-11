import 'package:flutter/material.dart';
import 'package:medicalpasal/constants.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton(
      {Key key,
      this.text,
      this.press,
      this.color = kPrimaryColor,
      this.borderColor = kPrimaryColor,
      this.textColor = Colors.white})
      : super(key: key);
  final String text;
  final Function press;
  final Color color;
  final Color borderColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      // height: getProportionateScreenHeight(56),
      child: FlatButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: borderColor),
        ),
        color: color,
        onPressed: press,
        child: Text(
          text,
          style: TextStyle(
            fontSize: 18,
            // fontSize: getProportionateScreenWidth(18),
            color: textColor,
          ),
        ),
      ),
    );
  }
}
