import 'package:flutter/material.dart';
import 'package:flutter_grocery_store/core/constants/color_constants.dart';
import 'package:lottie/lottie.dart';

class OrderSuccessScreen extends StatelessWidget {
  const OrderSuccessScreen({super.key});

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
              onPressed: () {},
              child: const Center(child: Text('Track Order')),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Center(child: Text('Back to Home')),
            ),
          ],
        ),
      ),
    );
  }
}
