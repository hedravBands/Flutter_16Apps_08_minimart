import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:minimart/model/cart_model.dart';

class ShipCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: ExpansionTile(
        title: Text(
          "Shipping and Handling",
          textAlign: TextAlign.start,
          style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.grey[700]
          ),
        ),
        leading: Icon(Icons.card_travel_rounded),
        trailing: Icon(Icons.keyboard_arrow_down),
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Insert your Zip Code here!"
              ),
              initialValue: CartModel.of(context).couponCode ?? "",
              onFieldSubmitted: (text){
                Firestore.instance.collection("coupon").document(text).get()
                    .then((docSnap){
                  if (docSnap.data != null){
                    CartModel.of(context).setCoupon(text, docSnap.data["percent"]);
                    Scaffold.of(context).showSnackBar(
                      SnackBar(content: Text("Coupon successfully applied: "
                          "${docSnap.data["percent"]}% Off! Yay!!"),
                        backgroundColor: Theme.of(context).primaryColor,),

                    );
                  } else {
                    CartModel.of(context).setCoupon(null, 0);
                    Scaffold.of(context).showSnackBar(
                      SnackBar(content: Text("Zip Code not found! Sorry!"),
                          backgroundColor: Theme.of(context).errorColor),
                    );
                  }
                });
              },
            ),
          ),

        ],
      ),

    );
  }
}
