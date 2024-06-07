// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_grocery_store/controller/firebase/firestore_controller.dart';

import 'package:flutter_grocery_store/model/order_model.dart';
import 'package:provider/provider.dart';

class OrderDetailsScreenController extends ChangeNotifier {
  OrderModel order;
  BuildContext context;
  OrderDetailsScreenController({
    required this.context,
    required this.order,
  }) {
    _initOrderListener();
  }

  void _initOrderListener() {
    context
        .read<FireStoreController>()
        .ordersCollection
        .doc(order.collectionDocumentId)
        .snapshots()
        .listen(
      (event) {
        if (event.data() != null) {
          order = event.data()!.copyWith(
                collectionDocumentId: event.id,
              );
          notifyListeners();
        }
      },
    );
  }
}
