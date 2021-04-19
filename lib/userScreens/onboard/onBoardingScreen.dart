import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:medicalpasal/userScreens/screens/home/home_screen.dart';

class OnBoarding extends StatefulWidget {
  static String routeName = "/onBoard";

  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.pushNamedAndRemoveUntil(
        context, HomeScreen.routeName, (route) => false);
  }

  Widget _buildImage(String assetName) {
    return Align(
      child: Image.asset('assets/images/onBoard1.png', width: 350.0),
      alignment: Alignment.bottomCenter,
    );
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);
    const pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: IntroductionScreen(
        key: introKey,
        pages: [
          PageViewModel(
            title: "Ayurvedic Pasal",
            body:
                "Find the ayurvedic products for thsi covid situation with fast delivery at your doorstep",
            image: _buildImage('img1'),
            decoration: pageDecoration,
          ),
          PageViewModel(
            title: "Fast Delivery",
            body: "Fast Product Delivery to you",
            image: _buildImage('img2'),
            decoration: pageDecoration,
          ),
          PageViewModel(
            title: "Safe Delivery",
            body: "Safely deliver products to you",
            image: _buildImage('img3'),
            decoration: pageDecoration,
          ),
        ],
        onDone: () => _onIntroEnd(context),
        //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
        showSkipButton: true,
        skipFlex: 0,
        nextFlex: 0,
        skip: const Text('Skip'),
        next: const Icon(Icons.arrow_forward),
        done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
        dotsDecorator: const DotsDecorator(
          size: Size(10.0, 10.0),
          color: Color(0xFFBDBDBD),
          activeSize: Size(22.0, 10.0),
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
          ),
        ),
      ),
    );
  }
}
