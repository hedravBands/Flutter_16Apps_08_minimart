import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrderTile extends StatelessWidget {

  final String orderId;
  OrderTile(this.orderId);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: StreamBuilder<DocumentSnapshot>(
          stream: Firestore.instance.collection("order").document(orderId).snapshots(),
          builder: (context,snapshot){
            if(!snapshot.hasData){
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Order Id: ${snapshot.data.documentID}",
                    style: TextStyle(fontWeight: FontWeight.bold),),
                  SizedBox(height: 4.0,),
                  Text(_buildProductText(snapshot.data)),
                  SizedBox(height: 4.0,),
                  Text("Order Status", style: TextStyle(fontWeight: FontWeight.bold),),
                  SizedBox(height: 4.0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      _buildCircle("1", "Preparation", snapshot.data["status"], 1),
                      Container(height: 1.0, width: 40.0,color: Colors.grey[500]),
                      _buildCircle("2", "Transport", snapshot.data["status"], 2),
                      Container(height: 1.0, width: 40.0,color: Colors.grey[500]),
                      _buildCircle("3", "Delivered", snapshot.data["status"], 3),
                    ],
                  ),
                ],
              );
            }

          },
        ),
      ),
    );
  }

  String _buildProductText(DocumentSnapshot snapshot){
    String text = "Description: \n";
    for(LinkedHashMap p in snapshot.data["productList"]) {
      text += "  •  ${p["quantity"]} x ${p["product"]["title"]} (US\$ ${p["product"]["price"].toString()})\n";
    }
    text += "Total: US\$ ${snapshot.data["totalPrice"].toString()}";
    return text;
  }

  Widget _buildCircle(String title, String subtitle, int status, int thisStatus){
    Color backColor;
    Widget child;
    if(status < thisStatus){
      backColor = Colors.grey[500];
      child = Text(title, style: TextStyle(color: Colors.white),);
    } else if (status == thisStatus){
      backColor = Colors.blue;
      child = Stack (
        alignment: Alignment.center,
        children: <Widget>[
          Text(title, style: TextStyle(color: Colors.white),),
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        ],
      );
    } else {
      backColor = Colors.green;
      child = Icon(Icons.check, color: Colors.white,);
    }
    return Column(
      children: <Widget>[
        CircleAvatar(
          radius: 20.0,
          backgroundColor: backColor,
          child: child,
        ),
        SizedBox(height: 4.0,),
        Text(subtitle),
      ],
    );
  }
}
