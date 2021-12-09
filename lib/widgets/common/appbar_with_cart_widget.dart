import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/screens/cart_screen.dart';
import 'package:foodapp/state/cart_state.dart';
import 'package:foodapp/state/main_state.dart';
import 'package:get/get.dart';

class AppbarWithCartButton extends StatelessWidget implements PreferredSizeWidget{
  final String title;
  final CartStateController cartStateController=Get.find();
  final MainStateController mainStateController=Get.find();

   AppbarWithCartButton({Key key, this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text('$title',style: TextStyle(color: Colors.black,fontStyle:FontStyle.italic ,fontWeight: FontWeight.w700),),
      elevation: 5,
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(color:Colors.black),
      actions: [
        Obx(()=>Badge(
          position: BadgePosition(top: 0,end: 1),
          animationDuration: Duration(milliseconds: 200),
          animationType: BadgeAnimationType.scale,
          showBadge: true,
          badgeColor: Colors.red,
          badgeContent: Text('${cartStateController.getQuantity(mainStateController.selectedRestaurant.value.restaurantId,)}',style: TextStyle(
              color: Colors.white
          ),),
          child: IconButton(onPressed: ()=>Get.to(()=>CartDetailScreen()),icon: Icon(Icons.shopping_bag),),
        ))
      ],
    );
  }
  @override
  Size get preferredSize =>Size.fromHeight(56.0);

}