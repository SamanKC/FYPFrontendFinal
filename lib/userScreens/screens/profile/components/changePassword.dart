import 'package:flutter/material.dart';
import 'package:medicalpasal/userScreens/components/default_button.dart';
import 'package:medicalpasal/userScreens/helper/keyboard.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:medicalpasal/userScreens/api/api.dart';
import 'package:get/get.dart';
import 'package:medicalpasal/userScreens/screens/sign_in/sign_in_screen.dart';

import 'package:medicalpasal/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  // Form
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  final TextEditingController _currentPass = TextEditingController();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();
  int customerId;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getuserDetails();
  }

  // Initially password is obscure
  bool _obscureText = true;
  bool _obscureText1 = true;
  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _toggle1() {
    setState(() {
      _obscureText1 = !_obscureText1;
    });
  }

  Future getuserDetails() async {
    var response = await Api().getData('user');
    var data = json.decode(response.body);
    setState(() {
      customerId = data['id'];
      isLoading = false;
    });
  }

  Future save(int id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String token = preferences.getString('token');
    final uri = Uri.parse(apiLink + '/api/profile/$id?_method=PUT');

    MultipartRequest request = http.MultipartRequest('post', uri);

    request.headers['Accept'] = 'application/json';
    request.headers['Authorization'] = 'Bearer ' + token;
    request.fields['current_password'] = _currentPass.text;
    request.fields['new_password'] = _pass.text;
    // request.fields['confirm_password'] = _confirmPass.text;
    // request.fields['price'] = _confirmPass.text;
    var response = await request.send();
    print(response.statusCode);
    // print(response);

    if (response.statusCode == 200) {
      Get.snackbar(
        "Success",
        "Password Changed Successfully",
        icon: Icon(Icons.account_circle),
        shouldIconPulse: true,
        barBlur: 20,
        isDismissible: true,
        duration: Duration(seconds: 3),
      );
    } else {
      Get.snackbar(
        "Failed",
        "Failed to change password",
        icon: Icon(Icons.account_circle),
        shouldIconPulse: true,
        barBlur: 20,
        isDismissible: true,
        duration: Duration(seconds: 3),
      );
    }
    // String url = baseUrl + endPoint;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Password'),
      ),
      body: isLoading == true
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _form,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _currentPass,
                        validator: (val) {
                          if (val.isEmpty) return 'Empty';
                          // if (val != _pass.text) return 'Not Match';

                          return null;
                        },
                        obscureText: _obscureText1,
                        decoration: InputDecoration(
                            labelText: "Old Password",
                            hintText: "Your password",
                            icon: GestureDetector(
                              onTap: () {
                                _toggle1();
                              },
                              child: const Padding(
                                  padding: const EdgeInsets.only(top: 15.0),
                                  child: const Icon(Icons.lock)),
                            ),
                            hintStyle: TextStyle(color: Colors.black54)),
                      ),
                      TextFormField(
                        controller: _pass,
                        validator: (val) {
                          if (val.isEmpty) return 'Empty';
                          if (val.length < 8) return 'Password too short';
                          return null;
                        },
                        obscureText: _obscureText,
                        decoration: InputDecoration(
                          labelText: "Change Password",
                          hintText: "Enter your new Password",
                          icon: GestureDetector(
                            onTap: () {
                              _toggle();
                            },
                            child: const Padding(
                                padding: const EdgeInsets.only(top: 15.0),
                                child: const Icon(Icons.lock)),
                          ),
                          hintStyle: TextStyle(color: Colors.black54),
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(top: 20.0)),
                      TextFormField(
                        controller: _confirmPass,
                        validator: (val) {
                          if (val.isEmpty) return 'Empty';
                          if (val != _pass.text) return 'Not Match';

                          return null;
                        },
                        obscureText: _obscureText1,
                        decoration: InputDecoration(
                            labelText: "Confirm Password",
                            hintText: "Confirm your password",
                            icon: GestureDetector(
                              onTap: () {
                                _toggle1();
                              },
                              child: const Padding(
                                  padding: const EdgeInsets.only(top: 15.0),
                                  child: const Icon(Icons.lock)),
                            ),
                            hintStyle: TextStyle(color: Colors.black54)),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      DefaultButton(
                        text: 'Change Password',
                        // if all are valid then go to success screen
                        press: () async {
                          if (_form.currentState.validate()) {
                            save(customerId);

                            // print(customerId);
                            // _pass.text = "";
                            // _confirmPass.text = "";
                            //  press: () async {
                            Map data = {};
                            var response = await Api().postData(data, 'logout');
                            var result = json.decode(response.body);
                            if (result['code'] == 200) {
                              SharedPreferences preferences =
                                  await SharedPreferences.getInstance();
                              preferences.remove('token');
                              Navigator.popAndPushNamed(
                                  context, SignInScreen.routeName);
                            } else {
                              print(result['code']);
                            }
                            // print(result['code']);

                          }
                          KeyboardUtil.hideKeyboard(context);
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
