
import 'package:foodapp/firebase/category_reference.dart';
import 'package:foodapp/model/category_model.dart';
import 'package:foodapp/view_model/category_vm/category_viewmodel.dart';

class CategoryVieModelImp implements CategoryViewModel{
  @override
  Future<List<CategoriesModel>> displayCategoryByRestaurantId(String restaurantId) {
        return getCategoryByRestaurantId(restaurantId);
  }

}