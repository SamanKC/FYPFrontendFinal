import 'package:flutter/material.dart';
import 'package:medicalpasal/userScreens/components/no_account_text.dart';

import 'components/body.dart';

class SignUpScreen extends StatelessWidget {
  static String routeName = "/sign_up";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up"),
      ),
      body: Body(),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 28.0),
        child: AlreadyAccount(),
      ),
    );
  }
}
