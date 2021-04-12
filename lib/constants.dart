import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xff3CB53C);
const kPrimaryLightColor = Color(0xFFFFECDF);
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFFFA53E), Color(0xFFFF7643)],
);
const kSecondaryColor = Color(0xFF979797);
const kTextColor = Color(0xFF757575);

const kAnimationDuration = Duration(milliseconds: 200);

final headingStyle = TextStyle(
  fontSize: 34,
  // fontSize: getProportionateScreenWidth(28),
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);
Image kAppLogo = Image.asset('assets/images/medicalpasallogo.png');

const defaultDuration = Duration(milliseconds: 250);

final String apiLink = 'http://192.168.254.8:8000';

// Form Error
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
final RegExp phoneValidatorRegExp = RegExp(r"(?:\+977[- ])?\d{2}-?\d{7,8}");
const String kNameNullError = "Please Enter your Name";
const String kCityNullError = "Please Enter your City";
const String kAreaNullError = "Please Enter your Ward";
const String kAddressNullError = "Please Enter your Address";
const String kWardNullError = "Please Enter your Area";
const String kEmailNullError = "Please Enter your email";
const String kInvalidEmailError = "Please Enter Valid Email";
const String kPassNullError = "Please Enter your password";
const String kShortPassError = "Password is too short";
const String kMatchPassError = "Passwords don't match";
const String kNamelNullError = "Please Enter your name";
// const String kNamelNullError = "Please Enter your name";
const String kPhoneNumberNullError = "Please Enter your phone number";
const String kInvalidPhoneNumberNullError = "Please Enter a valid phone number";
// const String kAddressNullError = "Please Enter your address";

// final otpInputDecoration = InputDecoration(
//   contentPadding: EdgeInsets.symmetric(vertical: 15),
//   // EdgeInsets.symmetric(vertical: getProportionateScreenWidth(15)),
//   border: outlineInputBorder(),
//   focusedBorder: outlineInputBorder(),
//   enabledBorder: outlineInputBorder(),
// );

// OutlineInputBorder outlineInputBorder() {
//   return OutlineInputBorder(
//     borderRadius: BorderRadius.circular(15),
//     // borderRadius: BorderRadius.circular(getProportionateScreenWidth(15)),
//     borderSide: BorderSide(color: kTextColor),
//   );
// }

var textFormFieldRegular = TextStyle(
    fontSize: 16,
    fontFamily: "Helvetica",
    color: Colors.black,
    fontWeight: FontWeight.w400);

var textFormFieldLight =
    textFormFieldRegular.copyWith(fontWeight: FontWeight.w200);

var textFormFieldMedium =
    textFormFieldRegular.copyWith(fontWeight: FontWeight.w500);

var textFormFieldSemiBold =
    textFormFieldRegular.copyWith(fontWeight: FontWeight.w600);

var textFormFieldBold =
    textFormFieldRegular.copyWith(fontWeight: FontWeight.w700);

var textFormFieldBlack =
    textFormFieldRegular.copyWith(fontWeight: FontWeight.w900);

/// Custom Text black
var customTextStyle = TextStyle(
  color: Colors.black,
  fontSize: 17.0,
  fontWeight: FontWeight.w800,
);

/// Custom Text for Header title
var subHeaderCustomStyle = TextStyle(
    color: Colors.black54, fontWeight: FontWeight.w700, fontSize: 16.0);

/// Custom Text for Detail title
var detailText =
    TextStyle(color: Colors.black54, letterSpacing: 0.3, wordSpacing: 0.5);
