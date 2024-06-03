import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter_grocery_store/model/order_model.dart';

class OrdersScreenController extends ChangeNotifier {
  static const String _ordersCollectionName = 'orders';

  var firestore = FirebaseFirestore.instance;
  List<OrderModel> orderList = [];

  OrdersScreenController() {
    _initOrdersListener();
  }

  CollectionReference<OrderModel> get _ordersCollection {
    return firestore.collection(_ordersCollectionName).withConverter(
          fromFirestore: (snapshot, options) =>
              OrderModel.fromMap(snapshot.data()!).copyWith(
            collectionDocumentId: snapshot.id,
          ),
          toFirestore: (value, options) => value.toMap(),
        );
  }

  void _initOrdersListener() {
    _ordersCollection
        .orderBy('orderCreatedTime', descending: true)
        .where('createdUserId',
            isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots()
        .listen(
      (event) {
        orderList = event.docs.map((e) => e.data()).toList();
        notifyListeners();
      },
    );
  }
}
