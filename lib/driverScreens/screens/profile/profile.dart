import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:medicalpasal/constants.dart';
import 'package:medicalpasal/userScreens/api/api.dart';
import 'package:medicalpasal/userScreens/screens/profile/components/profile_menu.dart';
import 'package:medicalpasal/userScreens/screens/sign_in/sign_in_screen.dart';
import 'package:medicalpasal/userScreens/screens/profile/components/accountSettings.dart';
import 'package:medicalpasal/userScreens/screens/aboutUs/aboutUs.dart';

import 'package:shared_preferences/shared_preferences.dart';

class DriverProfile extends StatefulWidget {
  const DriverProfile({
    Key key,
  }) : super(key: key);

  @override
  _DriverProfileState createState() => _DriverProfileState();
}

class _DriverProfileState extends State<DriverProfile> {
  int customerId;
  String name;
  bool showUpload = false;
  @override
  void initState() {
    super.initState();
    getuserDetails();
  }

  showAlertDialog(BuildContext context, String title, String content) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        // save(customerId);
        setState(() {});
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        okButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  List<Asset> imagePicker = List<Asset>();
  String _error;
  //For Image
  File imageFile;
  bool isLoading = true;
  void pickImage() async {
    PickedFile pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      imageFile = File(pickedFile.path);
      print(
          "-------------------------------------image-----------------------------");
      print(imageFile);
    });
  }

  Future<void> loadAssets() async {
    setState(() {
      imagePicker = List<Asset>();
    });

    List<Asset> resultList;
    String error;

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 1,
      );
    } on Exception catch (e) {
      error = e.toString();
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      imagePicker = resultList;
      showUpload = !showUpload;

      if (error == null) _error = 'No Error Dectected';
    });
  }

  Future getuserDetails() async {
    var response = await Api().getData('user');
    var data = json.decode(response.body);

    print(name);
    //   isLoading = false;
    // setState(() {
    customerId = data['id'];
    name = data['name'];
    // });
    return data;
  }

  // Future getUser() async {
  //   var response = await Api().getData('user');
  //   var data = json.decode(response.body);
  //   print(data);
  //   return data;
  // }

  Future save(int id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String token = preferences.getString('token');
    final uri = Uri.parse(apiLink + 'api/profile/$id?_method=PUT');
    MultipartFile multipartFile;

    MultipartRequest request = http.MultipartRequest('POST', uri);

    List<int> imageData = [];
    for (var image in imagePicker) {
      ByteData byteData = await image.getByteData();
      imageData = byteData.buffer.asInt8List();
      multipartFile = MultipartFile.fromBytes('profile_image[]', imageData,
          filename: image.name);
    }
    request.files.add(multipartFile);
    request.headers['Authorization'] = 'Bearer ' + token;
    var response = await request.send();
    print(response.statusCode);
    if (response.statusCode == 500) {
      showAlertDialog(context, 'Failed', 'Could not connect to the server');
    } else {
      showAlertDialog(context, 'Success', 'ProfileImage Updated Successfully');
    }
  }

  //getprofile image
  Future getProfileImage() async {
    try {
      var response = await Api().getData('user');
      var profile = json.decode(response.body);
      print(profile);
      return profile;
    } on SocketException {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        // leading: Container(),
        automaticallyImplyLeading: false,
        // centerTitle: true,
        backgroundColor: Colors.white,
        // title: Image.asset(
        //   "assets/images/ic_app_icon.png",
        //   width: 80,
        //   height: 40,
        // ),
        title: Text(
          'Medical Pasal',
          style: TextStyle(color: kPrimaryColor),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            SizedBox(
              height: 115,
              width: 115,
              child: Stack(
                fit: StackFit.expand,
                overflow: Overflow.visible,
                children: [
                  FutureBuilder(
                    future: getProfileImage(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return snapshot.data['profile_image'] == null
                            ? CircleAvatar(
                                backgroundImage:
                                    AssetImage('assets/images/userimage.png'),
                              )
                            : CircleAvatar(
                                backgroundImage: NetworkImage(
                                  apiLink +
                                      '/profileImage/' +
                                      snapshot.data['profile_image'],
                                ),
                              );
                      } else if (snapshot.hasError) {
                        return Text('Cannot load at this time');
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                  Positioned(
                    right: -16,
                    bottom: 0,
                    child: SizedBox(
                      height: 46,
                      width: 46,
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                          side: BorderSide(color: Colors.white),
                        ),
                        color: Color(0xFFF5F6F9),
                        onPressed: () {
                          // final data = {

                          print("profile pic image button is pressed");
                          loadAssets();

                          // save(customerId);
                        },
                        child: SvgPicture.asset("assets/icons/Camera Icon.svg"),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            // buildGridView(),
            showUpload == false
                ? SizedBox()
                : RaisedButton(
                    onPressed: () {
                      save(customerId);
                    },
                    child: Text('Upload'),
                  ),
            FutureBuilder(
              future: getuserDetails(),
              // initialData: InitialData,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return Text(name);
                } else if (snapshot.hasError) {
                  return Text('Cannot load at this time');
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
            SizedBox(height: 20),
            ProfileMenu(
              text: "Settings",
              icon: "assets/icons/Settings.svg",
              press: () {
                Navigator.pushNamed(context, AccountSettings.routeName);
              },
            ),
            ProfileMenu(
              text: "About Us",
              icon: "assets/icons/User.svg",
              press: () {
                Navigator.pushNamed(context, AboutUs.routeName);
              },
            ),
            ProfileMenu(
              text: "Log Out",
              icon: "assets/icons/Log out.svg",
              press: () async {
                Map data = {};
                var response = await Api().postData(data, 'logout');
                var result = json.decode(response.body);
                if (result['code'] == 200) {
                  SharedPreferences preferences =
                      await SharedPreferences.getInstance();
                  preferences.remove('token');
                  Navigator.popAndPushNamed(context, SignInScreen.routeName);
                } else {
                  print(result['code']);
                }
                // print(result['code']);
              },
            ),
          ],
        ),
      ),
    );
  }
}
