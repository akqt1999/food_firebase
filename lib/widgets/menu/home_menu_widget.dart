import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:foodapp/strings/restaurant_home_string.dart';

class HomeMenuWidget extends StatelessWidget {
  const HomeMenuWidget({
    Key key,
    @required this.zoomDrawerController,
  }) : super(key: key);

  final ZoomDrawerController zoomDrawerController;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()=>zoomDrawerController.toggle(),//nhan vao thi no se chuyen doi, duoc mo hoat mat di
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),//khoang cach cua no ve phia ben trai
        child: Row(mainAxisAlignment: MainAxisAlignment.start,children: [
          Icon(Icons.home,color: Colors.white,),
          SizedBox(width: 30,),// cai size box nay la no tao ra cai khonag cach
          Text(homeText,style: TextStyle(fontSize: 18,
              fontWeight: FontWeight.normal,color: Colors.white),)
        ],),
      ),
    );
  }
}
