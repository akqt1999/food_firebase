import 'food_model.dart';

class CategoriesModel{
  String key='',name='',image='';
 List<FoodModel>foods=new List<FoodModel>.empty(growable: true);

 CategoriesModel({this.name, this.image, this.foods});
 // CategoriesModel({this.name, this.image});
  // moi cai category la moi cai la no se co foods
  CategoriesModel.fromJson(Map<String,dynamic> json,String menuid){
    name=json['name'];
    image=json['image'];
    key=menuid;
    if(json['foods']!=null){
      foods=List<FoodModel>.empty(growable: true);
      json['foods'].forEach((v){
        foods.add(FoodModel.fromJson(v));
      }
      );// sai cai price sua ca dem
    }
  }

  Map<String,dynamic>toJson(){
    final data=Map<String,dynamic>();
    data['name']=this.name;
    data['image']=this.image;
   data['foods']=this.foods.map((e) => e.toJson()).toList();
    return data;
  }

}