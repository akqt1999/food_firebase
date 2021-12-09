import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:foodapp/const/const.dart';
import 'package:foodapp/model/category_model.dart';

Future<List<CategoriesModel>> getCategoryByRestaurantId(
    String restaunrantId) async {


  var list=List<CategoriesModel>.empty(growable: true);
  var source=await FirebaseDatabase.instance.reference()
      .child(RESTAURANT_REF)
      .child(restaunrantId) // moi cai restaurant se co mot cai key,
      .child('Category').once();

  Map<dynamic,dynamic>values=source.value;
  values.forEach((key, value) {
  list.add(CategoriesModel.fromJson(jsonDecode(jsonEncode(value)),key));
  });

  return list;
}
