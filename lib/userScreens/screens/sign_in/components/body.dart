import 'package:flutter/material.dart';

import '../../../../constants.dart';
import '../../../../size_config.dart';
import 'sign_form.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          // padding: EdgeInsets.symmetric(horizontal: 20),
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: SizeConfig.screenHeight * 0.04),
                // SizedBox(height: 100),
                Text(
                  "Login",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: getProportionateScreenWidth(34),
                    // fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Add your details to login",
                  textAlign: TextAlign.center,
                ),
                // SizedBox(height: 200),
                SizedBox(height: SizeConfig.screenHeight * 0.08),
                SignForm(),

                SizedBox(height: 20),
                // SizedBox(height: getProportionateScreenHeight(20)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
