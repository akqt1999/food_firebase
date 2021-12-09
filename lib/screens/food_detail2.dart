import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:foodapp/state/category_state.dart';
import 'package:foodapp/state/food_list_state.dart';
import 'package:foodapp/utils/utils.dart';
import 'package:foodapp/widgets/food_detail/food_detail_image_widget.dart';
import 'package:foodapp/widgets/food_detail/food_detail_name_widget.dart';
import 'package:get/get.dart';

class FoodDetailScreen2 extends StatelessWidget {
   final CategoryStateController categoryStateController = Get.find();
  final FoodListStateController foodListStateController = Get.find();

  @override
  Widget build(BuildContext context) {
    print('dfsdf');
    return SafeArea(
        child: Scaffold(
            //mat dinh la sai cai scafold nay
            body: Center(
                child: NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return [
          SliverAppBar(
            // sliver app bar cai nay dung de tao ra hien an treen cai sliver bar

            title: Text(
              // '${foodListStateController.selectFood.value.name}',
              'cai lon ne',
              style: TextStyle(color: Colors.black),
            ),
            elevation: 10,
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(color: Colors.black),
            bottom: PreferredSize(
              preferredSize: Size.square(foodDetailImageAreaSize(context) ),
              //kich thuoc cua chieu doc cua cai title bar
              child: FoodDetailImageWidget(foodListStateController: foodListStateController),
                   // Text('cccc') ,
            ),
          )
        ];
      },
      body: Container(
        // margin: const EdgeInsets.only(top: 10),
        // child: Column(
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   mainAxisAlignment: MainAxisAlignment.start,
        //   children: [
        //      FoodDetailNameWidget(foodListStateController: foodListStateController),
        //     Card(
        //        elevation: 10,
        //
        //       child: Container(
        //         // chua cai contain nay la de cho no co chieu cao , padding
        //         // width: double.infinity,
        //         // padding: const EdgeInsets.all(16),
        //         // child: Column(
        //         //   crossAxisAlignment: CrossAxisAlignment.start,
        //         //   mainAxisAlignment: MainAxisAlignment.start,
        //         //   children: [
        //         //   RatingBar.builder(
        //         //       initialRating: 5,
        //         //       minRating: 1,
        //         //       direction:Axis.horizontal ,
        //         //       allowHalfRating: false,
        //         //
        //         //       itemBuilder: (context,_){
        //         //       return Icon(Icons.star,color:Colors.lime);
        //         //   }, onRatingUpdate: (value){
        //         //
        //         //   }),
        //         //     SizedBox(
        //         //       height: 10,
        //         //     ),
        //         //     // Text(
        //         //     //   '${foodListStateController.selectFood.value.name}',
        //         //     //   style: TextStyle(
        //         //     //       fontSize: 20, fontWeight: FontWeight.w900),
        //         //     // ),
        //         //   ],
        //         // ),
        //       ),
        //     )
        //   ],
        // ),
      ),
    ))));
  }
}
