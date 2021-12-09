import 'package:auto_animated/auto_animated.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/model/category_model.dart';
import 'package:foodapp/screens/food_list.dart';
import 'package:foodapp/state/category_state.dart';
import 'package:foodapp/widgets/common/common_widgets.dart';
import 'package:get/get.dart';


class CategoryListWidget extends StatelessWidget {
  const CategoryListWidget({
    Key key,
    @required this.lst, this.categoryStateController,
  }) : super(key: key);

  final List<CategoriesModel> lst;
  final CategoryStateController categoryStateController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: LiveGrid(
              showItemDuration: Duration(milliseconds: 300), // thoi gian load 1 cai muc
                showItemInterval: Duration(milliseconds: 300),//thoi gian load 1 cai hang
                reAnimateOnVisibility: true,
                scrollDirection: Axis.vertical,// cuon theo chieu nao
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, crossAxisSpacing: 2, mainAxisSpacing: 2),
                    itemCount: lst.length,
                itemBuilder: animationItemBuilder((index) => InkWell(
                      onTap: () {
                        categoryStateController.selectedCategory.value=lst[index];
                        Get.to(()=>FoodListScreen());
                      },
                      child: Card(
                        semanticContainer: true,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        // su ly hinh anh
                        child: Stack( // co nghia la no duoc chong len nhau
                          fit: StackFit.expand,
                          children: [
                            CachedNetworkImage(
                              imageUrl: lst[index].image,
                              fit: BoxFit.cover,
                              errorWidget: (context, url, err) => Center(
                                child: Icon(Icons.image),
                              ),
                              progressIndicatorBuilder:
                                  (context, url, dowloadProcess) => Center(
                                child: CircularProgressIndicator(),
                              ),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Container(
                                color:Colors.black45,
                                child: Padding(padding:  const EdgeInsets.only(top: 6,bottom: 6),
                                        child:Text(  '${lst[index].name}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 23,
                                              color: Colors.white),),
                                    ),



                              ),
                            ),

                          ],
                        ),
                      ),
                    )),

               ))
      ],
    );
  }
}
