import 'dart:convert';

import 'package:auto_animated/auto_animated.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/model/cart_model.dart';
import 'package:foodapp/model/restaurant_model.dart';
import 'package:foodapp/screens/restaurant_home.dart';
import 'package:foodapp/state/cart_state.dart';
import 'package:foodapp/state/main_state.dart';
import 'package:foodapp/strings/main_strings.dart';
import 'package:foodapp/utils/const.dart';

import 'package:foodapp/view_model/main_vm/main_view_model_imp.dart';
import 'package:foodapp/view_model/process_cart/process_cart_view_model_imp.dart';
import 'package:foodapp/widgets/common/common_widgets.dart';
import 'package:foodapp/widgets/main/main_widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  FirebaseApp app = await Firebase.initializeApp(); // khoi tai firebase
  runApp(MyApp(app: app));
}

class MyApp extends StatelessWidget {
  final FirebaseApp app;

  MyApp({@required this.app});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(     // cai nay la getx

    title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(app: app),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final FirebaseApp app;
  final viewModel = MainViewModelImp();
  final mainStateController = Get.put(MainStateController());
  final box = GetStorage();


  final cartViewModel=new ProcessCartViewModelImp();
  final cartStateController = Get.put(CartStateController());


  MyHomePage({@required this.app});

  @override
  MyHomePageState createState() => MyHomePageState(); // nay phai co cai widget nay nhu la de khoi tao
}

class MyHomePageState extends State<MyHomePage> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {

      if (widget.box.hasData(MY_CART_KEY)) {
          var cartSave=await widget.box.read(MY_CART_KEY) as String;
          if(cartSave.length>0&&cartSave.isNotEmpty){
            final listCart=jsonDecode(cartSave) as List<dynamic>;
            final listCartParsed=listCart.map((e) => CartModel.fromJson(e)).toList();
            if(listCartParsed.length>0)
              widget.cartStateController.cart.value=listCartParsed;
          }
      }
      else{
        widget.cartStateController.cart.value=new List<CartModel>.empty(growable: true);
      }
     // await widget.cartViewModel.displayCarts(restaurantId)
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          restaurantText,
          style: (TextStyle(
              fontWeight: FontWeight.w900, fontSize: 20, color: Colors.black)),
        ),
        elevation: 10,
      ),
      body: FutureBuilder(

        //FutureBuilder cai nay dung de kiem tra load du lieu , neu trong thang thai dang load thi no se show process bar ,show xong roi thi no se thuc hien cai chuong trinh da load xong
        future: widget.viewModel.displayRestaurantList(),
        // cai nay dung de load du lieu from firebase
        builder: (context, snapshot) {
          if (snapshot.connectionState ==
              ConnectionState
                  .waiting) // neu no dang laod thi nos se show len cai processbar
            return Center(
              child: CircularProgressIndicator(),
            );
          else {
            var lst = snapshot.data as List<RestaurantModel>;
            return Container(
              margin: const EdgeInsets.only(top: 10),
              child: LiveList(
                // cai nay la hieu ung , chinh
                showItemDuration: Duration(microseconds: 350),
                showItemInterval: Duration(milliseconds: 150),
                reAnimateOnVisibility: true,
                scrollDirection: Axis.vertical,
                itemCount: lst.length,

                itemBuilder: animationItemBuilder((index) => InkWell(
                      onTap: () {
                        widget.mainStateController.selectedRestaurant.value =
                            lst[index];
                        Get.to(() => RestaurantHome());
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height / 2.5 * 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RestaurantImageWidget(
                                imageUrl: lst[index].imageUrl),
                            RestaurantInfoWidget(
                              name: lst[index].name,
                              address: lst[index].address,
                            )
                          ],
                        ),
                      ),
                    )),
              ),
            );
          }
        },
      ),
    );
  }
}


