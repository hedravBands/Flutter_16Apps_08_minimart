import 'package:flutter/material.dart';
import 'package:minimart/model/user_model.dart';
import 'package:minimart/screen/login_screen.dart';
import 'package:minimart/screen/signup_screen.dart';
import 'package:scoped_model/scoped_model.dart';
import 'model/cart_model.dart';
import 'screen/home_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<UserModel>(
      model: UserModel(),
      child: ScopedModelDescendant<UserModel>(
        builder: (context, child, model){
          return ScopedModel<CartModel>(
            model: CartModel(model),
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'MiniMart MegaStore',
              theme: ThemeData(
                  primarySwatch: Colors.blue,
                  primaryColor: Color.fromARGB(255,4,125,141)
              ),
              home: HomeScreen(),
            ),
          );
        },
      ),
    );
  }
}
