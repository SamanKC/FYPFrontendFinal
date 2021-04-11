import 'package:flutter/material.dart';
import 'package:medicalpasal/constants.dart';
import 'package:medicalpasal/size_config.dart';

import 'sign_up_form.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                // SizedBox(height: 100), // 4%
                SizedBox(height: SizeConfig.screenHeight * 0.04), // 4%
                Text("Sign Up", style: headingStyle),
                Text(
                  "Add your details to signup",
                  textAlign: TextAlign.center,
                ),
                // SizedBox(height: 200),
                SizedBox(height: SizeConfig.screenHeight * 0.04),
                SignUpForm(),



                SizedBox(height: SizeConfig.screenHeight * 0.02),

                Text(
                  'By continuing your confirm that you agree \nwith our Term and Condition',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.caption,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
