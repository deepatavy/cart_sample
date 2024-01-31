import 'package:cached_network_image/cached_network_image.dart';
import 'package:cart_sample/feature/cart/model/item_model.dart';
import 'package:cart_sample/feature/cart/screens/widgets/item_count.dart';
import 'package:flutter/material.dart';

class FoodItemListWidget extends StatelessWidget {
  final List<FoodItem> itemList;
  final int categoryIndex;

  const FoodItemListWidget({super.key, required this.categoryIndex, required this.itemList});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemBuilder: (context, index) => Padding(
        key: ValueKey(itemList[index].id),
        padding: const EdgeInsets.all(4.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CachedNetworkImage(
                imageUrl: itemList[index].imageUrl,
                height: 120,
                width: 120,
                fit: BoxFit.cover,
                errorWidget: (context, url, error) {
                  return Container(
                    alignment: Alignment.center,
                    height: 120,
                    width: 120,
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
              child: Padding(
                padding: const EdgeInsets.only(right: 12, left: 4, top: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      itemList[index].name,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(itemList[index].description, maxLines: 2, overflow: TextOverflow.ellipsis),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.energy_savings_leaf,
                            color: itemList[index].isVeg ? Colors.green : Colors.red,
                          ),
                          Text(
                            ' \$${itemList[index].price}',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const Spacer(),
                          ItemCountWidget(
                            key: ValueKey(itemList[index].id + 100),
                            item: itemList[index],
                            categoryIndex: categoryIndex,
                            itemIndex: index,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      itemCount: itemList.length,
      separatorBuilder: (BuildContext context, int index) {
        return const Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.0),
          child: Divider(height: 8),
        );
      },
    );
  }
}
