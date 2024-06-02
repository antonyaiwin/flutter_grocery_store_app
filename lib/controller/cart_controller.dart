import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_grocery_store/controller/firebase/firestore_controller.dart';
import 'package:flutter_grocery_store/model/order_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import '../model/address_model.dart';
import '../model/cart_item_model.dart';
import '../model/product_model.dart';
import '../utils/functions/functions.dart';

class CartController extends ChangeNotifier {
  late Box<dynamic> box;
  AddressModel? selectedAddress;
  String? selectedPaymentMethod;
  BuildContext context;
  double deliveryCharge = 20;

  final List<CartItemModel> _cartItemList = [];

  List<CartItemModel> get cartItemList => _cartItemList;
  CartController(
    this.context, {
    this.selectedAddress,
  }) {
    _initHiveStorage();
    _initAddress();
    context.read<FireStoreController>().addListener(() {
      log('listener');
      _initAddress();
    });
  }
  Future<void> _initHiveStorage() async {
    await Hive.initFlutter();
    box = await Hive.openBox('shopping_cart');
    box.watch().listen((event) {
      if (event.value == null) {
        cartItemList.removeWhere(
            (element) => element.product.collectionDocumentId == event.key);
      } else if (cartItemList
          .where((element) => element.product.collectionDocumentId == event.key)
          .isNotEmpty) {}
    });
  }

  addItemToCart(ProductModel item) {
    for (var element in _cartItemList) {
      if (element.product.id == item.id) {
        element.quantity++;
        notifyListeners();
        return;
      }
    }
    _cartItemList.add(CartItemModel(product: item));
    notifyListeners();
  }

  removeItemFromCart(ProductModel item) {
    for (var element in _cartItemList) {
      if (element.product.id == item.id) {
        if (element.quantity <= 1) {
          _cartItemList.remove(element);
        } else {
          element.quantity--;
        }
        notifyListeners();
        return;
      }
    }
    notifyListeners();
  }

  deleteItemFromCart(ProductModel productModel) {
    _cartItemList
        .removeWhere((element) => element.product.id == productModel.id);
    notifyListeners();
  }

// clear all the items in cart
  clearItems() {
    _cartItemList.clear();
    notifyListeners();
  }

  // total items count in cart
  int get totalCartCount => _cartItemList.fold(
      0, (previousValue, element) => previousValue += element.quantity);

  // returns total price of all items in the cart
  double get totalCartPrice => _cartItemList.fold(
      0.0,
      (previousValue, element) => previousValue +=
          (element.product.priceSelling ?? 0) * element.quantity);

  double get finalCartPrice => totalCartPrice + deliveryCharge;

  int getItemCount(int id) {
    for (var element in _cartItemList) {
      if (element.product.id == id) {
        return element.quantity;
      }
    }
    return 0;
  }

  Future<void> _initAddress() async {
    selectedAddress =
        await context.read<FireStoreController>().getDefaultAddress();
  }

  void setSelectedAddress(AddressModel address) {
    selectedAddress = address;
    notifyListeners();
  }

  void setPaymentMethod(String method) {
    selectedPaymentMethod = method;
    notifyListeners();
  }

  bool canCheckout() {
    return selectedAddress != null && selectedPaymentMethod != null;
  }

  Future<void> placeOrder(BuildContext context) async {
    var firestore = context.read<FireStoreController>();
    OrderModel order = OrderModel(
      createdUserId: firestore.uid,
      orderCreatedTime: DateTime.now(),
      cartItems: cartItemList,
      deliveryAddress: selectedAddress,
      paymentMethod: selectedPaymentMethod,
      totalPrice: totalCartPrice,
      deliveryPrice: 20,
      finalPrice: finalCartPrice,
      itemCount: totalCartCount,
    );
    try {
      await firestore.addOrder(order);
    } on Exception catch (e) {
      log(e.toString());
      if (context.mounted) {
        showErrorSnackBar(context: context, content: 'Something went wrong!');
      }
    }
  }
}
