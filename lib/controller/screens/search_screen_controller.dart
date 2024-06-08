import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_grocery_store/controller/firebase/firestore_controller.dart';
import 'package:flutter_grocery_store/model/product_model.dart';
import 'package:provider/provider.dart';

class SearchScreenController extends ChangeNotifier {
  final BuildContext context;
  final TextEditingController searchController = TextEditingController();
  late final FireStoreController firestore;
  List<ProductModel> productList = [];

  String get text => searchController.text.toLowerCase();
  SearchScreenController({required this.context}) {
    firestore = context.read<FireStoreController>();
    searchController.addListener(onTextChanged);
  }

  onTextChanged() {
    if (text.isEmpty) {
      productList.clear();
      notifyListeners();
      return;
    }
    List<String?> categoryList = firestore.categoryList
        .where((element) => element.name?.toLowerCase().contains(text) ?? false)
        .map((e) => e.collectionDocumentId)
        .toList();
    log(categoryList.toString());
    productList = firestore.productList
        .where(
          (element) => (element.name?.toLowerCase().contains(text) ?? false),
        )
        .toList();
    productList.addAll(
      firestore.productList.where(
        (element) =>
            (element.description?.toLowerCase().contains(text) ?? false),
      ),
    );
    productList.addAll(
      firestore.productList.where(
        (element) => (categoryList.contains(element.categoryId)),
      ),
    );
    Set<String?> ids = {};
    productList.removeWhere((element) {
      bool check = ids.contains(element.collectionDocumentId);
      ids.add(element.collectionDocumentId);
      return check;
    });
    notifyListeners();
  }
}
