import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:foodapp/strings/restaurant_home_string.dart';
import 'package:foodapp/view_model/menu_vm/menu_videwmodel_imp.dart';
import 'package:foodapp/widgets/menu/menu_widget.dart';
import 'package:foodapp/widgets/menu/home_menu_widget.dart';
import 'package:foodapp/widgets/menu/menu_widget_callback.dart';

class MenuScreen extends StatelessWidget {
  final ZoomDrawerController zoomDrawerController;
  final viewModel = MenuViewModelImp();

  MenuScreen(this.zoomDrawerController);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueAccent,
        body: SafeArea(
          child: Column(
            children: [
              Row(
                children: [
                  DrawerHeader(
                      child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 40),
                        child: CircleAvatar(
                          maxRadius: 40,
                          backgroundColor: Colors.black54,
                          child: Icon(
                            Icons.restaurant,
                            color: Colors.white,
                            size: 40,
                          ),
                        ),
                      )
                    ],
                  ))
                ],
              ),
              Divider(
                thickness: 1,
              ),
              HomeMenuWidget(zoomDrawerController: zoomDrawerController),
              // nay la cai nut cua cai divider

              Divider(
                thickness: 1,
              ),
              MenuWidget(
                  icon: Icons.list,
                  menuName: categoriesText,
                  callback: viewModel.navigateCategories),
              // chuyen toi danh muc cua cai nha hang do

              Divider(
                thickness: 1,
              ),
              MenuWidget(
                  icon: Icons.restaurant_rounded,
                  menuName: 'Restaurant List',
                  callback: viewModel.backToRestaurantList),

              Divider(
                thickness: 1,
              ),
              MenuWidget(
                  icon: Icons.shopping_cart_outlined,
                  menuName: 'Cart',
                  callback: viewModel.navigateCart),
              Divider(
                thickness: 1,
              ),
              MenuWidgetCallback(
                icon: Icons.list,
                menuName: 'Order history',
                callback: viewModel.checkLoginState(context)
                ?viewModel.viewOrderHistory:viewModel.login,
              ),
              // cai nay la cho no xuong duoi day lun
              Spacer(),
              Divider(
                thickness: 1,
              ),
              MenuWidgetCallback(
                icon: viewModel.checkLoginState(context)
                    ? Icons.logout
                    : Icons.login,
                menuName:
                    viewModel.checkLoginState(context) ? 'Logout' : 'Login',
                callback: viewModel.checkLoginState(context)
                    ? viewModel.logout
                    : viewModel.login,

              ),
            ],
          ),
        ));
  }
}
