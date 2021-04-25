import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:medicalpasal/userScreens/api/api.dart';
import 'package:medicalpasal/userScreens/bottomNavBar.dart';
import 'package:medicalpasal/userScreens/components/default_button.dart';
import 'package:medicalpasal/userScreens/components/form_error.dart';
import 'package:medicalpasal/userScreens/helper/keyboard.dart';
import 'package:medicalpasal/userScreens/screens/forgot_password/forgot_password_screen.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:medicalpasal/userScreens/components/custom_surfix_icon.dart';
import '../../../../constants.dart';
import 'package:get/get.dart';
import 'package:medicalpasal/driverScreens/bottomNavBar.dart';

class SignForm extends StatefulWidget {
  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  String onesignalUserId;
  void oneSignal() async {
    var status = await OneSignal.shared.getPermissionSubscriptionState();

    // the user's ID with OneSignal
    onesignalUserId = status.subscriptionStatus.userId;
    print('this is onesignal user id');
    print(onesignalUserId);
  }

  @override
  void initState() {
    super.initState();
    oneSignal();
    getuserDetails();
  }

  final _formKey = GlobalKey<FormState>();
  String email;
  String password;
  String error = '';
  bool remember = false;
// Initially password is obscure
  bool _obscureText1 = true;
  int user_type;
  void _toggle1() {
    setState(() {
      _obscureText1 = !_obscureText1;
    });
  }

  final List<String> errors = [];

  void addError({String error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  Future getuserDetails() async {
    var response = await Api().getData('user');
    var data = json.decode(response.body);
    user_type = data['user_type'];
    setState(() {});
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildEmailFormField(),
          SizedBox(height: 30),
          // SizedBox(height: getProportionateScreenHeight(30)),
          buildPasswordFormField(),
          // SizedBox(height: getProportionateScreenHeight(30)),
          SizedBox(height: 30),

          Row(
            children: [
              Checkbox(
                value: remember,
                activeColor: kPrimaryColor,
                onChanged: (value) {
                  setState(() {
                    remember = value;
                  });
                },
              ),
              Text("Remember me"),
              Spacer(),
              GestureDetector(
                onTap: () => Navigator.pushNamed(
                    context, ForgotPasswordScreen.routeName),
                child: Text(
                  "Forgot Password",
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              )
            ],
          ),
          FormError(errors: errors),
          // SizedBox(height: getProportionateScreenHeight(20)),
          SizedBox(height: 20),

          DefaultButton(
            text: "Login",
            press: () async {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                print(email);
                print(password);
                print(onesignalUserId);
                print(user_type.toString());

                Map data = {
                  'email': email,
                  'password': password,
                  'onesignal': onesignalUserId
                };

                // if all are valid then go to success screen
                KeyboardUtil.hideKeyboard(context);

                var response = await Api().loginRegister(data, 'login');

                var result = json.decode(response.body);
                print(result['code']);
                print(result['message']);
                // print(result['user_type']);
                // getuserDetails();
                if (result['code'] == 200) {
                  SharedPreferences preferences =
                      await SharedPreferences.getInstance();
                  preferences.setString('token', result['token']);
                  // getuserDetails();
                  print(user_type.toString());
                  print(result['token']);
                  print(result['code']);
                  print('Login Successful');
                  if (result['user']['user_type'] == 1) {
                    Navigator.popAndPushNamed(context, LandingPage.routeName);
                  } else if (result['user']['user_type'] == 2) {
                    Navigator.popAndPushNamed(
                        context, DriverLandingPage.routeName);
                  } else {
                    Get.snackbar(
                      "Sorry",
                      "You are not permitted to enter here!",
                      icon: Icon(Icons.account_circle),
                      shouldIconPulse: true,
                      barBlur: 20,
                      isDismissible: true,
                      duration: Duration(seconds: 3),
                    );
                  }
                } else {
                  error = result['message'];
                  setState(() {});
                  showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('error'),
                          content: Text(error.toString()),
                          actions: [
                            RaisedButton(
                              onPressed: () {
                                error = '';
                                setState(() {});
                                Navigator.pop(context);
                              },
                              child: Text('OK'),
                            )
                          ],
                        );
                      });
                }
              }
            },
          ),
        ],
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: _obscureText1,
      onSaved: (newValue) => password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.length >= 8) {
          removeError(error: kShortPassError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if (value.length < 8) {
          addError(error: kShortPassError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Password",
        hintText: "Enter your password",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: InkWell(
          child: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
          onTap: () {
            _toggle1();
          },
        ),
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        } else if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error: kInvalidEmailError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kEmailNullError);
          return "";
        } else if (!emailValidatorRegExp.hasMatch(value)) {
          addError(error: kInvalidEmailError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Email",
        hintText: "Enter your email",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
  }
}
