import 'package:flutter/material.dart';

class About extends StatefulWidget {
  About({Key key}) : super(key: key);

  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("About",
              style: TextStyle(
                  fontFamily: 'ProductSans',
                  fontWeight: FontWeight.bold,
                  fontSize: 20)),
          Padding(padding: EdgeInsets.only(bottom: 20)),
          Text("App Name: Food Recipes",
              style: TextStyle(fontFamily: 'ProductSans', fontWeight: FontWeight.bold)),
          Padding(padding: EdgeInsets.only(bottom: 3)),
          Text("Author: Nasrul Gunawan",
              style: TextStyle(fontFamily: 'ProductSans')),
          Padding(padding: EdgeInsets.only(top: 3)),
          Text("FLUTTER ACADEMY",
              style: TextStyle(fontFamily: 'ProductSans')),
        ],
      ),
    ));
  }
}
