import 'package:flutter/material.dart';
import 'package:flutter_grocery_store/controller/firebase/firestore_controller.dart';
import 'package:flutter_grocery_store/model/category_model.dart';
import 'package:flutter_grocery_store/model/product_model.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';

class CategoryPageController extends ChangeNotifier {
  String selectedCategoryId = '';
  bool isLoading = false;
  final BuildContext context;
  List<ProductModel> filteredProducts = [];

  ScrollController productsScrollController = ScrollController();

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
    if (categoryId == selectedCategoryId) {
      return;
    }
    selectedCategoryId = categoryId;
    isLoading = true;

    notifyListeners();
    filteredProducts = productsList
        .where((element) => element.categoryId == selectedCategoryId)
        .toList();
    productsScrollController.animateTo(
      0,
      duration: Durations.medium4,
      curve: Curves.easeInOut,
    );
    isLoading = false;
    notifyListeners();
  }

  String getCurrentCategoryName() {
    return categoryList
            .firstWhereOrNull(
                (element) => element.collectionDocumentId == selectedCategoryId)
            ?.name ??
        'Category';
  }
}
