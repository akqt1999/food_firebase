import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/model/size_model.dart';
import 'package:foodapp/state/food_list_state.dart';
import 'package:foodapp/state/fool_detail_state.dart';
import 'package:get/get.dart';

class FoodDetailSizeWidget extends StatelessWidget {
  const FoodDetailSizeWidget({
    Key key,
    @required this.foodListStateController,
    @required this.foodDetailStateController,
  }) : super(key: key);

  final FoodListStateController foodListStateController;
  final FoodDetailStateController foodDetailStateController;

  @override
  Widget build(BuildContext context) {
    return foodListStateController.selectFood.value.size.length > 0
        ?  Card(
      elevation: 10,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Obx(() => ExpansionTile(  //Obx cai nay no se lam cho luong tuong giua cai get de thay doi trang thai
              title: Text(
                'Size',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: Colors.blueAccent),
              ),

              children: foodListStateController
                  .selectFood.value.size
                  .map((e) => RadioListTile<SizeModel>(
                  title: Text(e.name),
                  value: e,
                  groupValue: foodDetailStateController
                      .selectSize.value, // nho cai group value nay thi no se thay doi
                  onChanged: (value) =>
                  foodDetailStateController
                      .selectSize.value = value
              ))
                  .toList(),
            ))
          ],
        ),
      ),
    ): Container();
  }
}