import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_elegant_number_button/flutter_elegant_number_button.dart';
import 'package:foodapp/state/food_list_state.dart';
import 'package:foodapp/state/fool_detail_state.dart';
import 'package:get/get.dart';

class FoodDetailNameWidget extends StatelessWidget {
  const FoodDetailNameWidget({
    Key key,
    @required this.foodListStateController, this.foodDetailStateController,
  }) : super(key: key);

  final FoodListStateController foodListStateController;
  final FoodDetailStateController foodDetailStateController; 

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Container(
        // chua cai contain nay la de cho no co chieu cao , padding
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              '${foodListStateController.selectFood.value.name}',
              style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.w900),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween, // khoang trong o gua
              children: [
                Text(
                  '\$${foodListStateController.selectFood.value.price}',
                  style: TextStyle(fontSize: 17),
                ),
              Obx(( )=>ElegantNumberButton(
                  initialValue: foodDetailStateController.quantity.value,
                  minValue: 1,
                  maxValue: 100,
                  color: Colors.lime,
                  onChanged: (value) {
                    foodDetailStateController.quantity.value=value.toInt();
                  } ,
                  decimalPlaces: 1))
              ],
            )
          ],
        ),
      ),
    );
  }
}