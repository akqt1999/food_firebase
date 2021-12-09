import 'package:auto_animated/auto_animated.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/model/order_model.dart';
import 'package:foodapp/screens/order_view_detail_screen.dart';
import 'package:foodapp/state/order_history_state.dart';
import 'package:foodapp/utils/utils.dart';
import 'package:foodapp/widgets/common/common_widgets.dart';
import 'package:get/get.dart';

class OrderHistoryListWidget extends StatelessWidget{

  final List<OrderModel>listOrder;
  final orderDetailState=Get.put(OrderHistoryState());


   OrderHistoryListWidget({Key key, this.listOrder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
        return Column(
          children: [
            Expanded(child: LiveList(
              showItemInterval: Duration(milliseconds: 300),
              showItemDuration: Duration(milliseconds: 300),
              reAnimateOnVisibility: true,
              scrollDirection: Axis.vertical,
              itemCount: listOrder.length,
              itemBuilder: animationItemBuilder((index)=>InkWell(
                onTap: (){
                  orderDetailState.selectOrder.value=listOrder[index];
                  Get.to(()=>OrderViewDetailScreen());
                },
                child: Card(

                  semanticContainer: true,
                  clipBehavior: Clip.antiAliasWithSaveLayer, // la cai anumaution
               //   clipBehavior: Clip.antiAlias,
                  child: Column(
                    children: [
                      CachedNetworkImage(imageUrl: listOrder[index].cartItemList[0].image,
                        fit: BoxFit.cover,
                        errorWidget: (context,url,err)=>Center(
                          child: Icon(Icons.image),
                        ),
                        progressIndicatorBuilder: (context,url,download)=>
                        Center(
                          child:CircularProgressIndicator(),

                        ),
                      ),
                      Align(
                          alignment: Alignment.bottomCenter,
                        child: Container(
                          color: Colors.lightGreenAccent,
                          child: Row( // muc dich cau cai row nay la lam cho may cai khac o gia
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(padding:const EdgeInsets.only(top: 20,bottom: 20), // cho tat ca vao cai padding
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                      Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text('Order #${listOrder[index].orderNumber}',style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            color: Colors.black,
                                            fontSize: 18
                                          ),),
                                          Text('Date: ${convertDate(listOrder[index].createDate)}',style: TextStyle(
                                              fontWeight: FontWeight.normal,
                                              color: Colors.black,
                                              fontSize: 18
                                          ),),
                                          Text('Order Status:${convertStatus(listOrder[index].orderStatus)}',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.normal,
                                            color: Colors.deepPurple
                                          ),),

                                        ],
                                      )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )),
            ))
          ],
        );
  }

}