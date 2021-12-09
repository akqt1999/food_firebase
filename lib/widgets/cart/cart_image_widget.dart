import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/model/cart_model.dart';
import 'package:foodapp/state/cart_state.dart';

class CartImageWidget extends StatelessWidget {
  const CartImageWidget({
    Key key,
    @required this.controller,
    @required this.cartModel
  }) : super(key: key);

  final CartStateController controller;
  final CartModel cartModel;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
        imageUrl:cartModel.image,
        fit: BoxFit.cover,
        errorWidget: (context, url, error) => Center(
          child: Icon(Icons.image),
        ),
        progressIndicatorBuilder: (context, url, progress) =>
            Center(
              child: CircularProgressIndicator(),
            ));
  }
}