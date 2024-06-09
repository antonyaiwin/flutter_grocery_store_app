import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_grocery_store/controller/screens/orders_screen_controller.dart';
import 'package:provider/provider.dart';

import 'widgets/order_item_card.dart';

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
            padding: const EdgeInsets.all(10),
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
