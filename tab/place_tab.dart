import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:minimart/tile/place_tile.dart';

class PlaceTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: Firestore.instance.collection("place").getDocuments(),
        builder: (context, snapshot){
        if(!snapshot.hasData)
          return Center(
            child: CircularProgressIndicator(),
          );
        else {
          return ListView(
            children: snapshot.data.documents.map((doc)=>PlaceTile(doc)).toList(),
          );
        }

        });
  }
}
