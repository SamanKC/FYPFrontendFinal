import 'package:flutter/material.dart';
import 'package:medicalpasal/userScreens/components/no_account_text.dart';


import 'components/body.dart';

class SignInScreen extends StatelessWidget {
  static String routeName = "/sign_in";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title: Text("Sign In"),
      ),
      body: Body(),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 28.0),
        child: NoAccountText(),
      ),
    );
  }
}
