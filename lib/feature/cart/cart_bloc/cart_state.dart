import 'package:cart_sample/feature/cart/model/category_model.dart';
import 'package:cart_sample/feature/cart/model/item_model.dart';
import 'package:equatable/equatable.dart';

abstract class CartState extends Equatable {
  @override
  List<Object> get props => [];
}

class Empty extends CartState {}

class LoadingData extends CartState {}

class CategoryListLoaded extends CartState {
  final List<Category> categoryList;
  final List<FoodItem> selectedItemList;

  CategoryListLoaded({required this.categoryList, required this.selectedItemList});
}

class ErrorLoadingCart extends CartState {
  final error;

  ErrorLoadingCart({this.error});
}
