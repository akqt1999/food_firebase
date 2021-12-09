import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/state/cart_state.dart';
import 'package:foodapp/state/main_state.dart';
import 'package:foodapp/utils/utils.dart';
import 'package:get/get.dart';

import 'cart_total_item_widget.dart';

class TotalWidget extends StatelessWidget {
   TotalWidget({
    Key key,
    this.controller,
  }) : super(key: key);

  final CartStateController controller;
  final MainStateController mainStateController=Get.find();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 12,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TotalItemWidget(
              text: 'Total',
              value: currencyFormat.format(controller.sumCart(  mainStateController.selectedRestaurant.value.restaurantId)),
              isSubTotal: false,
            ),
            Divider(
              thickness: 2,
            ),
            TotalItemWidget(
              text: 'shipping Fee',
              value: currencyFormat.format(controller.getShippingFee(mainStateController.selectedRestaurant.value.restaurantId)),
              isSubTotal: false,
            ),
            Divider(
              thickness: 2,
            ),
            TotalItemWidget(
              text: 'Sub Total',
              value: currencyFormat.format(controller.getSubTotal(mainStateController.selectedRestaurant.value.restaurantId)),
              isSubTotal: true,
            ),
          ],
        ),
      ),
    );
  }
}
