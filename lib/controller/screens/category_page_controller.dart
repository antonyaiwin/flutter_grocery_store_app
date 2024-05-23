import 'package:flutter/material.dart';
import 'package:flutter_grocery_store/controller/firebase/firestore_controller.dart';
import 'package:flutter_grocery_store/model/category_model.dart';
import 'package:flutter_grocery_store/model/product_model.dart';
import 'package:provider/provider.dart';

class CategoryPageController extends ChangeNotifier {
  String selectedCategoryId = '';
  bool isLoading = false;
  final BuildContext context;
  List<ProductModel> filteredProducts = [];

  List<ProductModel> get productsList =>
      context.read<FireStoreController>().productList;
  List<CategoryModel> get categoryList =>
      context.read<FireStoreController>().categoryList;

  CategoryPageController({required this.context}) {
    if (categoryList.isEmpty) {
      return;
    }
    selectedCategoryId = categoryList[0].collectionDocumentId ?? '';
    changeCategory(selectedCategoryId);
  }

  void changeCategory(String categoryId) {
    selectedCategoryId = categoryId;
    isLoading = true;
    notifyListeners();
    filteredProducts.clear();
    filteredProducts.addAll(productsList
        .where((element) => element.categoryId == selectedCategoryId));
    isLoading = false;
    notifyListeners();
  }
}
