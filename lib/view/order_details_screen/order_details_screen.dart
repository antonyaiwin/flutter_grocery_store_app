// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_grocery_store/controller/screens/order_details_screen_controller/order_details_screen_controller.dart';
import 'package:flutter_grocery_store/core/constants/color_constants.dart';
import 'package:flutter_grocery_store/model/order_model.dart';
import 'package:flutter_grocery_store/view/home_screen/widgets/bill_details_card.dart';
import 'package:provider/provider.dart';

import '../../utils/global_widgets/elevated_card.dart';
import '../../utils/global_widgets/my_network_image.dart';
import 'widgets/my_stepper.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = context.read<OrderDetailsScreenController>();
    OrderModel order = provider.order;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Summary'),
        backgroundColor: ColorConstants.primaryWhite,
        elevation: 1,
        surfaceTintColor: Colors.transparent,
        shadowColor: ColorConstants.primaryBlack,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ElevatedCard(
                    padding: EdgeInsets.all(10),
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
                              imageUrl: order.cartItems?.first.product.imageUrl
                                      ?.first ??
                                  ''),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Order',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            Text.rich(
                              TextSpan(
                                text: 'Total amount - ',
                                children: [
                                  TextSpan(
                                    text:
                                        '₹${order.finalPrice?.toStringAsFixed(2) ?? ''}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedCard(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MySubtitle('Items'),
                        MyDivider(),
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
                                                    color: ColorConstants
                                                        .primaryBlack,
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
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedCard(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MySubtitle('Order Status'),
                        MyDivider(),
                        const SizedBox(height: 5),
                        Consumer<OrderDetailsScreenController>(
                          builder:
                              (BuildContext context, value, Widget? child) =>
                                  MyStepper(provider: provider),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  BillDetailsCard(
                    totalItems: order.cartItems?.fold<int>(
                        0,
                        (previousValue, element) =>
                            previousValue += element.quantity),
                    subtotal: order.totalPrice,
                    deliveryCharge: 20.0,
                  ),
                ],
              ),
            ),
          ),
          Row(
            children: [
              const SizedBox(width: 10),
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  child: Text('Cancel Order'),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text('Call Shop'),
                ),
              ),
              const SizedBox(width: 10),
            ],
          )
        ],
      ),
    );
  }
}

class MySubtitle extends StatelessWidget {
  const MySubtitle(
    this.text, {
    super.key,
  });
  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
    );
  }
}

class MyDivider extends StatelessWidget {
  const MyDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: ColorConstants.hintColor,
      thickness: 0.2,
    );
  }
}
