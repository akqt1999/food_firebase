import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:foodapp/state/food_list_state.dart';

class FoodDetailDescriptionWidget extends StatelessWidget {
  const FoodDetailDescriptionWidget({
    Key key,
    @required this.foodListStateController,
  }) : super(key: key);

  final FoodListStateController foodListStateController;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Container(
        // chua cai contain nay la de cho no co chieu cao , padding
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            RatingBar.builder(
                initialRating: 5,// gia tri mat dinh khi danh gia
                minRating: 1,
                direction:Axis.horizontal ,
                allowHalfRating: false,

                itemBuilder: (context,_){

                  return Icon(Icons.star,color:Colors.amber);
                }, onRatingUpdate: (value){

            }),
            SizedBox(
              height: 10,
            ),
            Text(
              '${foodListStateController.selectFood.value.name}',
              style: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.normal),
            ),


          ],
        ),
      ),
    );
  }
}


