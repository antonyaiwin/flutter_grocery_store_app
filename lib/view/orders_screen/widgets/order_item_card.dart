import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_grocery_store/core/constants/image_constants.dart';
import 'package:flutter_grocery_store/core/enum/order_status.dart';
import 'package:flutter_grocery_store/model/order_model.dart';
import 'package:flutter_grocery_store/utils/global_widgets/my_network_image.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:intl/intl.dart';

import '../../../core/constants/color_constants.dart';

class OrderItemCard extends StatelessWidget {
  const OrderItemCard({
    super.key,
    required this.order,
  });

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorConstants.primaryWhite,
        border: Border.all(
          color: ColorConstants.hintColor,
          width: 0.5,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: ColorConstants.primaryBlack.withOpacity(0.05),
              border: Border(
                bottom: BorderSide(
                  color: ColorConstants.hintColor.withOpacity(0.3),
                ),
              ),
            ),
            child: Row(
              children: [
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: ColorConstants.primaryWhite,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: ColorConstants.hintColor,
                    ),
                  ),
                  child: MyNetworkImage(
                      imageUrl:
                          order.cartItems?.first.product.imageUrl?.first ?? ''),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Order',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                        'Total amount - ₹${order.finalPrice?.toStringAsFixed(2) ?? ''}'),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: order.cartItems
                      ?.map(
                        (e) => Text.rich(
                          TextSpan(
                            text: '${e.quantity} x ',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color: ColorConstants.hintColor,
                                ),
                            children: [
                              TextSpan(
                                text:
                                    '${e.product.name} [${e.product.getFormattedQuantity()}]',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      color: ColorConstants.primaryBlack,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      )
                      .toList() ??
                  [],
            ),
          ),
          DottedLine(
            dashColor: ColorConstants.hintColor.withOpacity(0.4),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                if (order.orderCreatedTime != null) ...[
                  const Icon(
                    Iconsax.calendar_1_outline,
                    color: ColorConstants.hintColor,
                    size: 18,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    DateFormat("d MMM yyyy 'at' h:mm a")
                        .format(order.orderCreatedTime!),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: ColorConstants.hintColor,
                        ),
                  ),
                ],
                const Spacer(),
                if (order.paymentMethod == 'razorpay') ...[
                  Image.asset(
                    ImageConstants.razorpayLogo,
                    width: 18,
                    height: 18,
                  ),
                  Text(
                    'Razorpay',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: ColorConstants.hintColor,
                        ),
                  ),
                ] else if (order.paymentMethod == 'cod') ...[
                  const Icon(
                    Iconsax.moneys_outline,
                    size: 18,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    'Cash on delivery',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: ColorConstants.hintColor,
                        ),
                  )
                ]
              ],
            ),
          ),
          DottedLine(
            dashColor: ColorConstants.hintColor.withOpacity(0.4),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                getOrderStatusIndicator(order.getOrderStatus()),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget getOrderStatusIndicator(OrderStatus orderStatus) {
    return Text(orderStatus.name);
  }
}
