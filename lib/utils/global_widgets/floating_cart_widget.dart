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
          if (cart.cartItemList.isEmpty) {
            return const SizedBox();
          }
          return _bodyContent(context, cart);
        },
      );
    }
    return _bodyContent(context, cart!);
  }

  Container _bodyContent(BuildContext context, CartController cart) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 4,
      ),
      color: ColorConstants.scaffoldBackgroundColor2,
      height: kToolbarHeight,
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
  @override
  Widget build(BuildContext context) {
    final BorderSide borderSide = BorderSide(
      color: ColorConstants.hintColor.withOpacity(0.4),
      strokeAlign: BorderSide.strokeAlignOutside,
    );
    return SizedBox(
      width: kToolbarHeight * 0.8 +
          (cart.cartItemList.length > 4 ? 3 : cart.cartItemList.length - 1) * 7,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          ...List.generate(
            cart.cartItemList.length > 4 ? 3 : cart.cartItemList.length - 1,
            (index) => AnimatedPositioned(
              duration: Durations.extralong4,
              right: 0,
              child: Container(
                width: kToolbarHeight * 0.8 +
                    ((cart.cartItemList.length > 4
                                ? 3
                                : cart.cartItemList.length - 1) -
                            index) *
                        7,
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
          ),
          AnimatedPositioned(
            duration: Durations.extralong4,
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
              child: MyNetworkImage(
                  imageUrl:
                      cart.cartItemList.last.product.imageUrl?.first ?? ''),
            ),
          ),
        ],
      ),
    );
  }
}
