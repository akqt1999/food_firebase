import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:foodapp/const/const.dart';
import 'package:foodapp/model/restaurant_model.dart';

Future<List<RestaurantModel>>getRestaurantList() async{

  var list=List<RestaurantModel>.empty(growable: true);
  var source=
      await FirebaseDatabase.instance.reference().child(RESTAURANT_REF).once();
  Map<dynamic,dynamic>values=source.value;

  values.forEach((key, value) {
  //  restaurantModel=RestaurantModel.fromJson(jsonDecode(jsonEncode(values)));
    //restaurantModel.restaurantId=key;
    list.add(RestaurantModel.fromJson(jsonDecode(jsonEncode(value)),key));
//    list.add(restaurantModel);
  });


  return list;
}