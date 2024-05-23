import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../controller/screens/home_screen_controller.dart';

class HomeBottomNavBar extends StatelessWidget {
  const HomeBottomNavBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeScreenController>(
      builder: (BuildContext context, controller, Widget? child) =>
          BottomNavigationBar(
        currentIndex: controller.selectedPageIndex,
        onTap: (value) {},
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category_outlined),
            activeIcon: Icon(Icons.category),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            activeIcon: Icon(Icons.favorite),
            label: 'Favourites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            activeIcon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
        ],
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
