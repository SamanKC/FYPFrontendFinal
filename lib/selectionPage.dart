import 'package:flutter/material.dart';

import 'constants.dart';
import 'size_config.dart';
import 'userScreens/components/default_button.dart';
import 'userScreens/screens/home/home_screen.dart';
import 'userScreens/screens/sign_in/sign_in_screen.dart';
import 'userScreens/screens/sign_up/sign_up_screen.dart';

class SelectionPage extends StatelessWidget {
  static String routeName = "/selection";

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Image: kAppLogo is the image asset in the constants folder
            Container(
              child: kAppLogo,
              // height: 250,
              height: MediaQuery.of(context).size.height / 2.5,
              // height: getProportionateScreenWidth(250),
              // width: getProportionateScreenHeight(20),
              // width: 300,
              width: MediaQuery.of(context).size.height / 3,
            ),
            Container(
              height: MediaQuery.of(context).size.height / 4,
              width: MediaQuery.of(context).size.height / 3,
              child: Text(
                '"𝑷𝒓𝒐𝒗𝒊𝒔𝒊𝒐𝒏 𝒂𝒔 𝒎𝒖𝒄𝒉 𝒑𝒖𝒓𝒆 𝒂𝒏𝒅 𝒐𝒓𝒈𝒂𝒏𝒊𝒄 𝒇𝒐𝒐𝒅 𝒂𝒔 𝒚𝒐𝒖 𝒄𝒂𝒏, 𝒂𝒏𝒅 𝒍𝒆𝒕 𝒕𝒉𝒆 𝒓𝒆𝒔𝒕 𝒈𝒐 𝒃𝒚."',
                style: TextStyle(
                  color: kPrimaryColor,
                  fontFamily: 'OpenSans',
                  fontSize: 18,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              // horizontal: getProportionateScreenWidth(20)),
              child: DefaultButton(
                text: "Login",
                color: kPrimaryColor,
                borderColor: kPrimaryColor,
                press: () {
                  Navigator.pushNamed(context, SignInScreen.routeName);
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              // horizontal: getProportionateScreenWidth(20)),
              child: DefaultButton(
                text: "SignUp",
                textColor: kPrimaryColor,
                color: Colors.transparent,
                borderColor: kPrimaryColor,
                press: () {
                  Navigator.pushNamed(context, SignUpScreen.routeName);
                },
              ),
            ),
            SizedBox(
              height: getProportionateScreenHeight(100),
            ),
            // GestureDetector(
            //   onTap: () => Navigator.pushNamed(context, HomeScreen.routeName),
            //   child: Text(
            //     "Sales Login",
            //     style: TextStyle(
            //         fontSize: getProportionateScreenWidth(16),
            //         color: kPrimaryColor),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
