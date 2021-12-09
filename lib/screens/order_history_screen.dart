import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/const/const.dart';
import 'package:foodapp/model/order_model.dart';
import 'package:foodapp/state/main_state.dart';
import 'package:foodapp/utils/const.dart';
import 'package:foodapp/view_model/order_history_vm/order_history_view_model_imp.dart';
import 'package:foodapp/widgets/order_history/order_history_widget.dart';
import 'package:get/get.dart';

class OrderHistory extends StatelessWidget {
  final vm = new OrderHistoryViewModelImp();
  final MainStateController mainStateController = Get.find();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Order History'),
            bottom: TabBar(
              tabs: [
                Tab(
                  icon: Icon(Icons.cancel),
                ),
                Tab(
                  icon: Icon(Icons.refresh),
                ),
                Tab(
                  icon: Icon(Icons.check),
                ),

              ],
            ),
          ),
          body: TabBarView(
            children: [
              OrderHistoryWidget(vm: vm, mainStateController: mainStateController, orderStatusModel: ORDER_CANCELLED,),
              OrderHistoryWidget(vm:vm,mainStateController:mainStateController,orderStatusModel:ORDER_PROCESSING),
              OrderHistoryWidget(vm:vm,mainStateController:mainStateController,orderStatusModel:ORDER_SHIPPED),

            ],
          )
        ),
      ),
    );
  }
}
