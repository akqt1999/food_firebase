import 'package:foodapp/model/size_model.dart';

import 'addon_model.dart';

class FoodModel{
  String description='',id='',name='',image='';
  double price=0;
  List<SizeModel>size=List<SizeModel>.empty(growable: true);
  List<AddonModel>addon=List<AddonModel>.empty(growable: true);

  FoodModel(
      {this.description,
      this.id,
      this.name,
      this.image,
      this.price,
      this.size,
      this.addon});
  FoodModel.fromJson(Map<String,dynamic> json){
    name=json['name'];
    price=double.parse(json['price'].toString());
    id=json['id'];
    image=json['image'];
    description=json['description'];

    if(json['addon']!=null){
      addon=List<AddonModel>.empty(growable: true);
      json['addon'].forEach((v){
          addon.add(AddonModel.fromJson(v));
      }
      );
    }

    if(json['size']!=null){
      size=List<SizeModel>.empty(growable: true);
      json['size'].forEach((v){
        size.add(SizeModel.fromJson(v));
      }
      );
    }

  }

  Map<String,dynamic>toJson(){
    final data=Map<String,dynamic>();
    data['name']=this.name;
    data['price']=this.price;
    data['id']=this.id;
    data['description']=this.description;
    data['image']=this.image;
    data['size']=this.size.map((e) => e.toJson()).toList();
    data['addon']=this.addon.map((e) => e.toJson()).toList();
    return data;
  }
}