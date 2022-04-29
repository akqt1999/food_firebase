import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:foodapp/const/const.dart';
import 'package:foodapp/model/order_model.dart';
import 'package:foodapp/utils/const.dart';

Future<bool>writeOrderToFirebase(OrderModel orderModel)async {
  try{
    await FirebaseDatabase.instance.reference()
        .child(RESTAURANT_REF)
        .child(orderModel.restaurantId)
        .child(ORDER_REF)
        .child(orderModel.orderNumber)
        .set(orderModel.toJson());
    return true;

  }catch(e){

      return false;
  }
}//Future la cai nay no se thuc hien load len firevase.database

Future<List<OrderModel>>getUserOrderMyRestaurant(String restaurantId,String statusMode)async {
  var orderStatusMode =statusMode==ORDER_CANCELLED?-1:2;
  var userId=FirebaseAuth.instance.currentUser.uid;
  var list=new List<OrderModel>.empty(growable: true);
  var source=await FirebaseDatabase.instance
  .ref().child(RESTAURANT_REF).child(restaurantId).child(ORDER_REF)
      .orderByChild('userId').
  equalTo(userId).once();
  var values=source.snapshot;
  values.children.forEach((element) {
    list.add(OrderModel.fromJson(jsonDecode(jsonEncode(element.value))));
  });
  return list.where((element) => statusMode==ORDER_PROCESSING?// neu la san pham trong qua trinh , thi lay ra nhung san pham o trang thai 0-1
  (element.orderStatus==0||element.orderStatus==1):
  element.orderStatus==orderStatusMode).toList(); // cai  nay se add nhung san pham trong cai khong dc tao  `
}
