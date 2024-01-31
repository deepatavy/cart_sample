import 'package:cart_sample/feature/cart/cart_bloc/bloc.dart';
import 'package:cart_sample/feature/cart/model/item_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ItemCountWidget extends StatelessWidget {
  final FoodItem item;
  final int categoryIndex;
  final int itemIndex;

  const ItemCountWidget({super.key, required this.item, required this.categoryIndex, required this.itemIndex});

  @override
  Widget build(BuildContext context) {
    return item.quantity > 0
        ? Container(
            width: 120,
            height: 36,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(12),
              ),
              border: Border.all(
                width: 1.5,
                color: Colors.green,
                style: BorderStyle.solid,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                    onPressed: () {
                      BlocProvider.of<CartBloc>(context).add(UpdateItemQuantity(
                          categoryIndex: categoryIndex, itemIndex: itemIndex, newQuantity: item.quantity - 1));
                    },
                    icon: const Icon(Icons.remove_outlined, color: Colors.green, size: 18)),
                Text(
                  item.quantity.toString(),
                  style: const TextStyle(color: Colors.green),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.add,
                    color: Colors.green,
                    size: 18,
                  ),
                  onPressed: () {
                    BlocProvider.of<CartBloc>(context).add(UpdateItemQuantity(
                        categoryIndex: categoryIndex, itemIndex: itemIndex, newQuantity: item.quantity + 1));
                  },
                ),
              ],
            ))
        : InkWell(
            customBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            onTap: () {
              BlocProvider.of<CartBloc>(context).add(UpdateItemQuantity(
                  categoryIndex: categoryIndex, itemIndex: itemIndex, newQuantity: item.quantity + 1));
            },
            child: Container(
                width: 120,
                height: 36,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(12),
                  ),
                  border: Border.all(
                    width: 1.5,
                    color: Colors.green,
                    style: BorderStyle.solid,
                  ),
                ),
                child: const Center(
                    child: Text(
                  "ADD",
                  style: TextStyle(color: Colors.green),
                ))));
  }
}
