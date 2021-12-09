import 'package:foodapp/model/category_model.dart';
import 'package:get/get.dart';

class CategoryStateController extends GetxController {
  var selectedCategory=CategoriesModel(name: 'name',image: 'image',foods: []).obs;
}