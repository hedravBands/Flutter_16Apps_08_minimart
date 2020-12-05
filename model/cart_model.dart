import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:minimart/data/cart_product.dart';
import 'package:minimart/model/user_model.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/material.dart';

class CartModel extends Model {

  UserModel user;

  bool isLoading = false;

  List<CartProduct> productList = [];

  String couponCode;
  int discountPercentage = 0;

  CartModel(this.user){
    if(user.isLoggedIn())
      _loadCartItem();
  }

  static CartModel of(BuildContext context) =>
      ScopedModel.of<CartModel>(context);


  void addCartItem(CartProduct cartProduct){
    productList.add(cartProduct);
    Firestore.instance.collection("user").document(user.firebaseUser.uid)
      .collection("cart").add(cartProduct.toMap()).then((doc){
        cartProduct.cid = doc.documentID;
    });

    notifyListeners();

  }

  void removeCartItem(CartProduct cartProduct){
    Firestore.instance.collection("user").document(user.firebaseUser.uid)
      .collection("cart").document(cartProduct.cid).delete();

    productList.remove(cartProduct);

    notifyListeners();
  }

  void decProduct(CartProduct cartProduct){
    cartProduct.quantity--;

    Firestore.instance.collection("user").document(user.firebaseUser.uid)
    .collection("cart").document(cartProduct.cid).updateData(cartProduct.toMap());

    notifyListeners();

  }
  void incProduct(CartProduct cartProduct){
    cartProduct.quantity++;

    Firestore.instance.collection("user").document(user.firebaseUser.uid)
        .collection("cart").document(cartProduct.cid).updateData(cartProduct.toMap());

    notifyListeners();

  }

  void setCoupon (String couponCode, int discountPercentage){
    this.couponCode = couponCode;
    this.discountPercentage = discountPercentage;
  }

  void updatePrice(){
    notifyListeners();
  }

  double getProductsPrice(){
    double price = 0.0;
    for(CartProduct c in productList){
      if (c.productData != null) price += c.quantity*c.productData.price;
    }
    return price;
  }




  double getDiscount(){
    return getProductsPrice()*discountPercentage/100;
  }

  double getShipPrice() {
    return 9.99; //module not working
  }

  Future<String> finishOrder() async {

    if(productList.length == 0) return null;

    isLoading = true;
    notifyListeners();

    double productPrice = getShipPrice();
    double shipPrice = getShipPrice();
    double discount = getDiscount();

    DocumentReference refOrder = await Firestore.instance.collection("order").add(
        {
          "clientId": user.firebaseUser.uid,
          "productList": productList.map((cartProduct) => cartProduct.toMap())
              .toList(),
          "shipPrice": shipPrice,
          "productPrice": productPrice,
          "discount": discount,
          "totalPrice": productPrice - discount + shipPrice,
          "status": 1
        }
    );

    await Firestore.instance.collection("user").document(user.firebaseUser.uid)
      .collection("order").document(refOrder.documentID).setData(
      {
        "timestamp": Timestamp.now()
      }
    );

    QuerySnapshot query = await Firestore.instance.collection("user")
        .document(user.firebaseUser.uid).collection("cart").getDocuments();

    for(DocumentSnapshot doc in query.documents){
      doc.reference.delete();
    }

    productList.clear();
    discountPercentage = 0;
    couponCode = null;
    isLoading = false;

    notifyListeners();

    return refOrder.documentID;



  }



  void _loadCartItem() async {
    QuerySnapshot query =
      await Firestore.instance.collection("user").document(user.firebaseUser.uid)
        .collection("cart").getDocuments();

    productList = query.documents.map((doc)=>CartProduct.fromDocument(doc)).toList();

    notifyListeners();
  }

}