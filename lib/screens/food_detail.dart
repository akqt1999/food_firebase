import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:foodapp/model/size_model.dart';
import 'package:foodapp/state/category_state.dart';
import 'package:foodapp/state/food_list_state.dart';
import 'package:foodapp/state/fool_detail_state.dart';
import 'package:foodapp/utils/utils.dart';
import 'package:foodapp/widgets/food_detail/food_detail_description.dart';
import 'package:foodapp/widgets/food_detail/food_detail_image_widget.dart';
import 'package:foodapp/widgets/food_detail/food_detail_name_widget.dart';
import 'package:foodapp/widgets/food_detail/food_detail_size_widget.dart';
import 'package:get/get.dart';

class FoodDetailScreen extends StatelessWidget {
  final CategoryStateController categoryStateController = Get.find();
  final FoodListStateController foodListStateController =
      Get.find(); //FoodListStateController
  final FoodDetailStateController foodDetailStateController =
      Get.put(FoodDetailStateController()); // so luong cua thay doi

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            //mat dinh la sai cai scafold nay
            body: Center(
      child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            //hien ra cai hinh no troi di khi vuot
            return [
              SliverAppBar(
                // sliver app bar cai nay dung de tao ra hien an treen cai sliver bar

                title: Text(
                  '${foodListStateController.selectFood.value.name}',
                  style: TextStyle(color: Colors.black),
                ),
                elevation: 10,
                backgroundColor: Colors.white,
                iconTheme: IconThemeData(color: Colors.black),
                bottom: PreferredSize(
                  preferredSize: Size.square(foodDetailImageAreaSize(context)),
                  //kich thuoc cua chieu doc cua cai title bar
                  child: FoodDetailImageWidget(foodListStateController: foodListStateController),
                ),
              )
            ];
          },
          body: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.only(top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  FoodDetailNameWidget(
                    foodListStateController: foodListStateController,
                    foodDetailStateController: foodDetailStateController,
                  ),
                  FoodDetailDescriptionWidget(
                      foodListStateController: foodListStateController),
                  // check if food have size
                  FoodDetailSizeWidget(
                      foodListStateController: foodListStateController,
                      foodDetailStateController: foodDetailStateController),
                  Card(
                    elevation: 10,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Obx(() => ExpansionTile(
                                //Obx cai nay no se lam cho luong tuong giua cai get de thay doi trang thai
                                title: Text(
                                  'Addon',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.blueAccent),
                                ),

                                children: [
                                  Wrap(
                                    children: foodListStateController
                                        .selectFood.value.addon
                                        .map((e) => Padding(
                                              padding: const EdgeInsets.all(8),
                                              child: ChoiceChip(
                                                label: Text(e.name),
                                                selected:
                                                    foodDetailStateController
                                                        .selectAddon
                                                        .contains(e),
                                                selectedColor: Colors.amber,
                                                onSelected: (selected) => selected
                                                    ? foodDetailStateController
                                                        .selectAddon
                                                        .add(e)
                                                    : foodDetailStateController
                                                        .selectAddon
                                                        .remove(e),
                                              ),
                                            ))
                                        .toList(),
                                  )
                                ],
                              ))
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          )),
    )));
  }
}
