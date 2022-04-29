import 'dart:ui';

import 'package:auto_animated/auto_animated.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:foodapp/model/popular_item_model.dart';
import 'package:foodapp/state/main_state.dart';
import 'package:foodapp/strings/restaurant_home_string.dart';
import 'package:foodapp/view_model/process_cart/process_cart_view_model.dart';
import 'package:foodapp/view_model/process_cart/process_cart_view_model_imp.dart';
import 'package:foodapp/view_model/restaurant_home_detail_vm/restaurant_home_detail_vm.dart';
import 'package:foodapp/view_model/restaurant_home_detail_vm/restaurant_home_detail_vm_imp.dart';
import 'package:foodapp/widgets/common/common_widgets.dart';
import 'package:foodapp/widgets/restaurant_home_detail/best_detail_widget.dart';
import 'package:foodapp/widgets/restaurant_home_detail/most_popular_widget.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class RestaurantHomeDetail extends  StatelessWidget{
  final MainStateController mainStateController = Get.find(); /// do cai nay da duoc gan roi nen khong can khoi taop
  final RestaurantHomeDetailViewModel viewModel = RestaurantDetailViewModelImp();
  final ZoomDrawerController  zoomDrawerController;
  final ProcessCartViewModel cartViewModel=ProcessCartViewModelImp();

  RestaurantHomeDetail({this.zoomDrawerController});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              '${mainStateController.selectedRestaurant.value.name}',
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.w900),
            ),
            backgroundColor: Colors.white38,
            elevation: 10,
            iconTheme: IconThemeData(color: Colors.blueAccent),
            leading: InkWell(child:Icon(// khi nhan vao day thi no se show ra cai drawer
                Icons.view_headline),onTap: ()=>zoomDrawerController.toggle(),),
          ),
          body: Container(
            padding: const EdgeInsets.all(8),
            child: Column (
            children: [
                Expanded(
                  flex: 1,
                  child: MostPopularWidget(
                    viewModel: viewModel,
                    mainStateController: mainStateController,
                  ),
                ),
                Expanded(
                    flex: 2,
                    child: BestDetailWidget(viewModel: viewModel, mainStateController: mainStateController)
                ),
              ],
            ),
          ),
        ));
  }
}