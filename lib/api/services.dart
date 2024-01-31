import 'dart:convert';

import 'package:cart_sample/commons/asset_items.dart';
import 'package:cart_sample/feature/cart/model/category_model.dart';
import 'package:cart_sample/feature/cart/model/response_model.dart';
import 'package:flutter/services.dart';

abstract class CartRepository {
  Future<List<Category>> getCategoryList();
}

class CartServices implements CartRepository {
  @override
  Future<List<Category>> getCategoryList() async {
    final String response = await rootBundle.loadString(jsonFilePath);
    final data = await json.decode(response);
    return ResponseModel.fromJson(data).categories!;
  }
}
