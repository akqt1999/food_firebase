import 'package:foodapp/model/category_model.dart';

abstract class CategoryViewModel{
  Future<List<CategoriesModel>>displayCategoryByRestaurantId(String restaurantId);
}