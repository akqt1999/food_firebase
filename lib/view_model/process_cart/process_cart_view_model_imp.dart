import 'package:firebase_auth/firebase_auth.dart';
import 'package:foodapp/firebase/cart_reference.dart';
import 'package:foodapp/model/cart_model.dart';
import 'package:foodapp/model/food_model.dart';

import 'package:foodapp/view_model/process_cart/process_cart_view_model.dart';

class ProcessCartViewModelImp extends ProcessCartViewModel{
  @override
  Future<bool> submitCart( FoodModel foodModel,String restaurantId, {int quantity: 1}) {
    var cartItem = CartModel(

        id: foodModel.id,
        name: foodModel.name,
        image: foodModel.image,
        price: foodModel.price,
        size: foodModel.size,
        addon: foodModel.addon,
        description: foodModel.description,
        quantity: quantity,
        restaurantId: restaurantId,
        userUid:FirebaseAuth.instance.currentUser.uid
    );
        return writeCartToFirebase(cartItem);
  }

  @override
  Future<List<CartModel>> displayCarts(String restaurantId) {
    return getCarts(restaurantId);
  }
}
