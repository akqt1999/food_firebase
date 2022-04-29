import 'package:auto_animated/auto_animated.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/screens/food_detail.dart';
import 'package:foodapp/state/cart_state.dart';
import 'package:foodapp/state/category_state.dart';
import 'package:foodapp/state/food_list_state.dart';
import 'package:foodapp/state/main_state.dart';
import 'package:foodapp/widgets/common/appbar_with_cart_widget.dart';
import 'package:foodapp/widgets/common/common_widgets.dart';
import 'package:get/get.dart';

class FoodListScreen extends StatelessWidget {
  final CategoryStateController categoryStateController = Get.find();
  final FoodListStateController foodListStateController =
      Get.put(FoodListStateController());
  final CartStateController cartStateController = Get.find();
  final MainStateController mainStateController = Get.find();

  @override
  Widget build(BuildContext context) {
    print('build food list');
    return Scaffold(
      appBar: AppbarWithCartButton(
        title: '${categoryStateController.selectedCategory.value.name}',
      ),
      body: Column(
        children: [
          Expanded(
              child: LiveList(
            // livelist la cai animation
            showItemDuration: Duration(milliseconds: 300),
            // thoi gian load 1 cai muc
            showItemInterval: Duration(milliseconds: 300),
            //thoi gian load 1 cai hang
            reAnimateOnVisibility: true,
            scrollDirection: Axis.vertical,
            // cuon theo chieu nao
            itemCount:
                categoryStateController.selectedCategory.value.foods.length,

            itemBuilder: animationItemBuilder((index) => InkWell(
                  onTap: () {
                    foodListStateController.selectFood.value =
                        categoryStateController
                            .selectedCategory.value.foods[index];
                    Get.to(() => FoodDetailScreen());
                  },
                  child: Hero(
                    tag: categoryStateController
                        .selectedCategory.value.foods[index].name,
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height / 6 * 2,
                      // 6/2 la cai chieu rong chieu cao
                      child: Card(
                        semanticContainer: true,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        // su ly hinh anh
                        child: Stack( // chong len nhau
                          fit: StackFit.expand,
                          children: [
                            CachedNetworkImage(
                              imageUrl: categoryStateController
                                  .selectedCategory.value.foods[index].image,
                              fit: BoxFit.cover,
                              errorWidget: (context, url, err) => Center(
                                child: Icon(Icons.image),
                              ),
                              progressIndicatorBuilder:
                                  (context, url, dowloadProcess) => Center(
                                child: CircularProgressIndicator(),
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                color: Colors.black26,
                                child: Row( // ban dau cho cai row nay la muon tat ca o giua
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 20, bottom: 20),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min, //
                                        children: [
                                          Text(
                                            '${categoryStateController.selectedCategory.value.foods[index].name}',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18),
                                          ),
                                          Text(
                                            'Price: \$${categoryStateController.selectedCategory.value.foods[index].price}',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18),
                                          ),
                                          Row(
                                            children: [
                                              IconButton(
                                                  icon: Icon(
                                                    Icons.favorite_border,
                                                    color: Colors.white,
                                                  ),
                                                  onPressed: () {}),
                                              SizedBox(
                                                width: 30,
                                              ),
                                              IconButton(
                                                  icon: Icon(
                                                    Icons.add_shopping_cart,
                                                    color: Colors.white,
                                                  ),
                                                  onPressed: () =>
                                                      cartStateController.addToCart(
                                                          categoryStateController
                                                              .selectedCategory
                                                              .value
                                                              .foods[index],
                                                          mainStateController
                                                              .selectedRestaurant
                                                              .value
                                                              .restaurantId))
                                            ],
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                )),
          ))
        ],
      ),
    );
  }
}
