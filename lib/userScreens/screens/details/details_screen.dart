import 'package:flutter/material.dart';
import 'package:medicalpasal/userScreens/screens/home/components/appBar.dart';
import 'package:medicalpasal/size_config.dart';

import 'components/body.dart';

class DetailsScreen extends StatefulWidget {
  static String routeName = "/details";
  final mydata;

  const DetailsScreen({Key key, this.mydata}) : super(key: key);
  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Body(product: widget.mydata);
  }
}
