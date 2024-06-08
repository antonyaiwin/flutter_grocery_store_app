import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_grocery_store/controller/screens/order_details_screen_controller/order_details_screen_controller.dart';
import 'package:flutter_grocery_store/core/constants/color_constants.dart';
import 'package:flutter_grocery_store/view/order_details_screen/order_details_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../model/order_model.dart';

class OrderSuccessScreen extends StatelessWidget {
  const OrderSuccessScreen({super.key, required this.order});
  final DocumentReference<OrderModel> order;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.primaryWhite,
      body: Padding(
        padding: const EdgeInsets.all(30).copyWith(bottom: 10),
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  Flexible(
                    child: Lottie.asset(
                      'assets/animations/success_check.json',
                      width: 500,
                      height: 500,
                      repeat: false,
                    ),
                  ),
                  Text(
                    'Your Order has been placed',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: Text(
                      'Your items has been ordered and is on it\'s way to being delivered. In the meantime you can explore more products or track your order.',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChangeNotifierProvider(
                      create: (context) => OrderDetailsScreenController(
                        context: context,
                        order: OrderModel(collectionDocumentId: order.id),
                      ),
                      child: OrderDetailsScreen(),
                    ),
                  ),
                );
              },
              child: const Center(
                child: Text('Track Order'),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: const Center(
                child: Text('Back to Home'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
