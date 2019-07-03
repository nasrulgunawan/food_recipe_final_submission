import 'package:flutter/material.dart';
import 'package:food_recipes/views/screen/home_screen.dart';
import 'package:food_recipes/views/detail/detail_screen.dart';
import 'package:food_recipes/views/screen/splash_screen.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
      title: 'Food Recipes',
      theme: ThemeData(
          primaryColor: Colors.pink,
          fontFamily: 'ProductSans'
      ),
      initialRoute: '/',
      routes: {
        '/HomeScreen': (context) => MyHomePage(title: 'Food Recipes'),
        DetailScreen.routeName: (context) => DetailScreen(),
      },
    );
  }
}