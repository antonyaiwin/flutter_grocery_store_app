import 'package:flutter/material.dart';
import 'package:flutter_grocery_store/core/constants/color_constants.dart';
import 'package:flutter_grocery_store/utils/functions/widget_route_functions.dart';
import 'package:flutter_grocery_store/view/home_screen/widgets/home_screen_back_button.dart';
import 'package:flutter_grocery_store/view/home_screen/widgets/product_list_card.dart';
import 'package:icons_plus/icons_plus.dart';

import 'package:provider/provider.dart';

import '../../../controller/cart_controller.dart';
import '../../../controller/screens/add_address_screen_controller.dart';
import '../../add_address_screen/add_address_screen.dart';
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
                          const BillDetailsCard(),
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
                        showMyModalBottomSheet(
                          context: context,
                          expand: false,
                          isScrollControlled: false,
                          builder: (context, scrollController) {
                            return const CheckoutBottomSheetContent();
                          },
                        );
                      },
                child: Center(
                  child: Text(
                    'Place order',
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

class CheckoutBottomSheetContent extends StatelessWidget {
  const CheckoutBottomSheetContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(15.0).copyWith(bottom: 0),
          child: Text(
            'Checkout',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Iconsax.personalcard_bold),
          title: const Text('Address'),
          trailing: const Icon(
            Iconsax.arrow_right_3_outline,
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChangeNotifierProvider(
                  create: (BuildContext context) =>
                      AddAddressScreenController(),
                  child: const AddAddressScreen(),
                ),
              ),
            );
          },
        ),
        const ListTile(
          leading: Icon(
            Iconsax.moneys_bold,
          ),
          title: Text('Payment method'),
          trailing: Icon(
            Iconsax.arrow_right_3_outline,
          ),
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: () {},
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Place Order',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w900,
                          color: ColorConstants.primaryWhite,
                        ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
