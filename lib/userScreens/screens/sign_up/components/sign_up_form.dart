import 'package:flutter/material.dart';
import 'package:medicalpasal/userScreens/api/api.dart';
import 'package:medicalpasal/userScreens/components/default_button.dart';
import 'package:medicalpasal/userScreens/components/form_error.dart';
import 'package:medicalpasal/userScreens/helper/keyboard.dart';
import 'package:medicalpasal/userScreens/onboard/onBoardingScreen.dart';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:medicalpasal/userScreens/components/custom_surfix_icon.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../constants.dart';
import '../../../../size_config.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  String name;
  String email;
  String phone;
  String city;
  String area;
  String ward;
  String address;
  String password;
  String confirmPassword;
  String error = '';
  bool remember = false;
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

  // Initially password is obscure
  bool _obscureText1 = true;
  bool _obscureText = true;

  void _toggle1() {
    setState(() {
      _obscureText1 = !_obscureText1;
    });
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildNameFormField(),
          // SizedBox(height: 30),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildEmailFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          // SizedBox(height: 30),

          buildPhoneFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          // SizedBox(height: 30),

          buildCityFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),

          buildWardFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),

          buildAreaFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),

          buildAddressFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),

          buildPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          // SizedBox(height: 30),

          buildConfirmPassFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),

          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(40)),
          // SizedBox(height: 30),

          DefaultButton(
            text: "SignUp",
            press: () async {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                print(email);
                print(password);
                Map data = {
                  'name': name,
                  'email': email,
                  'phone': phone,
                  'city': city,
                  'ward': ward,
                  'area': area,
                  'address': address,
                  'password': password,
                };

                // if all are valid then go to success screen
                KeyboardUtil.hideKeyboard(context);

                var response = await Api().registerUser(data, 'register');

                var result = json.decode(response.body);
                print(result['code']);
                print(result['message']);

                if (result['code'] == 200) {
                  // SharedPreferences preferences =
                  //     await SharedPreferences.getInstance();
                  // preferences.setString('token', result['token']);
                  Navigator.popAndPushNamed(context, OnBoarding.routeName);
                  Get.snackbar(
                    "Success",
                    "User Registered Successfully",
                    icon: Icon(Icons.account_circle),
                    shouldIconPulse: true,
                    barBlur: 20,
                    isDismissible: true,
                    duration: Duration(seconds: 3),
                  );
                } else {
                  error = result['message'];
                  setState(() {});
                  showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Error'),
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

  TextFormField buildConfirmPassFormField() {
    return TextFormField(
      obscureText: _obscureText1,
      onSaved: (newValue) => confirmPassword = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.isNotEmpty && password == confirmPassword) {
          removeError(error: kMatchPassError);
        }
        confirmPassword = value;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if ((password != value)) {
          addError(error: kMatchPassError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Confirm Password",
        hintText: "Re-enter your password",
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

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: _obscureText,
      onSaved: (newValue) => password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.length >= 8) {
          removeError(error: kShortPassError);
        }
        password = value;
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
            _toggle();
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

  TextFormField buildNameFormField() {
    return TextFormField(
      // keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => name = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kNameNullError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kNameNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Name",
        hintText: "Enter your Name",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }

  TextFormField buildPhoneFormField() {
    return TextFormField(
      keyboardType: TextInputType.phone,
      onSaved: (newValue) => phone = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPhoneNumberNullError);
        } else if (phoneValidatorRegExp.hasMatch(value)) {
          removeError(error: kInvalidPhoneNumberNullError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kPhoneNumberNullError);
          return "";
        } else if (!phoneValidatorRegExp.hasMatch(value)) {
          addError(error: kInvalidPhoneNumberNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Phone Number",
        hintText: "Enter your mobile number",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Phone.svg"),
      ),
    );
  }

  TextFormField buildCityFormField() {
    return TextFormField(
      // keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => city = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kCityNullError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kCityNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "City",
        hintText: "Enter your City",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/location.svg"),
      ),
    );
  }

  TextFormField buildAreaFormField() {
    return TextFormField(
      // keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => area = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kAreaNullError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kAreaNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Area",
        hintText: "Enter your Area",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/location.svg"),
      ),
    );
  }

  TextFormField buildWardFormField() {
    return TextFormField(
      // keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => ward = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kWardNullError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kWardNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Ward",
        hintText: "Enter your Ward",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/location.svg"),
      ),
    );
  }

  TextFormField buildAddressFormField() {
    return TextFormField(
      // keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => address = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kAddressNullError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kAddressNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Address",
        hintText: "Enter your Address",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/location.svg"),
      ),
    );
  }
}
