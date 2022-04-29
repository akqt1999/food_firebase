import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:foodapp/const/const.dart';
import 'package:foodapp/model/restaurant_model.dart';

Future<List<RestaurantModel>>getRestaurantList() async{

  var list=List<RestaurantModel>.empty(growable: true);
  var source=
      await FirebaseDatabase.instance.ref().child(RESTAURANT_REF).once();
  var values=source.snapshot;

  values.children.forEach((element) {
  //  restaurantModel=RestaurantModel.fromJson(jsonDecode(jsonEncode(values)));
    //restaurantModel.restaurantId=key;
    list.add(RestaurantModel.fromJson(jsonDecode(jsonEncode(element.value)),element.key));
//    list.add(restaurantModel);
  });


  return list;
}