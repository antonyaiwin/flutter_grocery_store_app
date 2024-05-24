import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_grocery_store/controller/screens/category_page_controller.dart';
import 'package:flutter_grocery_store/utils/global_widgets/base_keep_alive_page.dart';
import 'package:flutter_grocery_store/view/home_screen/pages/cart_page.dart';
import 'package:flutter_grocery_store/view/home_screen/pages/category_page.dart';
import 'package:flutter_grocery_store/view/home_screen/pages/home_page.dart';
import 'package:flutter_grocery_store/view/home_screen/pages/favorites_page.dart';
import 'package:provider/provider.dart';

class HomeScreenController extends ChangeNotifier {
  PageController pageController = PageController();
  List<Widget> pageList = [
    const BaseKeepAlivePage(child: HomePage()),
    BaseKeepAlivePage(
      child: ChangeNotifierProvider(
        create: (BuildContext context) =>
            CategoryPageController(context: context),
        child: const CategoryPage(),
      ),
    ),
    const BaseKeepAlivePage(child: FavoritesPage()),
    const BaseKeepAlivePage(child: CartPage()),
  ];
  int selectedPageIndex = 0;

  setSelecetedPageIndex(int index) {
    if (selectedPageIndex != index) {
      selectedPageIndex = index;
      pageController.jumpToPage(
        selectedPageIndex,
      );
      notifyListeners();
    }
  }
}
