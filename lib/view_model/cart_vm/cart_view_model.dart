import 'package:flutter/cupertino.dart';
import 'package:foodapp/model/cart_model.dart';
import 'package:foodapp/state/cart_state.dart';

abstract class CartViewModel{

  void updateCart(CartStateController controller,String restaurantId,int index,int value);

  void deleteCart(CartStateController controller,String restaurantId, int index);

  void clearCart(CartStateController controller);

  processCheckout(BuildContext context, List<CartModel> cart);

  
}