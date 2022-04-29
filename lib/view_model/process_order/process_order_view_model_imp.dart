import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:foodapp/firebase/order_reference.dart';
import 'package:foodapp/firebase/server_time_offset_reference.dart';
import 'package:foodapp/model/order_model.dart';
import 'package:foodapp/state/cart_state.dart';
import 'package:foodapp/utils/utils.dart';
import 'package:foodapp/view_model/process_order/process_order_view_model.dart';

class ProcessOrderViewModelImp extends ProcessOrderViewModel {
  @override
  Future<bool> submitOrder(OrderModel orderModel,) {
    return writeOrderToFirebase(orderModel);
  }

//Future cai nay la de cgho caiu await , ccau say nay la de dung cho cai  load du lieu , con cai chuc nang binh thuong thi k can
  @override
  Future<OrderModel> createOrderModel(
      {@required String restaurantId,
        @required double discount,
        @required  String firstName,
        @required String lastName,
        @required String address,
        @required  String comment,
        @required  CartStateController cartStateController,
        @required  bool isCod
      }) async {
    var serverTime = await getServerTimeOffset();
    return new OrderModel(userId: FirebaseAuth.instance.currentUser.uid,
        userName: '$firstName$lastName',
        userPhone: FirebaseAuth.instance.currentUser.phoneNumber.toString(),
        shippingAddress: address,
        comment: comment,
        orderNumber: createOrderNumber(serverTime).toString(),
        restaurantId: restaurantId,
        totalPayment: cartStateController.getSubTotal(restaurantId),
        finalPayment: caculateFinalPayment(cartStateController.getSubTotal(restaurantId),discount),
        shippingCost: cartStateController.getShippingFee(restaurantId),
        discount: discount,
        isCod: isCod,
        cartItemList: cartStateController.getCart(restaurantId),
        orderStatus: 0,
        createDate: serverTime);
  }

}