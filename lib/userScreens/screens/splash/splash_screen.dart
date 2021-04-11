import 'package:flutter/material.dart';
import 'package:medicalpasal/userScreens/screens/home/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants.dart';
import '../../../selectionPage.dart';

// class SplashPage extends StatelessWidget {
//   static String routeName = "/splash";
//   @override
//   Widget build(BuildContext context) {
//     // You have to call it on your starting screen
//     SizeConfig().init(context);
//     void checkToken() async{
//       SharedPreferences preferences =
//                     await SharedPreferences.getInstance();
//       String token = preferences.getString('token');
//       if(token == null){
//         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> SelectionPage()));
//       }
//       else{
//         Navigator.popAndPushNamed(context, HomeScreen.routeName);
//       }
//     }
//   //   return SplashScreen(
//   //       seconds: 2,
//   //       navigateAfterFuture: checkToken(),
//   //       navigateAfterSeconds: ,
//   //       image: kAppLogo,
//   //       backgroundColor: Colors.white,
//   //       photoSize: 150.0,
//   //       loaderColor: kPrimaryColor);
//   // }
// }

class SplashPage extends StatefulWidget {
  static String routeName = "/splash";

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  void checkToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String token = preferences.getString('token');
    print(token);

    // preferences.remove('token');
    // print(token);
    if (token == null) {
      Future.delayed(Duration(seconds: 5), () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => SelectionPage()));
      });
    } else {
      Future.delayed(Duration(seconds: 5), () {
        Navigator.popAndPushNamed(context, HomeScreen.routeName);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    checkToken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Container(
        child: kAppLogo,
        // height: 250,
        height: MediaQuery.of(context).size.height / 6,
        // height: getProportionateScreenWidth(250),
        // width: getProportionateScreenHeight(20),
        // width: 300,
        width: MediaQuery.of(context).size.height / 4,
      ),
      // Text('Medical Pasal'),
    ));
  }
}
