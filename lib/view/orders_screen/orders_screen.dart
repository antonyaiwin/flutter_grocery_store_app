import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_grocery_store/controller/screens/orders_screen_controller.dart';
import 'package:flutter_grocery_store/model/order_model.dart';
import 'package:flutter_grocery_store/utils/global_widgets/my_network_image.dart';
import 'package:provider/provider.dart';

import '../../core/constants/color_constants.dart';
import '../../utils/global_widgets/elevated_card.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Orders'),
      ),
      body: Consumer<OrdersScreenController>(
        builder: (context, ordersProvider, child) {
          if (ordersProvider.orderList.isEmpty) {
            return const Center(
              child: Text('Oops, you haven\'t placed any order yet!'),
            );
          }
          return ListView.separated(
            itemBuilder: (context, index) {
              var order = ordersProvider.orderList[index];
              log(order.toMap().toString());

              return OrderItemCard(order: order);
            },
            separatorBuilder: (context, index) => const SizedBox(height: 10),
            itemCount: ordersProvider.orderList.length,
          );
        },
      ),
    );
  }
}

class OrderItemCard extends StatelessWidget {
  const OrderItemCard({
    super.key,
    required this.order,
  });

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    return ElevatedCard(
      child: Column(
        children: [
          Row(
            children: [
              Container(
                height: 70,
                width: 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    color: ColorConstants.hintColor,
                  ),
                ),
                child: MyNetworkImage(
                    imageUrl:
                        order.cartItems?.first.product.imageUrl?.first ?? ''),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Order',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                      'Total amount - ₹${order.finalPrice?.toStringAsFixed(0) ?? ''}'),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
