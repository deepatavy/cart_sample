import 'package:cart_sample/feature/cart/model/item_model.dart';

class Category {
  int? id;
  String? name;
  List<Item>? items;

  Category({this.id, this.name, this.items});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    if (json['items'] != null) {
      items = <Item>[];
      json['items'].forEach((v) {
        items!.add(Item.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
