import 'package:cached_network_image/cached_network_image.dart';
import 'package:cart_sample/feature/cart/model/item_model.dart';
import 'package:flutter/material.dart';

class FoodItemListWidget extends StatelessWidget {
  final List<FoodItem> itemList;

  const FoodItemListWidget({super.key, required this.itemList});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.all(4.0),
        child: Card(
            color: Colors.white,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CachedNetworkImage(
                    imageUrl: itemList[index].imageUrl,
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                    errorWidget: (context, url, error) {
                      return Container(
                        alignment: Alignment.center,
                        height: 100,
                        width: 100,
                        color: Colors.grey.withAlpha(80),
                        child: Text(
                          itemList[index].name[0],
                          style: const TextStyle(fontSize: 24),
                        ),
                      );
                    },
                    placeholder: (_, __) => const Center(
                      child: CircularProgressIndicator(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        itemList[index].name,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(itemList[index].description),
                    ],
                  ),
                ),
              ],
            )),
      ),
      itemCount: itemList.length,
    );
  }
}
