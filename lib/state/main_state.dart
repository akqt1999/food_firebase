import 'package:foodapp/model/restaurant_model.dart';
import 'package:get/get.dart';

class MainStateController extends GetxController{
  var selectedRestaurant=RestaurantModel(
    address: '',
    name: '',
    imageUrl: '',
    paymentUrl: '',
    phone: '').obs;
}