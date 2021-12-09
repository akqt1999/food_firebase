import 'package:foodapp/model/order_model.dart';
import 'package:foodapp/state/cart_state.dart';

abstract class ProcessOrderViewModel{
  Future<bool>submitOrder(OrderModel orderModel);

 Future<OrderModel>  createOrderModel(
      {String restaurantId,
      double discount,
      String firstName,
      String lastName,
      String address,
      String comment,
      CartStateController cartStateController,
      bool isCod});

}