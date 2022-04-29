import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_elegant_number_button/flutter_elegant_number_button.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:foodapp/model/cart_model.dart';
import 'package:foodapp/state/cart_state.dart';
import 'package:foodapp/state/main_state.dart';
import 'package:foodapp/view_model/cart_vm/cart_view_model_imp.dart';
import 'package:foodapp/widgets/cart/cart_image_widget.dart';
import 'package:foodapp/widgets/cart/cart_info_widget.dart';
import 'package:foodapp/widgets/cart/cart_total_widget.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CartDetailScreen extends StatelessWidget {
  final box = GetStorage();
  CartStateController controller = Get.find();
  CartViewModelImp cartViewModel = new CartViewModelImp();
  final MainStateController mainStateController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
        actions: [
          // trong cai action nay la them cai onPress vo
          controller.getQuantity(mainStateController
                      .selectedRestaurant.value.restaurantId) >
                  0
              ? IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    Get.defaultDialog(
                        title: 'Delete',
                        textCancel: 'Cancel',
                        textConfirm: 'Confirm',
                        middleText: 'do you want delete all item?',
                        buttonColor: Colors.red,
                        backgroundColor: Colors.white60,
                        confirmTextColor: Colors.yellow,
                        onConfirm: () => cartViewModel.clearCart(controller));
                  })
              : Container()
        ],
      ),
      body: controller.getQuantity(
                  mainStateController.selectedRestaurant.value.restaurantId) >
              0
          ? Obx(() => Column(
                children: [
                  Expanded(
                      child: ListView.builder(
                          itemCount: controller
                              .getCart(mainStateController
                                  .selectedRestaurant.value.restaurantId)
                              .length,
                          itemBuilder: (context, indext) => Slidable(
                                child: Card(
                                  elevation: 8.0,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 6),
                                  child: Container(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                            flex: 2,
                                            child: CartImageWidget(
                                              controller: controller,
                                              cartModel: controller.getCart(
                                                  mainStateController
                                                      .selectedRestaurant
                                                      .value
                                                      .restaurantId)[indext],
                                            )),
                                        Expanded(
                                            flex: 6,
                                            child: CartInfo(
                                              controller: controller,
                                              cartModel: controller.getCart(
                                                  mainStateController
                                                      .selectedRestaurant
                                                      .value
                                                      .restaurantId)[indext],
                                            )),
                                        Center(
                                          child: ElegantNumberButton(
                                            initialValue: controller
                                                .getCart(mainStateController
                                                    .selectedRestaurant
                                                    .value
                                                    .restaurantId)[indext]
                                                .quantity,
                                            minValue: 1,
                                            maxValue: 100,
                                            color: Colors.lime,
                                            onChanged: (value) {
                                              cartViewModel.updateCart(
                                                  controller,
                                                  mainStateController
                                                      .selectedRestaurant
                                                      .value
                                                      .restaurantId,
                                                  indext,
                                                  value.toInt());
                                            },
                                            decimalPlaces: 0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                endActionPane: ActionPane(
                                  motion: ActionPane(
                                    motion: ScrollMotion(),
                                    children: [
                                      SlidableAction(
                                          label: 'Delete',
                                          icon: Icons.delete,
                                          backgroundColor: Colors.red,
                                          foregroundColor: Colors.white,
                                          onPressed: (context) {
                                            cartViewModel.deleteCart(
                                                controller,
                                                mainStateController
                                                    .selectedRestaurant
                                                    .value
                                                    .restaurantId,
                                                indext);
                                          })
                                    ],
                                  ),
                                ),
                              ))),
                  TotalWidget(
                    controller: controller,
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => cartViewModel.processCheckout(
                          context,
                          controller.getCart(mainStateController
                              .selectedRestaurant.value.restaurantId)),
                      child: Text('Check out'),
                    ),
                  )
                ],
              ))
          : Center(
              child: Text(
                'your cart empty',
                style: TextStyle(fontSize: 29, fontWeight: FontWeight.w900),
              ),
            ),
    );
  }
}
