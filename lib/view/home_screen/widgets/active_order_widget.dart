import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_grocery_store/core/constants/color_constants.dart';
import 'package:flutter_grocery_store/model/order_model.dart';
import 'package:flutter_grocery_store/utils/global_widgets/elevated_card.dart';

import '../../../utils/global_widgets/order_status_indicator.dart';
import 'active_order_product_item_card.dart';

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
                OrderStatusIndicator(orderStatus: order.getOrderStatus()),
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
