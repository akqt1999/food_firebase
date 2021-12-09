import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:foodapp/model/cart_model.dart';
import 'package:foodapp/screens/place_order_screen.dart';
import 'package:foodapp/state/cart_state.dart';
import 'package:foodapp/state/main_state.dart';
import 'package:foodapp/view_model/cart_vm/cart_view_model.dart';
import 'package:foodapp/view_model/menu_vm/menu_videwmodel_imp.dart';
import 'package:get/get.dart';

class CartViewModelImp implements CartViewModel {

  final MainStateController mainStateController=Get.find();
  final MenuViewModelImp menuViewModelImp =new MenuViewModelImp();

  @override
  void updateCart(CartStateController controller,String restaurantId, int index, int value) {
    controller.cart=controller.getCart(restaurantId);
    controller.cart[index].quantity = value.toInt();
    controller.cart.refresh();
    controller.saveDatabase();
  }
  @override
  void deleteCart(CartStateController controller, String restaurantId,int index) {
    controller.cart=controller.getCart(restaurantId);
    controller.cart.removeAt(index);
    controller.saveDatabase();
  }
  @override
  void clearCart(CartStateController controller) {
    controller.clearCart(  mainStateController.selectedRestaurant.value.restaurantId);
  }

  @override
  processCheckout(BuildContext context, List<CartModel> cart) {
    if(FirebaseAuth.instance.currentUser!=null){
            Get.to(()=>PlaceOrderScreen());
    }else{
          menuViewModelImp.login(context);
    }
  }
}
