
import 'package:foodapp/model/restaurant_model.dart';

abstract class MainViewModel{//abstract dung de cho cai khac implemment
  Future<List<RestaurantModel>>displayRestaurantList();

}