import 'package:flutter/material.dart';
import 'package:medicalpasal/userScreens/screens/aboutUs/aboutUs.dart';
import 'package:showcaseview/showcase_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:medicalpasal/userScreens/api/api.dart';
import 'dart:convert';
import 'package:medicalpasal/userScreens/screens/wishlist/wishlist.dart';
import '../../../../constants.dart';

class DrawerWidget extends StatefulWidget {
  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  String name;
  String email;
  String image;
  @override
  void initState() {
    super.initState();
    getuserDetails();
  }

  bool isLoading = true;
  void customLaunch(command) async {
    if (await canLaunch(command)) {
      await launch(command);
    } else {
      print('could not launch $command');
    }
  }

  Future getuserDetails() async {
    var response = await Api().getData('user');
    var data = json.decode(response.body);

    setState(() {
      name = data['name'];
      email = data['email'];
      image = data['profile_image'];
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.65,
      child: isLoading == true
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  UserAccountsDrawerHeader(
                    decoration: BoxDecoration(
                      color: Theme.of(context).hintColor.withOpacity(0.1),
//              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(35)),
                    ),
                    accountName: Text(
                      name,
                      style: Theme.of(context).textTheme.title,
                    ),
                    accountEmail: Text(
                      email,
                      style: Theme.of(context).textTheme.caption,
                    ),
                    currentAccountPicture: CircleAvatar(
                        backgroundColor: Theme.of(context).accentColor,
                        backgroundImage: image != null
                            ? NetworkImage(apiLink + '/profileImage/' + image)
                            : AssetImage('assets/images/userimage.png')),
                  ),
                  _createDrawerItem(
                    icon: Icons.home,
                    text: 'Home',
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  // _createDrawerItem(
                  //     icon: FontAwesomeIcons.user,
                  //     text: 'Sign In',
                  //     onTap: () => Navigator.push(
                  //           context,
                  //           MaterialPageRoute(builder: (context) => AppSignIn()),
                  //         )),
                  _createDrawerItem(
                      icon: Icons.account_balance_wallet_outlined,
                      text: 'About Us',
                      onTap: () {
                        Navigator.pushNamed(context, AboutUs.routeName);
                      }),
                  _createDrawerItem(
                      icon: Icons.favorite_border,
                      text: 'Wishlist',
                      onTap: () {
                        Navigator.pushNamed(context, WishlistScreen.routeName);
                      }),
                  _createDrawerItem(
                    icon: Icons.call,
                    text: 'Contact Us',
                    onTap: () {
                      customLaunch('tel: +977 9816367276');
                    },
                  ),
                ],
              ),
            ),
    );
  }
}

Widget _createDrawerItem(
    {IconData icon, String text, GestureTapCallback onTap}) {
  return ListTile(
    title: Row(
      children: <Widget>[
        Icon(
          icon,
          color: Color(0xFF808080),
        ),
        Padding(
          padding: EdgeInsets.only(left: 15.0),
          child: Text(
            text,
            style: TextStyle(color: Color(0xFF484848)),
          ),
        )
      ],
    ),
    onTap: onTap,
  );
}
