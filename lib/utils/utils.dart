import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/model/addon_model.dart';
import 'package:intl/intl.dart';

double foodDetailImageAreaSize(BuildContext context) {
  return MediaQuery.of(context).size.height / 3;
}

final currencyFormat = NumberFormat.simpleCurrency();

int createOrderNumber(int original) {
  return original + new Random().nextInt(1000);
}

double caculateFinalPayment(double subTotal, double discount) {
  return subTotal - (subTotal * (discount / 100));
}

String convertDate(int date) => DateFormat('dd-MM-yyyy HH:mm')
    .format(DateTime.fromMillisecondsSinceEpoch(date));

String convertStatus(int status) => status == 0
    ? 'Place'
    : status == 2
        ? 'Shipped'
        : 'Cancelled';

MaterialColor convertStatusToColor (int status)=>
    status==-1?Colors.red:
        status==0?Colors.blue:
            status==1?Colors.yellow:Colors.green;

String convertAddonToText(List<AddonModel>addon){
  var result="";
  addon.map((e) => result+="${e.name}");
  return result.length>0?result.substring(0,result.length-1):result;

}


