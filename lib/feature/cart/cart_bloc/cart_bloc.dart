import 'dart:io';
import 'package:cart_sample/api/services.dart';
import 'package:cart_sample/commons/exceptions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc.dart';

class CartBloc extends Bloc<CartEvents, CartState> {
  final CartRepository cartRepo;

  CartBloc({required this.cartRepo}) : super(Empty());

  @override
  Stream<CartState> mapEventToState(CartEvents event) async* {
    if (event is FetchCategories) {
      yield LoadingData();
      try {
        yield CategoryListLoaded(categoryList: await cartRepo.getCategoryList());
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
    }
  }
}
