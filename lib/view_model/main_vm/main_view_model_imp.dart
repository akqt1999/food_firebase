import 'package:foodapp/firebase/restaurant_reference.dart';
import 'package:foodapp/model/restaurant_model.dart';
import 'package:foodapp/view_model/main_vm/main_view_model.dart';

class MainViewModelImp implements MainViewModel{


  @override
  Future<List<RestaurantModel>> displayRestaurantList() {
    return getRestaurantList();
  }

}