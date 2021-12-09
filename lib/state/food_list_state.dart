import 'package:foodapp/model/food_model.dart';
import 'package:get/get.dart';

class FoodListStateController extends GetxController{
  var selectFood=FoodModel(
    description: 'description',
    id:'id',
    name: 'name',
  price: 0,
    size: [],
    addon: []).obs;
}