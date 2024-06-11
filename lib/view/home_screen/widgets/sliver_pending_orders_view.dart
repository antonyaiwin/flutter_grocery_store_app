import 'package:dotted_line/dotted_line.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_grocery_store/core/constants/color_constants.dart';
import 'package:flutter_grocery_store/model/cart_item_model.dart';
import 'package:flutter_grocery_store/model/order_model.dart';
import 'package:flutter_grocery_store/utils/global_widgets/elevated_card.dart';
import 'package:flutter_grocery_store/utils/global_widgets/my_network_image.dart';
import 'package:provider/provider.dart';

import '../../../controller/firebase/firestore_controller.dart';

class SliverPendingOrdersView extends StatelessWidget {
  const SliverPendingOrdersView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: StreamBuilder(
        stream: context
            .read<FireStoreController>()
            .ordersCollection
            .orderBy('orderCreatedTime', descending: true)
            .where('createdUserId',
                isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .where('orderDeliveredTime', isNull: true)
            .where('orderCancelledTime', isNull: true)
            .limit(1)
            .snapshots(),
        builder: (context, snapshot) {
          var data = snapshot.data?.docs;

          if (!snapshot.hasData ||
              snapshot.connectionState == ConnectionState.waiting ||
              data == null ||
              data.isEmpty) {
            return const SizedBox();
          }

          var order = data.first.data().copyWith(
                collectionDocumentId: data.first.id,
              );
          return ActiveOrderWidget(order: order);
        },
      ),
    );
  }
}

class ActiveOrderWidget extends StatelessWidget {
  const ActiveOrderWidget({
    super.key,
    required this.order,
  });

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ElevatedCard(
        elevation: 5,
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Active Order',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: ColorConstants.primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  order.getOrderStatus().name,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
            const SizedBox(height: 5),
            DottedLine(
              dashColor: ColorConstants.hintColor.withOpacity(0.4),
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Order Items',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                Text(
                  'x${order.itemCount}',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
            SizedBox(
              height: 58,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 1),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  var item = order.cartItems?[index];
                  return ActiveOrderProductItemCard(item: item);
                },
                itemCount: order.cartItems?.length ?? 0,
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text('View Full Details'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    child: const Text('View all orders'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ActiveOrderProductItemCard extends StatelessWidget {
  const ActiveOrderProductItemCard({
    super.key,
    required this.item,
  });

  final CartItemModel? item;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(10),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 150),
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            MyNetworkImage(
                height: 40,
                width: 40,
                imageUrl: item?.product.imageUrl?.first ?? ''),
            const SizedBox(width: 4),
            Flexible(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item?.product.name ?? '',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    '${item?.quantity ?? ''} x ${item?.product.getFormattedQuantity() ?? ''}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: ColorConstants.hintColor,
                        ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
