import 'package:cart_sample/api/services.dart';
import 'package:cart_sample/feature/cart/cart_bloc/bloc.dart';
import 'package:cart_sample/feature/cart/model/category_model.dart';
import 'package:cart_sample/feature/cart/screens/widgets/food_item_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartBloc(cartRepo: CartServices()),
      child: const MenuScreenWidget(),
    );
  }
}

class MenuScreenWidget extends StatefulWidget {
  const MenuScreenWidget({super.key});

  @override
  State<MenuScreenWidget> createState() => _MenuScreenWidgetState();
}

class _MenuScreenWidgetState extends State<MenuScreenWidget> with AutomaticKeepAliveClientMixin {
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
          'Menu',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.shopping_cart))],
      ),
      body: BlocBuilder<CartBloc, CartState>(builder: (BuildContext context, CartState state) {
        if (state is ErrorLoadingCart) {
          final error = state.error;
          return Center(child: Text(error.message));
        }
        if (state is CategoryListLoaded) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  key: const PageStorageKey<String>('CartScreenWidgetListView'),
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
                    ],
                  ),
                  itemCount: state.categoryList.length,
                ),
              ),
              Container(
                  width: double.infinity,
                  height: 40,
                  child: Center(child: Text("Items Selected ${BlocProvider.of<CartBloc>(context).cartItemCount}")))
            ],
          );
        }
        return const Center(child: CircularProgressIndicator());
      }),
    );
  }
}
