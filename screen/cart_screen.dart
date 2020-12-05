import 'package:flutter/material.dart';
import 'package:minimart/model/cart_model.dart';
import 'package:minimart/model/user_model.dart';
import 'package:minimart/screen/order_screen.dart';
import 'package:minimart/tile/cart_tile.dart';
import 'package:minimart/widget/cart_price.dart';
import 'package:minimart/widget/discount_card.dart';
import 'package:minimart/widget/ship_card.dart';
import 'package:scoped_model/scoped_model.dart';

import 'login_screen.dart';


class CartScreen  extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart Summary"),
        actions: <Widget>[
          Container(
            padding: EdgeInsets.only(right: 8.0),
            alignment: Alignment.center,
            child: ScopedModelDescendant<CartModel>(
              builder: (context, child, model){
                int p = model.productList.length;
                return Text(       //  p ?? 0   same as (p != null) ? p : 0
                    "${p ?? 0} ${ p <= 1 ? "ITEM" : "ITEMS"}",
                  style: TextStyle(fontSize: 18.0),
                );
              },
            ),
          ),
        ],
    ),
      body: ScopedModelDescendant<CartModel>(
        builder: (context, child, model){
          // logged, not logged, empty, full
          if (model.isLoading && UserModel.of(context).isLoggedIn()){
            return Center(
              child: CircularProgressIndicator(),
            );
          } else  if (!UserModel.of(context).isLoggedIn()){
            return Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.remove_shopping_cart,
                  size: 80.0,
                  color: Theme.of(context).primaryColor ,),
                  SizedBox(height: 16.0,),
                  RaisedButton(
                    child: Text("Please login to add products",
                      style: TextStyle(fontSize: 18.0),),
                      textColor: Colors.white,
                      color: Theme.of(context).primaryColor,
                      onPressed: (){
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => LoginScreen())
                        );
                      }),
                ],
              ),
            );
          } else if (model.productList == null || model.productList.length == 0) {
            return Center (
              child: Text("Wayyy too empty this shopping cart!",
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,),
            );
          } else {
            return ListView(
              children: <Widget>[
                Column(
                  children: model.productList.map((product){
                    return CartTile(product);
                  }
                  ).toList(),
                ),
                DiscountCart(),
                ShipCard(),
                CartPrice(() async {
                  String orderId = await model.finishOrder();
                  //print(orderId);
                  if (orderId != null)
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context)=>OrderScreen(orderId))
                    );
                }),
              ],
            );
          }
        }
        ),
    );
  }
}
