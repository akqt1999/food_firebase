import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:foodapp/const/const.dart';
import 'package:foodapp/model/cart_model.dart';

Future<bool> writeCartToFirebase(CartModel cartModel) async {
  try {
    await FirebaseDatabase.instance
        .reference()
        .child(CART_REF)
        .child(FirebaseAuth.instance.currentUser.uid)
        .child(cartModel.restaurantId)
        .child(cartModel.id)//id food
        .set(cartModel.toJson());
    return true;
  } catch (e) {
    return false;
  }
}

Future<List<CartModel>>getCarts(String restaurantId)async {
  var list =List<CartModel>.empty(growable: true);

      var source=await FirebaseDatabase.instance
          .reference().child(CART_REF)
           .child(FirebaseAuth.instance.currentUser.uid)
          .child('restaurantf').once();
      Map<dynamic,dynamic>values=source.value;
      values.forEach((key, value) {
        list.add(CartModel.fromJson(jsonDecode(jsonEncode(value))));
        print('dem');
      });

  print('i here ${list.length}');
  list.forEach((element) { print('ten mon an: ${element.name}');});
  return list;


}















