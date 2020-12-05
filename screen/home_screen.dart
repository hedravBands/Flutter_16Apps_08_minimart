import 'package:flutter/material.dart';
import 'package:minimart/tab/catalog_tab.dart';
import 'package:minimart/tab/home_tab.dart';
import 'package:minimart/widget/cart_button.dart';
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
          floatingActionButton: CartButton(),
        ),
        Scaffold(
          appBar: AppBar(
            title: Text("Catalog"),
            centerTitle: true,
          ),
          drawer: CustomDrawer(_pageController),
          body: CatalogTab(),
          floatingActionButton: CartButton(),
        ),

        Container(color: Colors.deepOrange
        ),


      ],
    );
  }
}
