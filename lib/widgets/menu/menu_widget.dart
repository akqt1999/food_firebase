import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/strings/restaurant_home_string.dart';

class MenuWidget extends StatelessWidget {

  final String menuName;
  final VoidCallback callback;
  final IconData icon;

  const MenuWidget({
    Key key, this.menuName, this.callback, this.icon,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callback,//nhan vao thi no se chuyen doi, duoc mo hoat mat di se tra ve cai gia tri nao do
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),//khoang cach cua no ve phia ben trai
        child: Row(mainAxisAlignment: MainAxisAlignment.start,children: [
          Icon(icon,color: Colors.white,),
          SizedBox(width: 30,),// cai size box nay la no tao ra cai khonag cach
          Text(menuName,style: TextStyle(fontSize: 18,
              fontWeight: FontWeight.normal,color: Colors.white),)
        ],),
      ),
    );
  }
}