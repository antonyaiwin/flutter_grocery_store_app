import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_grocery_store/view/checkout_screen/checkout_screen.dart';
import 'package:flutter_grocery_store/view/home_screen/widgets/home_screen_back_button.dart';
import 'package:flutter_grocery_store/view/home_screen/widgets/product_list_card.dart';
import 'package:icons_plus/icons_plus.dart';

import 'package:provider/provider.dart';

import '../../../controller/cart_controller.dart';
import '../widgets/bill_details_card.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const HomeScreenBackButton(),
        title: const Text('My Cart'),
        actions: [
          Consumer<CartController>(
            builder:
                (BuildContext context, CartController value, Widget? child) =>
                    IconButton(
              onPressed: context.read<CartController>().cartItemList.isEmpty
                  ? null
                  : () {
                      context.read<CartController>().clearItems();
                    },
              icon: const Icon(Iconsax.trash_outline),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Consumer<CartController>(
                    builder: (context, cart, child) {
                      log('cart rebuild');
                      if (cart.totalCartCount == 0) {
                        return const Center(
                          child: Text('Your cart is empty!'),
                        );
                      }
                      return Column(
                        children: [
                          ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) => ProductListCard(
                              item: cart.cartItemList[index].product,
                              onDelete: () {
                                context
                                    .read<CartController>()
                                    .deleteItemFromCart(
                                        cart.cartItemList[index].product);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Item removed from cart'),
                                  ),
                                );
                              },
                            ),
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 10),
                            itemCount: cart.cartItemList.length,
                          ),
                          const SizedBox(height: 25),
                          BillDetailsCard(
                            totalItems: cart.totalCartCount,
                            subtotal: cart.totalCartPrice,
                            deliveryCharge: 20.0,
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15).copyWith(
              top: 0,
              bottom: 5,
            ),
            child: Consumer<CartController>(
              builder: (BuildContext context, value, Widget? child) =>
                  ElevatedButton(
                onPressed: value.cartItemList.isEmpty
                    ? null
                    : () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CheckoutScreen(),
                          ),
                        );
                      },
                child: Center(
                  child: Text(
                    'Continue',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
