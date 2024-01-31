import 'package:cart_sample/commons/constants.dart';
import 'package:cart_sample/feature/cart/cart_bloc/bloc.dart';
import 'package:cart_sample/feature/cart/model/category_model.dart';
import 'package:cart_sample/feature/cart/screens/cart_summary_screen.dart';
import 'package:cart_sample/feature/cart/screens/widgets/food_item_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> with AutomaticKeepAliveClientMixin {
  List<Category> categoryList = [];

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CartBloc>(context).add(FetchCategories());
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          Constants.menuText,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
        ),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.shopping_cart))],
      ),
      body: BlocBuilder<CartBloc, CartState>(builder: (BuildContext context, CartState state) {
        if (state is ErrorLoadingCart) {
          final error = state.error;
          return Center(child: Text(error.message));
        }
        if (state is CategoryListLoaded) {
          return Stack(
            children: [
              ListView.builder(
                key: const PageStorageKey<String>(Constants.tempKeyText),
                // Use PageStorageKey to maintain scroll position
                itemBuilder: (context, index) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
                      child: Text(
                        state.categoryList[index].name,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
                      ),
                    ),
                    FoodItemListWidget(
                      key: ValueKey(state.categoryList[index].id),
                      categoryIndex: index,
                      itemList: state.categoryList[index].items,
                    ),
                    if (index == state.categoryList.length - 1)
                      const SizedBox(
                        height: 100,
                      )
                  ],
                ),
                itemCount: state.categoryList.length,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(40),
                        ),
                        color: Colors.white),
                    height: 80,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.shopping_cart_outlined),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                  "${BlocProvider.of<CartBloc>(context).cartItemCount} ${BlocProvider.of<CartBloc>(context).cartItemCount > 1 ? 'Items' : 'Item'}",
                                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
                                ),
                              ),
                            ],
                          ),
                          ElevatedButton(
                            onPressed: () {
                              if (BlocProvider.of<CartBloc>(context).cartItemCount == 0) {
                                showAlertDialog(context);
                              } else {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (context) => const CartSummaryScreen()));
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green, // background
                            ),
                            child: Text(
                              Constants.placeOrderText,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(fontWeight: FontWeight.w600, color: Colors.white),
                            ),
                          )
                        ],
                      ),
                    )),
              )
            ],
          );
        }
        return const Center(child: CircularProgressIndicator());
      }),
    );
  }

  showAlertDialog(BuildContext context) {
    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    AlertDialog alert = AlertDialog(
      title: const Text(Constants.appName),
      content: const Text(Constants.alertEmptyCartText),
      actions: [
        okButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
