import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/state/cart_state.dart';
import 'package:foodapp/state/food_list_state.dart';
import 'package:foodapp/state/fool_detail_state.dart';
import 'package:foodapp/state/main_state.dart';
import 'package:foodapp/utils/utils.dart';
import 'package:foodapp/view_model/process_cart/process_cart_view_model_imp.dart';
import 'package:get/get.dart';

class FoodDetailImageWidget extends StatelessWidget {
  final MainStateController mainStateController = Get.find();

  FoodDetailImageWidget({
    Key key,
    @required this.foodListStateController,
  }) : super(key: key);

  final FoodListStateController foodListStateController;
  final CartStateController cartStateController = Get.find();
  final FoodDetailStateController foodDetailStateController = Get.find();
  final addCartVM=ProcessCartViewModelImp();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            width: double.infinity,
            // max width
            height: foodDetailImageAreaSize(context) * 0.9,
            // kich thuoc cai hinh nhin tu phia tren
            child: Hero(
              tag: foodListStateController.selectFood.value.name,
              child: CachedNetworkImage(
                  imageUrl: foodListStateController.selectFood.value.image,
                  fit: BoxFit.cover,
                  errorWidget: (context, url, error) => Center(
                        child: Icon(Icons.image),
                      ),
                  progressIndicatorBuilder: (context, url, progress) => Center(
                        child: CircularProgressIndicator(),
                      )),
            )), // max with
        Align(
          alignment: const Alignment(0.8, 1.0), //1.0 cai nay la cai chieu cao
          heightFactor: 0.5,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 8),
            // cai khoang cach cua no ve ben trai
            child: Row(
              // hang hang
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FloatingActionButton(
                  heroTag: "Fav",
                  onPressed: () {},
                  child: Icon(Icons.favorite_border, color: Colors.black),
                  backgroundColor: Colors.white,
                  elevation: 8, //elevation :cai bong
                ),
                FloatingActionButton(
                  heroTag: "Cart",
                  onPressed: () async {
                    // cartStateController.addToCart(
                    //   foodListStateController.selectFood.value,
                    //   mainStateController.selectedRestaurant.value.restaurantId,
                    //   quantity: foodDetailStateController.quantity.value,
                    // ),
                    var result= await  addCartVM.submitCart(foodListStateController.selectFood.value,
                       mainStateController.selectedRestaurant.value.restaurantId,
                        quantity: foodDetailStateController.quantity.value);
                    Get.defaultDialog(
                        title: result?'addCart success':'addCart fail',
                        middleText: result?'addCart success':'addCart fail',
                        textConfirm: 'Confirm',
                        textCancel: 'Cancel',
                        confirmTextColor: Colors.yellow,
                        onConfirm: (){});
                  },
                  child: Icon(Icons.add_shopping_cart, color: Colors.black),
                  backgroundColor: Colors.white,
                  elevation: 8, //elevation :cai bong
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
