import 'package:equatable/equatable.dart';

class FoodItem extends Equatable {
  int id = -1;
  String name = "";
  double price = 0.0;
  bool isVeg = true;
  String description = "";
  String imageUrl = "";
  int quantity = 0;
  int categoryIndex = -1;
  int itemIndex = -1;

  FoodItem(
      {required this.name, required this.price, required this.imageUrl, required this.description, required this.id});

  FoodItem.fromJson(Map<String, dynamic> json, int catId,int itemId) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    isVeg = json['is_veg'];
    description = json['description'];
    imageUrl = json['image_url'];
    categoryIndex = catId-1;
    itemIndex = itemId;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['price'] = price;
    data['is_veg'] = isVeg;
    data['description'] = description;
    data['image_url'] = imageUrl;

    return data;
  }

  @override
  List<Object?> get props => [id];
}
