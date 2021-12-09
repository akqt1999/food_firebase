

import 'package:foodapp/model/cart_model.dart';
import 'package:foodapp/model/food_model.dart';

abstract class ProcessCartViewModel{

  Future <bool>submitCart( FoodModel foodModel,String restaurantId, {int quantity: 1}) ;
  Future<List<CartModel>> displayCarts(String restaurantId);

}