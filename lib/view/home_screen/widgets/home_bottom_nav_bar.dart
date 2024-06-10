import 'package:flutter/material.dart';
import 'package:flutter_grocery_store/controller/cart_controller.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

import '../../../controller/screens/home_screen_controller.dart';
import '../../../utils/global_widgets/floating_cart_widget.dart';

class HomeBottomNavBar extends StatelessWidget {
  const HomeBottomNavBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Consumer2<HomeScreenController, CartController>(
          builder: (context, home, cart, child) {
            return AnimatedContainer(
              height: home.selectedPageIndex == 3 || cart.cartItemList.isEmpty
                  ? 0
                  : kToolbarHeight,
              duration: const Duration(milliseconds: 500),
              child: FloatingCartWidget(
                cart: cart,
              ),
            );
          },
        ),
        Consumer<HomeScreenController>(
          builder: (BuildContext context, controller, Widget? child) =>
              BottomNavigationBar(
            elevation: 1,
            currentIndex: controller.selectedPageIndex,
            onTap: (value) {
              controller.setSelecetedPageIndex(value);
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Iconsax.home_2_outline),
                activeIcon: Icon(Iconsax.home_2_bold),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Iconsax.category_2_outline),
                activeIcon: Icon(Iconsax.category_2_bold),
                label: 'Categories',
              ),
              BottomNavigationBarItem(
                icon: Icon(Iconsax.heart_outline),
                activeIcon: Icon(Iconsax.heart_bold),
                label: 'Favourites',
              ),
              BottomNavigationBarItem(
                icon: Icon(Iconsax.shopping_cart_outline),
                activeIcon: Icon(Iconsax.shopping_cart_bold),
                label: 'Cart',
              ),
            ],
            type: BottomNavigationBarType.fixed,
          ),
        ),
      ],
    );
  }
}
