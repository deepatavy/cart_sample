import 'package:cart_sample/commons/constants.dart';
import 'package:cart_sample/feature/cart/screens/widgets/item_count.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cart_bloc/bloc.dart';

class CartSummaryScreen extends StatelessWidget {
  const CartSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          Constants.cartSummaryText,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
        ),
      ),
      body: BlocBuilder<CartBloc, CartState>(builder: (BuildContext context, CartState state) {
        if (state is ErrorLoadingCart) {
          final error = state.error;
          return Center(child: Text(error.message));
        }
        if (state is CategoryListLoaded) {
          return SingleChildScrollView(
            child: Column(
              children: [
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => Padding(
                    key: ValueKey(state.selectedItemList[index].id),
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    state.selectedItemList[index].name,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge
                                        ?.copyWith(fontWeight: FontWeight.w600, fontSize: 20),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Text(state.selectedItemList[index].description,
                                        maxLines: 2, overflow: TextOverflow.ellipsis),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Text(
                                      Constants.addNoteText,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(color: Colors.blue.shade800),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                ItemCountWidget(
                                  key: ValueKey(state.selectedItemList[index].id + 100),
                                  item: state.selectedItemList[index],
                                  categoryIndex: state.selectedItemList[index].categoryIndex,
                                  itemIndex: state.selectedItemList[index].itemIndex,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Text(
                                    '\$ ${state.selectedItemList[index].price.toStringAsFixed(2)}',
                                    style: Theme.of(context).textTheme.titleMedium,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  itemCount: state.selectedItemList.length,
                  separatorBuilder: (BuildContext context, int index) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.0),
                      child: Divider(height: 16),
                    );
                  },
                ),
                const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Divider(),
                ),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 24.0, right: 24, bottom: 100),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              Constants.totalText,
                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
                            ),
                            Text(
                              " (${BlocProvider.of<CartBloc>(context).cartItemCount} ${BlocProvider.of<CartBloc>(context).cartItemCount > 1 ? Constants.itemsText : Constants.itemText})",
                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        Text(
                          "\$ ${BlocProvider.of<CartBloc>(context).cartValueCount.toStringAsFixed(2)}",
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        }
        return const Center(child: CircularProgressIndicator());
      }),
    );
  }
}
