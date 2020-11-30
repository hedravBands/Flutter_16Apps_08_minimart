import 'package:cloud_firestore/cloud_firestore.dart';

class ProductData {
  String category;

  String id;
  String title;
  String desc;

  double price;

  List image;
  List size;

  ProductData.fromDocument(DocumentSnapshot snapshot){
    id = snapshot.documentID;
    title = snapshot.data['title'];
    desc = snapshot.data['desc'];
    price = snapshot.data['price'] + 0.0;
    image = snapshot.data['image'];
    size = snapshot.data['size'];

  }

}