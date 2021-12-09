import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/state/order_history_state.dart';
import 'package:foodapp/utils/utils.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class OrderViewDetailScreen extends StatelessWidget{
  final OrderHistoryState orderHistoryState=Get.find();
  final noSymbolUSFormat=new NumberFormat.currency(locale: "en_US");
  @override
  Widget build(BuildContext context) {
        var orderModel=orderHistoryState.selectOrder.value;
        var chipBackgoudColor=convertStatusToColor(orderModel.orderStatus);
        var chipForegroundColor=chipBackgoudColor.computeLuminance()>0.5?
            Colors.white:Colors.black;

        return SafeArea(
            child:Scaffold(
              appBar: AppBar(
                title: Text('order ${orderModel.orderNumber}'),
                actions: [ // action nay la cai su kien trongcai app bai de chen  icon vo app bar
                  (orderModel.orderStatus==0||orderModel.orderStatus==1)
                  ?InkWell(
                    child: Icon(Icons.clear),
                  ):Container()
                ],
              ),
            body:Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 2,child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('${orderModel.userName}',style: TextStyle(
                                  fontSize: 20,fontWeight:FontWeight.w800
                              ),),
                              Text('${orderModel.shippingAddress}',style: TextStyle(
                                  fontSize: 20,fontWeight: FontWeight.w100
                              ),),
                              Text('${orderModel.userPhone}',style: TextStyle(
                                fontSize: 20,
                              ),)
                            ],
                          ),),

                          Column( // cai colum nay la lam cho no o tren
                            crossAxisAlignment:CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Chip(
                                  backgroundColor: chipBackgoudColor,
                                  label: Text('${convertStatus(orderModel.orderStatus)}',
                                    style: TextStyle(color: chipForegroundColor),)),
                            ],
                          )
                        ],
                      ),
                      Divider(
                        thickness: 1,),
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Total',style:TextStyle(fontSize: 18,color:Colors.grey),),
                          Text('${noSymbolUSFormat.format(orderModel.totalPayment)}',style: TextStyle(fontSize: 18,color: Colors.black,fontWeight: FontWeight.w700),)
                        ],
                      ),
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Discount',style: TextStyle(
                              fontSize: 18,fontWeight: FontWeight.w400,color: Colors.grey
                          ),),
                          Text('${orderModel.discount}%',style: TextStyle(
                              fontSize: 18,fontWeight: FontWeight.w900,color: Colors.black
                          ),)
                        ],
                      ),
                      Divider(thickness: 1,),
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('final',style: TextStyle(
                            fontSize: 18,fontWeight: FontWeight.w400,color: Colors.black
                          ),),
                          Text('${noSymbolUSFormat.format(orderModel.finalPayment)}',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w900),)
                        ],
                      )

                    ],
                  )

                )),
                SizedBox(height: 10,),
                Expanded( flex: 5 ,child:ListView.builder(
                itemCount: orderModel.cartItemList.length
                ,itemBuilder:(context,index){
                  var sizeText=orderModel.cartItemList[index].size.length>0?
                      orderModel.cartItemList[index].size[0].name:"";
                  var addonText=orderModel.cartItemList[index].addon.length>0?
                      convertAddonToText(orderModel.cartItemList[index].addon):"";
                  var infoText="Quatity:${orderModel.cartItemList[index].quantity}";
                  if(sizeText.length>0){
                    infoText+="\nSize:$sizeText";
                  }
                  if(addonText.length>0){
                    infoText+="\nAddon: $addonText";
                  }
                  return Card(
                      elevation: 8,
                    child: ListTile(
                      title: Text(orderModel.cartItemList[index].name),
                      leading: CachedNetworkImage(
                        imageUrl: orderModel.cartItemList[index].image,
                        imageBuilder: (context,provider)=>CircleAvatar(
                            backgroundImage: provider,
                        ),
                        placeholder: (context,url)=>Center(child: CircularProgressIndicator(),),
                        errorWidget: (context,url,err)=>Center(child: Icon(Icons.image),),
                      ),
                      subtitle: Text(infoText),
                      isThreeLine: true,
                    ),
                  );
                }

                )),
              ],
            )

            )

        );
  }
}