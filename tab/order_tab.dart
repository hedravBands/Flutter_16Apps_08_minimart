import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:minimart/model/user_model.dart';
import 'package:minimart/screen/login_screen.dart';
import 'package:minimart/tile/order_tile.dart';

class OrderTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    if(UserModel.of(context).isLoggedIn()){

      String uid = UserModel.of(context).firebaseUser.uid;

      return FutureBuilder<QuerySnapshot>(
          future: Firestore.instance.collection("user").document(uid)
            .collection("order").getDocuments(),  //after collection there exists .orderBy
          builder: (context, snapshot){
            if (!snapshot.hasData)
              return Center(
                child: CircularProgressIndicator(),
              );
            else {
              return ListView(
                children: snapshot.data.documents.map(
                        (doc)=>OrderTile(doc.documentID)
                ).toList().reversed.toList(), //to get last orders first (?)
              );
            }

          });



    } else {
      return Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.view_list,
              size: 80.0,
              color: Theme.of(context).primaryColor ,),
            SizedBox(height: 16.0,),
            Text("Please login to see your orders!",
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
            RaisedButton(
                child: Text("Enter",
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

    }


  }
}
