import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:foodapp/const/const.dart';
import 'package:foodapp/model/popular_item_model.dart';

Future<List<PopularItemModel>> getBestDetailByRestaurantId(String restaurantId) async {
  var list=List<PopularItemModel>.empty(growable: true);
  var source=await FirebaseDatabase.instance.ref().child(RESTAURANT_REF)
      .child(restaurantId) // moi cai restaurant se co mot cai key,
      .child(BEST_DETAIL_REF).once();
  var values=source.snapshot;
  values.children.forEach((element) {
    list.add(PopularItemModel.fromJson(jsonDecode(jsonEncode(element.value))));

  });
  return list;
}