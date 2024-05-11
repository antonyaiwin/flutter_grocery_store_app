import 'package:flutter/material.dart';
import 'package:flutter_grocery_store/view/home_screen/pages/cart_page.dart';
import 'package:flutter_grocery_store/view/home_screen/pages/home_page.dart';
import 'package:flutter_grocery_store/view/home_screen/pages/my_list_page.dart';

class HomeScreenController extends ChangeNotifier {
  List<Widget> pageList = [
    const HomePage(),
    const SizedBox(),
    const MyListPage(),
    const CartPage(),
  ];
  int selectedPageIndex = 0;

  setSelecetedPageIndex(int index) {
    if (selectedPageIndex != index) {
      selectedPageIndex = index;
      notifyListeners();
    }
  }
}
