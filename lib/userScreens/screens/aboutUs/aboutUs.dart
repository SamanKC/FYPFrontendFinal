import 'package:flutter/material.dart';
import 'package:medicalpasal/userScreens/screens/home/components/appBar.dart';

import 'package:medicalpasal/constants.dart';

class AboutUs extends StatelessWidget {
  static String routeName = "/aboutUs";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(context),
      body: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Divider(
                    height: 0.5,
                    color: Colors.black12,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0, left: 15.0),
                  child: Row(
                    children: <Widget>[
                      Image.asset(
                        "assets/images/userimage.png",
                        height: 50.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("Medical Pasal", style: textFormFieldBlack),
                            Text(
                              "Your Ayurvedic Friend",
                              style: textFormFieldRegular,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Divider(
                    height: 0.5,
                    color: Colors.black12,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    "Est sint occaecat commodo consequat sunt ex nostrud enim laborum reprehenderit et cupidatat labore veniam. Exercitation adipisicing nisi Lorem aliqua laborum. Ut sint cillum proident aute deserunt do et incididunt consequat amet. Incididunt enim mollit proident officia adipisicing in ad qui duis labore id nisi ut ipsum. Veniam voluptate adipisicing laboris ex mollit tempor sit fugiat eu labore. Consectetur elit ut pariatur pariatur quis aliqua enim commodo ut anim id. Proident dolore sunt minim aliquip occaecat ut.",
                    style: textFormFieldRegular,
                    textAlign: TextAlign.justify,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
