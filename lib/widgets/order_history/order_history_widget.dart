import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/model/order_model.dart';
import 'package:foodapp/state/main_state.dart';
import 'package:foodapp/state/order_history_state.dart';
import 'package:foodapp/view_model/order_history_vm/order_history_view_model_imp.dart';
import 'package:get/get.dart';

import 'order_list_widget.dart';

class OrderHistoryWidget extends StatelessWidget {
   OrderHistoryWidget({
    Key key,
    @required this.vm,
    @required this.mainStateController,
    @required this.orderStatusModel, this.OrderStatusModel
  }) : super(key: key);

  final OrderHistoryViewModelImp vm;
  final MainStateController mainStateController;
  final String orderStatusModel;
  final String OrderStatusModel;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: vm.getUserHistory(
          mainStateController.selectedRestaurant.value.restaurantId,orderStatusModel),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          var lst = snapshot.data as List<OrderModel>;
          if(lst.length==0){
            return Center(child: Text('Empty',style: TextStyle(
              fontSize: 30,fontWeight: FontWeight.bold,color: Colors.red
            ),),);
          }
          return OrderHistoryListWidget(listOrder: lst,);
        }
      },
    );
  }
}
