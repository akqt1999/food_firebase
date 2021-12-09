import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/model/cart_model.dart';
import 'package:foodapp/model/popular_item_model.dart';
import 'package:foodapp/state/cart_state.dart';
import 'package:foodapp/state/main_state.dart';
import 'package:foodapp/strings/restaurant_home_string.dart';
import 'package:foodapp/view_model/process_cart/process_cart_view_model.dart';
import 'package:foodapp/view_model/restaurant_home_detail_vm/restaurant_home_detail_vm.dart';
import 'package:foodapp/widgets/common/common_widgets.dart';
import 'package:get/get.dart';

class MostPopularWidget extends StatelessWidget {
  final RestaurantHomeDetailViewModel viewModel;
  final MainStateController mainStateController;
   MostPopularWidget({Key key, this.viewModel, this.mainStateController})
      : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: viewModel.displayMostPopularByRestaurantId(
            mainStateController.selectedRestaurant.value.restaurantId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(
              child: CircularProgressIndicator(),
            );
          else {
            var lstPopular = snapshot.data as List<PopularItemModel>;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(mostPopularText,
                    style: (TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Colors.black54,
                        fontSize: 24))),
                Expanded(
                  child: LiveList(
                    showItemInterval: Duration(milliseconds: 350),
                    showItemDuration: Duration(milliseconds: 150),
                    reAnimateOnVisibility: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: lstPopular.length,
                    itemBuilder: animationItemBuilder((index) => Container(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                backgroundImage:
                                    NetworkImage(lstPopular[index].image),
                                minRadius: 40,
                                maxRadius: 60,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              // khoang cach cho cai hinh voi cai chu
                              Text(
                                lstPopular[index].name,
                                style: (TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                )),
                              )
                            ],
                          ),
                        )),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
