import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_grocery_store/controller/screens/orders_screen_controller.dart';
import 'package:flutter_grocery_store/core/constants/color_constants.dart';
import 'package:flutter_grocery_store/model/order_model.dart';
import 'package:flutter_grocery_store/view/order_details_screen/order_details_screen.dart';
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
          var activeOrdersList = ordersProvider.orderList
              .where((element) =>
                  element.orderDeliveredTime == null &&
                  element.orderCancelledTime == null)
              .toList();
          var pastOrdersList = ordersProvider.orderList
              .where((element) =>
                  element.orderDeliveredTime != null ||
                  element.orderCancelledTime != null)
              .toList();
          return CustomScrollView(
            slivers: [
              if (activeOrdersList.isNotEmpty)
                ...getSliverOrderList(
                    ordersList: activeOrdersList, title: 'Active Orders'),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(20.0).copyWith(top: 5),
                  child: DottedLine(
                    dashColor: ColorConstants.hintColor.withOpacity(0.4),
                  ),
                ),
              ),
              if (pastOrdersList.isNotEmpty)
                ...getSliverOrderList(
                  ordersList: pastOrdersList,
                  title: 'Past Orders',
                )
            ],
          );
        },
      ),
    );
  }

  List<Widget> getSliverOrderList({
    required List<OrderModel> ordersList,
    required String title,
  }) {
    return [
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: MySubtitle(title),
        ),
      ),
      SliverPadding(
        padding:
            const EdgeInsets.symmetric(horizontal: 20).copyWith(bottom: 20),
        sliver: SliverList.separated(
          itemBuilder: (context, index) {
            var order = ordersList[index];
            return OrderItemCard(order: order);
          },
          separatorBuilder: (context, index) => const SizedBox(height: 10),
          itemCount: ordersList.length,
        ),
      ),
    ];
  }
}
