import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_grocery_store/controller/firebase/firestore_controller.dart';
import 'package:flutter_grocery_store/model/category_model.dart';
import 'package:flutter_grocery_store/model/product_model.dart';
import 'package:flutter_grocery_store/utils/functions/debouncer.dart';
import 'package:provider/provider.dart';

class SearchScreenController extends ChangeNotifier {
  final BuildContext context;
  final TextEditingController searchController = TextEditingController();
  late final FireStoreController firestore;
  late final Debouncer debouncer = Debouncer(milliSeconds: 4000);
  List<ProductModel> productList = [];
  List<List<ProductModel>> productCategoryList = [];

  String get text => searchController.text.toLowerCase();
  SearchScreenController({required this.context}) {
    firestore = context.read<FireStoreController>();
    searchController.addListener(onTextChanged);
    _initproductCategoryList();
  }

  onTextChanged() {
    if (text.isEmpty) {
      productList.clear();
      debouncer.cancel();
      notifyListeners();
      return;
    }

    List<String?> categoryList = firestore.categoryList
        .where((element) => element.name?.toLowerCase().contains(text) ?? false)
        .map((e) => e.collectionDocumentId)
        .toList();
    log(categoryList.toString());

    // search in product name
    productList = firestore.productList
        .where(
          (element) => (element.name?.toLowerCase().contains(text) ?? false),
        )
        .toList();

    // search in product description
    productList.addAll(
      firestore.productList.where(
        (element) =>
            (element.description?.toLowerCase().contains(text) ?? false),
      ),
    );

    // search in product category
    productList.addAll(
      firestore.productList.where(
        (element) => (categoryList.contains(element.categoryId)),
      ),
    );

    // remove duplicate items
    Set<String?> ids = {};
    productList.removeWhere((element) {
      bool check = ids.contains(element.collectionDocumentId);
      ids.add(element.collectionDocumentId);
      return check;
    });

    if (productList.isNotEmpty) {
      // debouncer for adding recent search in firestore
      debouncer.run(() {
        try {
          context.read<FireStoreController>().addRecentSearch(text);
        } on Exception catch (e) {
          log(e.toString());
        }
      });
    } else {
      debouncer.cancel();
    }
    notifyListeners();
  }

  void setTextAndSearch(String text) {
    searchController.text = text;
  }

  void _initproductCategoryList() {
    var firestore = context.read<FireStoreController>();
    productCategoryList = firestore.categoryList.map(
      (e) {
        var result = firestore.productList
            .where((element) => element.categoryId == e.collectionDocumentId)
            .toList();
        if (result.length > 3) {
          result.shuffle();
          return result.getRange(0, 3).toList();
        }
        return result..shuffle();
      },
    ).toList();
    productCategoryList.removeWhere((element) => element.isEmpty);
    notifyListeners();
  }

  CategoryModel? getCategory(String? categoryId) {
    return context.read<FireStoreController>().categoryList.firstWhereOrNull(
        (element) => element.collectionDocumentId == categoryId);
  }
}
