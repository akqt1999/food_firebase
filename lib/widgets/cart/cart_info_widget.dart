import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/model/cart_model.dart';
import 'package:foodapp/state/cart_state.dart';
import 'package:foodapp/utils/utils.dart';

class CartInfo extends StatelessWidget {

  const CartInfo({
    Key key,
    @required this.controller, this.cartModel,
  }) : super(key: key);

  final CartStateController controller;
  final CartModel cartModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment:
      MainAxisAlignment.center,
      crossAxisAlignment:
      CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets
              .symmetric(horizontal: 8),
          child: Text(
            cartModel.name,
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Padding(
            padding: const EdgeInsets
                .symmetric(horizontal: 8),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.monetization_on,
                  color: Colors.red,
                  size: 16,),
                Text('${currencyFormat.format(cartModel.price)}',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            )
        ),
      ],
    );
  }
}
