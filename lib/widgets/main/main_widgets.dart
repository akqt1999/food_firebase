import 'package:auto_animated/auto_animated.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RestaurantImageWidget extends StatelessWidget {
  const RestaurantImageWidget({
    Key key,
    @required this.imageUrl,
  }) : super(key: key);

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: 250,child:  Card(
      semanticContainer: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        fit: BoxFit.cover,
        errorWidget: (context,url,er)=>
        (
            Center(
              child: Icon(Icons.image),
            )
        ),
        progressIndicatorBuilder: (context,url,dowloadProcess)=>
            Center(
              child: CircularProgressIndicator(),
            ),
      ),
    ),);
  }
}

class RestaurantInfoWidget extends StatelessWidget {

  final String name,address;

  const RestaurantInfoWidget({Key key, this.name, this.address}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return   Card(child: Container(
    width: double.infinity,child: Column(children: [
    Text(name,style: TextStyle(fontWeight: FontWeight.w900,),),
    Text(address,style: TextStyle(fontWeight: FontWeight.w300,fontSize: 13),)
    ],),
    )
    );
  }

}
