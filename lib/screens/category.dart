import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/model/category_model.dart';
import 'package:foodapp/state/cart_state.dart';
import 'package:foodapp/state/category_state.dart';
import 'package:foodapp/state/main_state.dart';
import 'package:foodapp/strings/restaurant_home_string.dart';
import 'package:foodapp/view_model/category_vm/category_viewmodel_imp.dart';
import 'package:foodapp/widgets/category/category_list_widget.dart';
import 'package:foodapp/widgets/common/appbar_with_cart_widget.dart';
import 'package:get/get.dart';

class CategoryScreen extends StatelessWidget {

  final viewModel=CategoryVieModelImp();
  final MainStateController mainStateController=Get.find();
  final CategoryStateController categoryStateController=Get.put(CategoryStateController());
  final CartStateController cartStateController=Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppbarWithCartButton(title: '${mainStateController.selectedRestaurant.value.name}',),
      body: FutureBuilder( //FutureBuilder cai nay dung de kiem tra load du lieu , neu trong thang thai dang load thi no se show process bar ,show xong roi thi no se thuc hien cai chuong trinh da load xong
        future: viewModel.displayCategoryByRestaurantId(mainStateController.selectedRestaurant.value.restaurantId), // cai nay dung de load du lieu from firebase
        builder: (context,snapshot){
          if(snapshot.connectionState==ConnectionState.waiting) // neu no dang laod thi nos se show len cai processbar
            return Center(child: CircularProgressIndicator(),);
          else{
            var lst=snapshot.data as List<CategoriesModel>;
            return Container(
              margin: const EdgeInsets.only(top: 10),
              child: CategoryListWidget(lst: lst,categoryStateController: categoryStateController)
            );

          }
        },
      ),
    );
  }
}


