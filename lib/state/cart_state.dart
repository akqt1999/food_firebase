import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:foodapp/model/cart_model.dart';
import 'package:foodapp/model/food_model.dart';
import 'package:foodapp/utils/const.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CartStateController extends GetxController {
  var cart = List<CartModel>.empty(growable: true).obs;
  final box = GetStorage();

  List<CartModel> getCartAnonymous(String restaurantId) =>
      cart.where((item) => item.restaurantId == restaurantId &&
          (item.userUid == KEY_ANOUNYMOUS))
          .toList();

  List<CartModel> getCart(String restaurantId) =>
      cart.where((item) =>
      item.restaurantId == restaurantId && (
          FirebaseAuth.instance.currentUser == null ? item.userUid ==
              KEY_ANOUNYMOUS : item.userUid ==
              FirebaseAuth.instance.currentUser.uid
      )).toList();


  addToCart(FoodModel foodModel, String restaurantId, {int quantity: 1}) async {
    try {
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
          userUid: FirebaseAuth.instance.currentUser == null ? KEY_ANOUNYMOUS
              : FirebaseAuth.instance.currentUser.uid
      );
      if (isExists(cartItem,
          restaurantId)) { // if cart da ton tai thi se cap nhap so luong
          var foodNeedToUpdate=getCartNeedUpdate(cartItem, restaurantId);
          if(foodNeedToUpdate!=null)
        foodNeedToUpdate.quantity += quantity;
      }
      else {
        cart.add(cartItem);
      }
      // sau khi cap nhap thong tin,we will save no  vao storage
      var jsonDBEncode = jsonEncode(cart);
      await box.write(MY_CART_KEY, jsonDBEncode);
      cart.refresh(); //update
      Get.snackbar('Add Cart Success', 'your cart has been update');
    } catch (e) {
      Get.snackbar('Add Cart Error', e.toString());
    }
  }

  bool isExists(CartModel cartItem, String restaurantId) =>
      cart.any((element) =>
      element.id == cartItem.id && element.restaurantId == restaurantId &&
          element.userUid == (
              FirebaseAuth.instance.currentUser == null
                  ? KEY_ANOUNYMOUS
                  : FirebaseAuth.instance.currentUser.uid
          ));


  sumCart(String restaurantId) =>
      getCart(restaurantId).length == 0 ? 0 : cart.map((element) =>
      element.price * element.quantity)
          .reduce((value, element) => value + element);


  int getQuantity(String restaurantId) =>
      getCart(restaurantId).length == 0 ? 0 : cart.map((element) => element
          .quantity).reduce((value, element) => value + element);
  
  int getQuantityFirebase()=>cart.length==0?0:cart.map((element) => element.quantity)
      .reduce((value, element) => value+element);


  getShippingFee(String restaurantId) => sumCart(restaurantId) * 0.1;

  getSubTotal(String restaurantId) =>
      sumCart(restaurantId) + getShippingFee(restaurantId);

  clearCart(String restaurantId) {
    cart = getCart(restaurantId);
    cart.clear();
    saveDatabase();
  }

  saveDatabase() => box.write(MY_CART_KEY, jsonEncode(cart));

  void mergeCart(List<CartModel> cartItems, String restaurantId) {
    if (cart.length > 0) {
      cartItems.forEach((cartItem) {
        if (isExists(cartItem, restaurantId)) {
          var foodNeedToUpdate = getCartNeedUpdate(cartItem, restaurantId);
          if (foodNeedToUpdate != null) {
            foodNeedToUpdate.quantity += cartItem.quantity;
          } else {
            var newCart = cartItem;
            newCart.userUid = FirebaseAuth.instance.currentUser.uid;
            cart.add(newCart);
          }
        }
      });
    }
  }

  getCartNeedUpdate(CartModel cartItem, String restaurantId)=> cart.firstWhere((element) =>
      element.id == cartItem.id && element.restaurantId == restaurantId &&
  element.userUid ==
  (FirebaseAuth.instance.currentUser == null ? KEY_ANOUNYMOUS :
  FirebaseAuth.instance.currentUser.uid));
}