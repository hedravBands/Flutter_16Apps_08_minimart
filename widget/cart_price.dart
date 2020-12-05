import 'package:flutter/material.dart';
import 'package:minimart/model/cart_model.dart';
import 'package:scoped_model/scoped_model.dart';

class CartPrice extends StatelessWidget {

  final VoidCallback buy;
  CartPrice(this.buy);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0,vertical: 4.0),
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: ScopedModelDescendant<CartModel>(
          builder: (context, child, model){

            double price = model.getProductsPrice();
            double discount = model.getDiscount();
            double ship = model.getShipPrice();

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text("Order Summary"),
                SizedBox(height: 12.0,),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Subtotal"),
                    Text("US\$ ${price.toStringAsFixed(2)}"),
                  ],
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Discount"),
                    Text("US\$ ${discount.toStringAsFixed(2)}"),
                  ],
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Shipping & Handling"),
                    Text("US\$ ${ship.toStringAsFixed(2)}"),
                  ],
                ),
                Divider(),
                SizedBox(height: 12.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Total"),
                    Text("US\$ ${(price + ship - discount).toStringAsFixed(2)}"),
                  ],
                ),
                SizedBox(height: 8.0),
                RaisedButton(
                    child: Text("Complete your Order"),
                    textColor: Colors.white,
                    color: Theme.of(context).primaryColor,
                    onPressed: buy,
                    ),
                SizedBox(height: 8.0),

              ],
            );

          },
        ),
      ),
    );
  }
}
