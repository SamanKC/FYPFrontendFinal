import 'package:flutter/material.dart';


class IconBtnWithCounter extends StatelessWidget {
  const IconBtnWithCounter({
    Key key,
    @required this.icon,
    this.numOfitem = 0,
    @required this.press,
  }) : super(key: key);

  final IconData icon;
  final int numOfitem;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(100),
      onTap: press,
      child: Stack(
        overflow: Overflow.visible,
        children: [
          Container(
            padding: EdgeInsets.all(12),
            // padding: EdgeInsets.all(getProportionateScreenWidth(12)),
            height: 46,
            // height: getProportionateScreenWidth(46),
            width: 46,
            // width: getProportionateScreenWidth(46),
            // decoration: BoxDecoration(
            //   color: kSecondaryColor.withOpacity(0.1),
            //   shape: BoxShape.circle,
            // ),
            child: Icon(icon),
          ),
          if (numOfitem != 0)
            Positioned(
              top: -3,
              right: 0,
              child: Container(
                height: 16,
                // height: getProportionateScreenWidth(16),
                width: 16,
                // width: getProportionateScreenWidth(16),
                decoration: BoxDecoration(
                  color: Color(0xFFFF4848),
                  shape: BoxShape.circle,
                  border: Border.all(width: 1.5, color: Colors.white),
                ),
                child: Center(
                  child: Text(
                    "$numOfitem",
                    style: TextStyle(
                      fontSize: 10,
                      // fontSize: getProportionateScreenWidth(10),
                      height: 1,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}
