import 'package:flutter/material.dart';
import 'package:flutter_grocery_store/controller/firebase/firestore_controller.dart';
import 'package:flutter_grocery_store/model/product_model.dart';
import 'package:provider/provider.dart';

class ProductDetailsScreenController extends ChangeNotifier {
  List<ProductModel> similarItems = [];
  final ProductModel product;
  final BuildContext context;
  ProductDetailsScreenController(this.context, this.product) {
    fetchSimilarItems();
  }

  fetchSimilarItems() {
    similarItems = context
        .read<FireStoreController>()
        .productList
        .where((element) =>
            element.categoryId == product.categoryId &&
            element.collectionDocumentId != product.collectionDocumentId)
        .toList();
    notifyListeners();
  }
}
