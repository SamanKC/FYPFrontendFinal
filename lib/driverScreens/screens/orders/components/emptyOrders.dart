import 'package:flutter/material.dart';

import '../../../../size_config.dart';

class EmptyOrders extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 100,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 3,
            child: Image.asset(
              'assets/imgIllustration/IlustrasiCart.png',
              height: 300.0,
            ),
          ),
          SizedBox(
            height: 1,
          ),
          Text(
            "You have no Orders!!",
          )
        ],
      ),
    );
  }
}
