import 'dart:io';
import 'package:cart_sample/api/services.dart';
import 'package:cart_sample/commons/exceptions.dart';
import 'package:cart_sample/feature/cart/model/category_model.dart';
import 'package:cart_sample/feature/cart/model/item_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc.dart';

class CartBloc extends Bloc<CartEvents, CartState> {
  final CartRepository cartRepo;

  CartBloc({required this.cartRepo}) : super(Empty());
  List<FoodItem> cartItemList = [];
  int cartItemCount = 0;
  double cartValueCount = 0;

  @override
  Stream<CartState> mapEventToState(CartEvents event) async* {
    if (event is FetchCategories) {
      yield LoadingData();
      try {
        // Simulate loading data from API
        await Future.delayed(const Duration(seconds: 2));
        yield CategoryListLoaded(categoryList: await cartRepo.getCategoryList(), selectedItemList: cartItemList);
      } on SocketException {
        yield ErrorLoadingCart(
          error: NoInternetException('No Internet'),
        );
      } on HttpException {
        yield ErrorLoadingCart(
          error: NoServiceFoundException('No Service Found'),
        );
      } on FormatException {
        yield ErrorLoadingCart(
          error: InvalidFormatException('Invalid Response format'),
        );
      } catch (e) {
        yield ErrorLoadingCart(
          error: UnknownException('Unknown Error'),
        );
      }
    } else if (event is UpdateItemQuantity) {
      yield* _mapUpdateItemQuantityToState(event.categoryIndex, event.itemIndex, event.newQuantity);
    }
  }

  Stream<CartState> _mapUpdateItemQuantityToState(int categoryIndex, int itemIndex, int newQuantity) async* {
    final currentState = state;
    if (currentState is CategoryListLoaded) {
      List<Category> updatedCategories = List.from(currentState.categoryList);
      updatedCategories[categoryIndex].items[itemIndex].quantity = newQuantity;
      if (newQuantity == 0) {
        if (cartItemList.contains(updatedCategories[categoryIndex].items[itemIndex])) {
          cartItemList.remove(updatedCategories[categoryIndex].items[itemIndex]);
        }
      } else if (newQuantity == 1) {
        if (!cartItemList.contains(updatedCategories[categoryIndex].items[itemIndex])) {
          cartItemList.add(updatedCategories[categoryIndex].items[itemIndex]);
        }
      }
      calculateUpdatedItemCount();
      calculateUpdatedValueCount();
      yield LoadingData();
      yield CategoryListLoaded(categoryList: updatedCategories, selectedItemList: cartItemList);
    }
  }

  void calculateUpdatedValueCount() {
    cartValueCount = 0;
    for (var data in cartItemList) {
      cartValueCount = cartValueCount + (data.quantity * data.price);
    }
  }

  void calculateUpdatedItemCount() {
    cartItemCount = 0;
    for (var data in cartItemList) {
      cartItemCount += data.quantity;
    }
  }
}
