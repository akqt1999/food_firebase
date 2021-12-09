import 'package:foodapp/model/addon_model.dart';
import 'package:foodapp/model/size_model.dart';
import 'package:get/get.dart';

class FoodDetailStateController extends GetxController {
  var quantity=1.obs;
  var selectSize =SizeModel(name: 'name',price: 0).obs;
  var selectAddon=List<AddonModel>.empty(growable: true).obs;

}