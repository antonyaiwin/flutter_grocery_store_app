import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_grocery_store/controller/cart_controller.dart';
import 'package:flutter_grocery_store/core/constants/color_constants.dart';
import 'package:flutter_grocery_store/utils/global_widgets/my_network_image.dart';
import 'package:flutter_grocery_store/view/home_screen/pages/cart_page.dart';
import 'package:provider/provider.dart';

class FloatingCartWidget extends StatelessWidget {
  const FloatingCartWidget({
    super.key,
    required this.cart,
  });
  const FloatingCartWidget.basic({
    super.key,
  }) : cart = null;

  final CartController? cart;

  @override
  Widget build(BuildContext context) {
    if (cart == null) {
      return Consumer<CartController>(
        builder: (context, cart, child) {
          return _bodyContent(context, cart);
          // if (cart.cartItemList.isEmpty) {
          //   return const SizedBox();
          // }
          // return ;
        },
      );
    }
    return _bodyContent(context, cart!);
  }

  Widget _bodyContent(BuildContext context, CartController cart) {
    return AnimatedContainer(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 4,
      ),
      color: ColorConstants.scaffoldBackgroundColor2,
      height: cart.cartItemList.isEmpty ? 0 : kToolbarHeight,
      duration: const Duration(milliseconds: 400),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                const SizedBox(width: 10),
                ImageStackView(
                  cart: cart,
                ),
                const SizedBox(width: 10),
                Text('${cart.totalCartCount} item(s)')
              ],
            ),
          ),
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CartPage(
                      popOnBack: true,
                    ),
                  ),
                );
              },
              child: const Text('View Cart'),
            ),
          ),
        ],
      ),
    );
  }
}

class ImageStackView extends StatelessWidget {
  const ImageStackView({
    super.key,
    required this.cart,
  });
  final CartController cart;
  static const Duration animationDuration = Duration(milliseconds: 300);

  @override
  Widget build(BuildContext context) {
    final BorderSide borderSide = BorderSide(
      color: ColorConstants.hintColor.withOpacity(0.4),
      strokeAlign: BorderSide.strokeAlignOutside,
    );
    return AnimatedSize(
      clipBehavior: Clip.none,
      duration: animationDuration,
      child: SizedBox(
        width: kToolbarHeight * 0.8 +
            (cart.cartItemList.length > 4
                    ? 3
                    : max(cart.cartItemList.length - 1, 0)) *
                7,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            ...List.generate(
              3,
              // cart.cartItemList.length > 4 ? 3 : cart.cartItemList.length - 1,
              (index) {
                var factor = ((cart.cartItemList.length > 4
                        ? 3
                        : cart.cartItemList.length - 1) -
                    index);
                var width = kToolbarHeight * 0.8 +
                    (factor == cart.cartItemList.length ? 0 : factor) * 7;
                return Positioned(
                  // duration: animationDuration,
                  right: 0,
                  child: AnimatedSize(
                    clipBehavior: Clip.none,
                    duration: animationDuration,
                    child: Container(
                      width: width > kToolbarHeight * 0.8
                          ? width
                          : kToolbarHeight * 0.8,
                      height: kToolbarHeight * 0.8,
                      decoration: BoxDecoration(
                        border: Border(
                          left: borderSide,
                          top: borderSide,
                          bottom: borderSide,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                );
              },
            ),
            Positioned(
              // duration: animationDuration,
              right: 0,
              child: Container(
                clipBehavior: Clip.hardEdge,
                height: kToolbarHeight * 0.8,
                width: kToolbarHeight * 0.8,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: ColorConstants.hintColor.withOpacity(0.4),
                    strokeAlign: BorderSide.strokeAlignOutside,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: cart.cartItemList.isEmpty
                    ? null
                    : MyNetworkImage(
                        imageUrl:
                            cart.cartItemList.last.product.imageUrl?.first ??
                                ''),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
