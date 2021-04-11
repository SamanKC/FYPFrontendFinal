import 'package:flutter/material.dart';
import 'changePassword.dart';

class AccountSettings extends StatefulWidget {
  static String routeName = "/accountsettings";

  @override
  _AccountSettingsState createState() => _AccountSettingsState();
}

class _AccountSettingsState extends State<AccountSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Account Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 15.0, top: 15.0),
              child: Text(
                'Account',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 17.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            buildAccountSettings(sub1: 'Address'),
            buildAccountSettings(sub1: 'Phone'),
            Padding(
              padding: const EdgeInsets.only(bottom: 15.0, top: 15.0),
              child: Text(
                'Password',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 17.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            buildAccountSettings(
                sub1: 'Change Password',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChangePassword()));
                }),
          ],
        ),
      ),
    );
  }

  Widget buildAccountSettings({Function onTap, String sub1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 20.0),
          child: Divider(
            color: Colors.black12,
            height: 0.5,
          ),
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    sub1,
                    style: TextStyle(
                      color: Colors.black38,
                      fontSize: 15.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Icon(
                    Icons.keyboard_arrow_right,
                    color: Colors.black38,
                  )
                ]),
          ),
        ),
      ],
    );
  }
}
