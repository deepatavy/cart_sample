import 'package:cart_sample/api/services.dart';
import 'package:cart_sample/feature/cart/cart_bloc/bloc.dart';
import 'package:cart_sample/feature/cart/model/category_model.dart';
import 'package:cart_sample/feature/cart/screens/widgets/cart_item_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartBloc(cartRepo: CartServices()),
      child: const CartScreenWidget(),
    );
  }
}

class CartScreenWidget extends StatefulWidget {
  const CartScreenWidget({super.key});

  @override
  State<CartScreenWidget> createState() => _CartScreenWidgetState();
}

class _CartScreenWidgetState extends State<CartScreenWidget> with AutomaticKeepAliveClientMixin {
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
          'My Cart',
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
              SizedBox(
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
