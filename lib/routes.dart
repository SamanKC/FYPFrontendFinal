import 'package:flutter/widgets.dart';
import 'package:medicalpasal/selectionPage.dart';
import 'package:medicalpasal/userScreens/onboard/onBoardingScreen.dart';
import 'package:medicalpasal/userScreens/screens/profile/components/notifications/notifications_screen.dart';
import 'package:medicalpasal/userScreens/screens/forgot_password/forgot_password_screen.dart';
import 'userScreens/screens/aboutUs/aboutUs.dart';
import 'userScreens/screens/profile/components/accountSettings.dart';
import 'userScreens/screens/cart/cart_screen.dart';
import 'userScreens/bottomNavBar.dart';
import 'driverScreens/bottomNavBar.dart';
import 'userScreens/screens/checkoutpage/checkoutPage.dart';
import 'userScreens/screens/details/details_screen.dart';
import 'userScreens/screens/health_tips/healthtips.dart';
import 'userScreens/screens/home/home_screen.dart';
import 'userScreens/screens/profile/profile_screen.dart';
import 'userScreens/screens/sign_in/sign_in_screen.dart';
import 'userScreens/screens/sign_up/sign_up_screen.dart';
import 'userScreens/screens/splash/splash_screen.dart';
import 'userScreens/screens/wishlist/wishlist.dart';
import 'driverScreens/screens/orders/orders.dart';

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  SplashPage.routeName: (context) => SplashPage(),
  SignInScreen.routeName: (context) => SignInScreen(),
  ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
  SelectionPage.routeName: (context) => SelectionPage(),
  // LoginSuccessScreen.routeName: (context) => LoginSuccessScreen(),
  SignUpScreen.routeName: (context) => SignUpScreen(),
  // CompleteProfileScreen.routeName: (context) => CompleteProfileScreen(),
  // OtpScreen.routeName: (context) => OtpScreen(),
  LandingPage.routeName: (context) => LandingPage(),
  HomeScreen.routeName: (context) => HomeScreen(),
  // GoogleMapsIntegration.routeName: (context) => GoogleMapsIntegration(),
  DetailsScreen.routeName: (context) => DetailsScreen(),
  AboutUs.routeName: (context) => AboutUs(),
  Notifications.routeName: (context) => Notifications(),
  AccountSettings.routeName: (context) => AccountSettings(),
  CartScreen.routeName: (context) => CartScreen(),
  ProfileScreen.routeName: (context) => ProfileScreen(),
  HealthTips.routeName: (context) => HealthTips(),
  CheckOut.routeName: (context) => CheckOut(),
  ProfileScreen.routeName: (context) => ProfileScreen(),
  OnBoarding.routeName: (context) => OnBoarding(),
  WishlistScreen.routeName: (context) => WishlistScreen(),

//drivers routes
  Orders.routeName: (context) => Orders(),
  DriverLandingPage.routeName: (context) => DriverLandingPage(),
};
