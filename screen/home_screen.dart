import 'package:flutter/material.dart';
import 'package:minimart/tab/home_tab.dart';
import 'package:minimart/widget/custom_drawer.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      physics: NeverScrollableScrollPhysics(),
      children: [
        Scaffold(
          body: HomeTab(),
          drawer: CustomDrawer(_pageController),
        ),
        Container(color: Colors.red
        ),
        Container(color: Colors.deepOrange
        ),


      ],
    );
  }
}
