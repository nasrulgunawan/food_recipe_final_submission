import 'dart:async';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTime() async {
    var _duration = Duration(seconds: 3);
    return Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.pushReplacementNamed(context, '/HomeScreen');
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: Colors.pink,
      child: Stack(
        children: <Widget>[
          Center(child: Icon(Icons.fastfood, color: Colors.white, size: 70)),
          Positioned.fill(
            top: 130,
            child: Center(
                child: Text("Food Recipes App",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20))),
          ),
          Positioned.fill(
            top: 270,
            child: Center(
                child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.white))),
          )
        ],
      ),
    ));
  }
}
