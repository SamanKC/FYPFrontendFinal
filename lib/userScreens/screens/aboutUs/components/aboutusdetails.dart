import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        SizedBox(
          height: 5,
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          height: MediaQuery.of(context).size.height,
          child: InkWell(
              onTap: () {
                print('faq pressed');
              },
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 1.0, left: 10.0, bottom: 5.0, right: 10.0),
                child: Card(
                  elevation: 1.0,
                  child: ListTile(
                    //leading: Text(mydata['id'].toString()),
                    title: Text(
                      'Hello Mobile Service is an reputed mobile service center located in Itahari. Smartphone, Chargers, Earphone of differetn brands are available at cheap rate. \n Mobile repairing service is also available here, an problem with your smartphone will be solve here. ',
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w500),
                    ),
                    subtitle: RichText(
                      overflow: TextOverflow.ellipsis,
                      strutStyle: StrutStyle(fontSize: 10.0),
                      text: TextSpan(
                          style: TextStyle(color: Colors.black),
                          text: 'answer'),
                    ),
                  ),
                ),
              )),
        )
      ]),
    );
  }
}
