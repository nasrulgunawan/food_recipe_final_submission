import 'package:flutter/material.dart';
import 'package:food_recipes/model/foods.dart';
import 'package:food_recipes/network/response.dart';
import 'package:food_recipes/views/screen/menu.dart';
import 'package:food_recipes/views/screen/about.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  final List _content = [
    Menu(category: 'Seafood'),
    Menu(category: 'Dessert'),
    About()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: _content[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.fastfood),
            title: Text('Seafood'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.cake),
            title: Text('Dessert'),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person), title: Text('About'))
        ],
      ),
    );
  }
}