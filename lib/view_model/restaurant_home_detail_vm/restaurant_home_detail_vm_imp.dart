import 'package:foodapp/firebase/best_detail_reference.dart';
import 'package:foodapp/firebase/popular_reference.dart';
import 'package:foodapp/model/popular_item_model.dart';
import 'package:foodapp/view_model/restaurant_home_detail_vm/restaurant_home_detail_vm.dart';

class RestaurantDetailViewModelImp implements RestaurantHomeDetailViewModel{
  @override
  Future<List<PopularItemModel>> displayMostPopularByRestaurantId(String restaurantId) {
      return getMostPopularByRestaurantId(restaurantId);
    }

  @override
  Future<List<PopularItemModel>> displayBestDeatailByRestaurantId(String restaurantId) {
    return getBestDetailByRestaurantId(restaurantId);
  }

}