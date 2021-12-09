import 'package:foodapp/firebase/order_reference.dart';
import 'package:foodapp/model/order_model.dart';
import 'package:foodapp/view_model/order_history_vm/order_history_view_model.dart';

class OrderHistoryViewModelImp implements OrderHistoryViewModel{
  @override
  Future<List<OrderModel>> getUserHistory(String restaurantId,String statusMode) {
        return getUserOrderMyRestaurant(restaurantId,statusMode);
    }

}