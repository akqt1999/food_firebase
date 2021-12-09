import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/model/popular_item_model.dart';
import 'package:foodapp/state/main_state.dart';
import 'package:foodapp/view_model/restaurant_home_detail_vm/restaurant_home_detail_vm.dart';

class BestDetailWidget extends StatelessWidget {
  const BestDetailWidget({
    Key key,
    @required this.viewModel,
    @required this.mainStateController,
  }) : super(key: key);

  final RestaurantHomeDetailViewModel viewModel;
  final MainStateController mainStateController;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: viewModel.displayBestDeatailByRestaurantId(
            mainStateController
                .selectedRestaurant.value.restaurantId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            var lstBestDetail =
            snapshot.data as List<PopularItemModel>;
            return CarouselSlider(
                items: lstBestDetail
                    .map((e) => Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width:
                      MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(
                          horizontal: 5.0),
                      // KHOANG cach giua no voi xung quanh
                      child: Card(
                        semanticContainer: true,
                        clipBehavior:
                        Clip.antiAliasWithSaveLayer,
                        // su ly hinh anh
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            ImageFiltered(
                              imageFilter: ImageFilter.blur(
                                  sigmaX: 5, sigmaY: 5),
                              child: CachedNetworkImage(
                                imageUrl: e.image,
                                fit: BoxFit.cover,
                                errorWidget:
                                    (context, url, err) =>
                                    Center(
                                      child: Icon(Icons.image),
                                    ),
                                progressIndicatorBuilder:
                                    (context, url,
                                    dowloadProcess) =>
                                    Center(
                                      child:
                                      CircularProgressIndicator(),
                                    ),
                              ),
                            ),
                            Center(
                                child: Text('${e.name}',style: TextStyle(
                                  fontWeight: FontWeight.w700,fontSize: 23,
                                ),
                                )
                            )
                          ],
                        ),
                      ),
                    );
                  },
                )).toList(),
                options: CarouselOptions(
                  // khi  nao m moi nhgiem tuc day, m nghi m toi luc di lam m se nghiem tuc a ,
                    autoPlay: true,
                    autoPlayAnimationDuration: Duration(seconds: 3),
                    // thoi gian de no luowc anh toi
                    autoPlayCurve: Curves.easeIn,
                    height: double.infinity));
          }
        },
      ),
    );
  }
}