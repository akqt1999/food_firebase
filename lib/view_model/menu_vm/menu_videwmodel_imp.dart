import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_auth_ui/flutter_auth_ui.dart';
import 'package:foodapp/screens/cart_screen.dart';
import 'package:foodapp/screens/category.dart';
import 'package:foodapp/screens/order_history_screen.dart';
import 'package:foodapp/screens/restaurant_home.dart';
import 'package:foodapp/state/cart_state.dart';
import 'package:foodapp/state/main_state.dart';
import 'package:foodapp/utils/const.dart';
import 'package:foodapp/view_model/menu_vm/menu_viewmodel.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class MenuViewModelImp implements MenuViewModel {
  
  final cartState=Get.put(CartStateController());
  final mainState=Get.put(MainStateController());



  @override
  void navigateCategories() {
    Get.to(() => CategoryScreen());
  }

  @override
  void backToRestaurantList() {
    Get.back(closeOverlays: true, canPop: false);
  }

  @override
  bool checkLoginState(BuildContext context) {
    return FirebaseAuth.instance.currentUser != null ? true : false;
  }

  @override
  void login(BuildContext context) {
    var user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      FlutterAuthUi.startUi(
          items: [AuthUiItem.AuthPhone],
          tosAndPrivacyPolicy: TosAndPrivacyPolicy(
              tosUrl: 'https://google.com',
              privacyPolicyUrl: 'https://youtube.com'),
          androidOption: AndroidOption(
            enableSmartLock: false,
          )).then((value) async {
       // navigationHome(context);
        Get.back();
      }).catchError((e) {
        Get.snackbar('error', '$e');
      });
    }
  }

  @override
  void logout(BuildContext context) {
    print('click logout');
    Get.defaultDialog(title:'Logout',
      content: Text('do you want to sign out?'),
      backgroundColor: Colors.white,
      cancel: ElevatedButton(onPressed: ()=>Get.back(),child: Text('Cancel'),),
      confirm: ElevatedButton(onPressed: (){
        FirebaseAuth.instance
            .signOut()
            .then((value) => Get.offAll(RestaurantHome()));

      }, child: Text('sign out',style: TextStyle(color:Colors.red),))
    );
  }

  @override
  Future<void> navigationHome(BuildContext context) async {
    var token = await FirebaseAuth.instance.currentUser.getIdToken();
    var box = GetStorage();
    box.write(KEY_TOKEN, token);

    //clone cart
    if(cartState.cart.length>0) // check if cart not empty
      {
        var newCart=cartState.getCartAnonymous(mainState.selectedRestaurant.value.restaurantId);
          cartState.mergeCart(newCart ,
          mainState.selectedRestaurant.value.restaurantId);
        cartState.saveDatabase();
      }
    Get.offAll(()=>RestaurantHome());
  }
  @override
  void navigateCart()=>Get.to(()=>CartDetailScreen());

  @override
  void viewOrderHistory(BuildContext context) {
      Get.to(()=>OrderHistory());
  }
}
