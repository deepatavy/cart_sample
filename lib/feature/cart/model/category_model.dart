import 'package:cart_sample/feature/cart/model/item_model.dart';

class Category {
  int id = 0;
  String name = '';
  List<FoodItem> items = [];

  Category({required this.id, required this.name, required this.items});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    if (json['items'] != null) {
      items = <FoodItem>[];
      int index = 0;
      json['items'].forEach((v) {
        items.add(FoodItem.fromJson(v,id,index));
        index++;
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['items'] = items.map((v) => v.toJson()).toList();
    return data;
  }
}
