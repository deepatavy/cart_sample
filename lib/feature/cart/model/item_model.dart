class FoodItem {
  int id = -1;
  String name = "";
  double price = 0.0;
  String description = "";
  String imageUrl = "";

  FoodItem(
      {required this.name, required this.price, required this.imageUrl, required this.description, required this.id});

  FoodItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    description = json['description'];
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['price'] = price;
    data['description'] = description;
    data['image_url'] = imageUrl;

    return data;
  }
}
