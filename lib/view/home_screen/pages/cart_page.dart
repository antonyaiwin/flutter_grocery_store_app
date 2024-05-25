import 'package:flutter/material.dart';
import 'package:flutter_grocery_store/view/home_screen/widgets/home_screen_back_button.dart';
import 'package:flutter_grocery_store/view/home_screen/widgets/product_list_card.dart';
import 'package:icons_plus/icons_plus.dart';

import 'package:provider/provider.dart';

import '../../../controller/cart_controller.dart';
import '../widgets/cart_item_card.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const HomeScreenBackButton(),
        title: const Text('My Cart'),
        actions: [
          IconButton(
            onPressed: () {
              context.read<CartController>().clearItems();
            },
            icon: const Icon(Iconsax.trash_outline),
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
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadiusDirectional.circular(15),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Subtotal (${cart.totalCartCount} items)',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(
                                              color: Colors.black
                                                  .withOpacity(0.7)),
                                    ),
                                    const Spacer(),
                                    Text(
                                      '₹${cart.totalCartPrice.toStringAsFixed(2)}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 15),
                                Row(
                                  children: [
                                    Text(
                                      'Shipping',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(
                                              color: Colors.black
                                                  .withOpacity(0.7)),
                                    ),
                                    const Spacer(),
                                    Text(
                                      '₹20.00',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                Divider(
                                  color: Colors.black.withOpacity(0.06),
                                  thickness: 2,
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    Text(
                                      'Total',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge
                                          ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                    const Spacer(),
                                    Text(
                                      '₹${(cart.totalCartPrice + 20).toStringAsFixed(2)}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge
                                          ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 15),
                              ],
                            ),
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
            padding: const EdgeInsets.all(15).copyWith(top: 0),
            child: InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(10),
              child: Ink(
                height: 40,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    'Proceed to Checkout',
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
