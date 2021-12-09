import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TotalItemWidget extends StatelessWidget {
  const TotalItemWidget({
    Key key,
    this.text,
    this.value,
    this.isSubTotal,
  }) : super(key: key);

  final String text;
  final String value;
  final isSubTotal;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: TextStyle(
              fontWeight:isSubTotal? FontWeight.bold:FontWeight.w400,
              fontStyle: FontStyle.italic,
              fontSize: isSubTotal ? 20 : 16,
              color: isSubTotal?Colors.red:Colors.black
          ),
        ),
        Text(
          value,
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: isSubTotal ? 20 : 16),
        ),
      ],
    );
  }
}
