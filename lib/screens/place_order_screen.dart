import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/screens/restaurant_home.dart';
import 'package:foodapp/state/cart_state.dart';
import 'package:foodapp/state/main_state.dart';
import 'package:foodapp/state/place_order_state.dart';
import 'package:foodapp/utils/const.dart';
import 'package:foodapp/view_model/process_order/process_order_view_model_imp.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';

class PlaceOrderScreen extends StatelessWidget {
  var placeOrderState = Get.put(PlaceOrderController());

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final addressController = TextEditingController();
  final commentController = TextEditingController();
  final placeOrderVM = new ProcessOrderViewModelImp();
  final CartStateController cartStateController = Get.find();
  final MainStateController mainStateController = Get.find();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            // nay la de lam cai ban phim khi no de len thi no se k lam cho, de len
            appBar: AppBar(
              title: Text('Place Order'),
            ),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                            child: TextFormField(
                          controller: firstNameController,
                          validator: ValidationBuilder(
                                  requiredMessage: 'first name is required')
                              .required()
                              .build(),
                          decoration: InputDecoration(
                              hintText: 'First Name',
                              labelText: 'First Name',
                              border: OutlineInputBorder()),
                        )), //Expanded chi ap dung vs row
                        SizedBox(
                          width: 8,
                        ),
                        Expanded(
                            child: TextFormField(
                          controller: lastNameController,
                          validator: ValidationBuilder(
                                  requiredMessage: 'last name is required')
                              .required()
                              .build(),
                          decoration: InputDecoration(
                              hintText: 'last name',
                              labelText: 'last name',
                              border: OutlineInputBorder()),
                        ))
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // cai nay la gu qyen roi,
                      children: [
                        TextFormField(
                          controller: addressController,
                          validator: ValidationBuilder(
                                  requiredMessage: 'address is required')
                              .required()
                              .build(),
                          decoration: InputDecoration(
                              hintText: 'address',
                              labelText: 'address',
                              border: OutlineInputBorder()),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Obx(() => Column(
                          children: [
                            Text(
                              'payment',
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                            RadioListTile<String>(
                                title: const Text('Cash on delivery'),
                                value: COD_VAL,
                                groupValue:
                                    placeOrderState.paymentSelected.value,
                                onChanged: (String val) {
                                  placeOrderState.paymentSelected.value = val;
                                }),
                            RadioListTile<String>(
                                title: Text('brain tree'),
                                value: BRAINTREE_VAL,
                                groupValue:
                                    placeOrderState.paymentSelected.value,
                                onChanged: (String val) {
                                  placeOrderState.paymentSelected.value = val;
                                })
                          ],
                        )),
                    SizedBox(height: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          controller: commentController,
                          validator: ValidationBuilder(
                                  requiredMessage: 'Comment is require')
                              .required()
                              .build(),
                          decoration: InputDecoration(
                              hintText: 'Comment',
                              border: OutlineInputBorder(),
                              labelText: 'Comment'),
                        )
                      ],
                    ),
                    Spacer(),
                    Container(
                      width: double.infinity,
                      child: ElevatedButton(
                        child: Text('place Order'),
                        onPressed: () async{
                          if (formKey.currentState.validate()) {
                            var order = await placeOrderVM.createOrderModel(
                                restaurantId: mainStateController.selectedRestaurant.value.restaurantId,
                                discount: 0,
                                firstName: firstNameController.text,
                                lastName: lastNameController.text,
                                address: addressController.text,
                                comment: commentController.text,
                                cartStateController: cartStateController,
                                isCod: placeOrderState.paymentSelected.value==COD_VAL?true:false);

                            var result=await placeOrderVM.submitOrder(order);
                            Get.defaultDialog(
                              title: result?'Order success':'Order fail',
                              middleText: result?'your order has been placed':'your order submit failed',
                              textConfirm: 'Confirm',
                              confirmTextColor: Colors.yellow,
                              onConfirm: (){
                                Get.offAll(()=>RestaurantHome());
                              });
                          }
                        },
                      ),
                    )
                  ],
                ),
              ),
            )));
  }
}
