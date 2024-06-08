import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_grocery_store/model/address_model.dart';

import 'package:flutter_grocery_store/model/category_model.dart';
import 'package:flutter_grocery_store/model/order_model.dart';
import 'package:flutter_grocery_store/model/product_model.dart';

class FireStoreController extends ChangeNotifier {
  static const String _categoryCollectionName = 'categories';
  static const String _productsCollectionName = 'grocery-shop/data/products';
  static const String _userDataCollectionName = 'users';
  static const String _favouritesCollectionName = 'favourites';
  static const String _addressesCollectionName = 'addresses';
  static const String _ordersCollectionName = 'orders';

  String get uid => FirebaseAuth.instance.currentUser!.uid;

  FirebaseFirestore get db => FirebaseFirestore.instance;
  List<CategoryModel> categoryList = [];
  List<ProductModel> productList = [];
  List<String> favouritesList = [];
  List<AddressModel> addressList = [];
  String? defaultAddressId;

  FireStoreController() {
    _initUserDataListener();
    _initCategoriesListener();
    _initProductsListener();
    _initFavouritesListener();
    _initAddressListener();
  }

  CollectionReference<OrderModel> get ordersCollection {
    return db.collection(_ordersCollectionName).withConverter(
          fromFirestore: (snapshot, options) =>
              OrderModel.fromMap(snapshot.data()!).copyWith(
            collectionDocumentId: snapshot.id,
          ),
          toFirestore: (value, options) => value.toMap(),
        );
  }

  CollectionReference<ProductModel> get productsCollection {
    return db.collection(_productsCollectionName).withConverter(
          fromFirestore: (snapshot, options) =>
              ProductModel.fromMap(snapshot.data()!).copyWith(
            collectionDocumentId: snapshot.id,
          ),
          toFirestore: (value, options) => value.toMap(),
        );
  }

  String? getLastCategoryIndex() {
    return categoryList.isEmpty
        ? '0'
        : categoryList[categoryList.length - 1].id;
  }

  int? getLastProductIndex() {
    return productList.isEmpty ? 0 : productList[productList.length - 1].id;
  }

  _initUserDataListener() {
    db.collection(_userDataCollectionName).doc(uid).snapshots().listen((event) {
      var data = event.data();
      defaultAddressId = data?['default_address'];
      notifyListeners();
    });
  }

  _initCategoriesListener() {
    db
        .collection(_categoryCollectionName)
        .orderBy('id')
        .snapshots()
        .listen((event) {
      categoryList = event.docs
          .map((e) => CategoryModel.fromQueryDocumentSnapshot(e))
          .toList();
      notifyListeners();
    });
  }

  void _initProductsListener() {
    db
        .collection(_productsCollectionName)
        .orderBy('id')
        .snapshots()
        .listen((event) {
      productList = event.docs
          .map((e) => ProductModel.fromQueryDocumentSnapshot(e))
          .toList();
      notifyListeners();
    });
  }

  void _initFavouritesListener() {
    db
        .collection('$_userDataCollectionName/$uid/$_favouritesCollectionName')
        .orderBy('date_added', descending: true)
        .snapshots()
        .listen((event) {
      favouritesList = event.docs.map((e) => e.id).toList();
      notifyListeners();
    });
  }

  void _initAddressListener() {
    db
        .collection('$_userDataCollectionName/$uid/$_addressesCollectionName')
        .snapshots()
        .listen((event) {
      addressList = event.docs
          .map((e) => AddressModel.fromQueryDocumentSnapshot(e))
          .toList();
      notifyListeners();
    });
  }

// CATEGORY CRUD Operation

  Future<void> addCategory(CategoryModel category) async {
    await db.collection(_categoryCollectionName).add(category.toMap())
        /* .onError((error, stackTrace) {
      log(stackTrace.toString());
      log(error.toString());
    }) */
        ;
    log('addCategory completed');
  }

  Future<void> updateCategory(CategoryModel category) async {
    await db
        .collection(_categoryCollectionName)
        .doc(category.collectionDocumentId)
        .update({
      if (category.name != null) 'name': category.name,
      if (category.imageUrl != null) 'imageUrl': category.imageUrl,
    });
    log('updateCategory completed');
  }

  Future<bool> deleteCategory(String categoryId) async {
    try {
      await db.collection(_categoryCollectionName).doc(categoryId).delete()
          /* .onError((error, stackTrace) =>
              log('deleteCategory onError : $error \n $stackTrace')) */
          ;
      return true;
    } on FirebaseException catch (e) {
      log('deleteCategory FirebaseException: ${e.code}');
      return false;
    }
  }

  CategoryModel? getCategoryById(String id) {
    return categoryList
        .firstWhereOrNull((element) => element.collectionDocumentId == id);
  }

  ProductModel? getProductById(String id) {
    return productList
        .firstWhereOrNull((element) => element.collectionDocumentId == id);
  }

  // PRODUCTS CRUD Operation

  Future<DocumentReference<Map<String, dynamic>>> addProduct(
      ProductModel product) async {
    var ref = await db
        .collection(_productsCollectionName)
        .add(product.toMapWithoutNull());
    log('addProduct completed');
    return ref;
  }

  Future<List<ProductModel>> getProductByCategory(String? categoryId) async {
    List<ProductModel> list = [];
    if (categoryId == null) {
      return list;
    }
    var data = await db
        .collection(_productsCollectionName)
        .where('categoryId', isEqualTo: categoryId)
        .get();
    list = data.docs
        .map((e) => ProductModel.fromQueryDocumentSnapshot(e))
        .toList();
    return list;
  }

  Future<void> updateProduct(ProductModel product) async {
    await db
        .collection(_productsCollectionName)
        .doc(product.collectionDocumentId)
        .update(product.toMapWithoutNull());
    log('updateProduct completed');
  }

  Future<bool> deleteProduct(String productId) async {
    try {
      await db.collection(_productsCollectionName).doc(productId).delete()
          /*  .onError((error, stackTrace) =>
              log('deleteProduct onError : $error \n $stackTrace')) */
          ;
      return true;
    } on FirebaseException catch (e) {
      log('deleteProduct FirebaseException: ${e.code}');
      return false;
    }
  }

  Future<List<ProductModel>> searchProductsUsingBarcode(String text) async {
    List<ProductModel> list = [];
    try {
      var data = await db
          .collection(_productsCollectionName)
          .where('barcode', isEqualTo: text)
          .get();
      list = data.docs
          .map((e) => ProductModel.fromQueryDocumentSnapshot(e))
          .toList();
    } on FirebaseException catch (e) {
      log('searchProductsUsingBarcode FirebaseException: ${e.code}');
    }
    return list;
  }

  // Favorites CRUD Operation

  Future<void> addFavorite(
    ProductModel product,
  ) async {
    var ref = db
        .collection('$_userDataCollectionName/$uid/$_favouritesCollectionName');
    log(ref.path);
    await ref.doc(product.collectionDocumentId).set({
      'date_added': DateTime.now().millisecondsSinceEpoch,
    });

    log('Favourites add completed');
  }

  Future<void> deleteFavorite(
    ProductModel product,
  ) async {
    var ref = db
        .collection('$_userDataCollectionName/$uid/$_favouritesCollectionName');
    log(ref.path);
    await ref.doc(product.collectionDocumentId).delete();

    log('Favourites delete completed');
  }

  // Orders CRUD Operation
  Future<DocumentReference<OrderModel>> addOrder(OrderModel order) async {
    var ref = await ordersCollection.add(order);
    log('order added completed');

    return ref;
  }

  // Addresses CRUD Operation

  Future<void> addAddress(
    AddressModel address,
  ) async {
    var ref = db
        .collection('$_userDataCollectionName/$uid/$_addressesCollectionName');
    log(ref.path);
    await ref.add(address.toMapWithoutNull());

    log('Address add completed');
  }

  Future<List<AddressModel>> getAddressList() async {
    var ref = db
        .collection('$_userDataCollectionName/$uid/$_addressesCollectionName');
    log(ref.path);

    log('Address reading');

    return (await ref.get())
        .docs
        .map((e) => AddressModel.fromQueryDocumentSnapshot(e))
        .toList();
  }

  Future<void> updateAddress(
    AddressModel address,
  ) async {
    var ref = db
        .collection('$_userDataCollectionName/$uid/$_addressesCollectionName');
    log(ref.path);
    await ref
        .doc(address.collectionDocumentId)
        .update(address.toMapWithoutNull());

    log('Address update completed');
  }

  Future<void> deleteAddress(
    AddressModel address,
  ) async {
    var ref = db
        .collection('$_userDataCollectionName/$uid/$_addressesCollectionName');
    log(ref.path);
    await ref.doc(address.collectionDocumentId).delete();

    log('Address delete completed');
  }

  // User data CRUD operations
  Future<void> setDefaultAddress(AddressModel address) async {
    var ref = db.collection(_userDataCollectionName).doc(uid);
    log('${(await ref.get()).data()}');
    if ((await ref.get()).data() == null) {
      await ref.set(
        {'default_address': address.collectionDocumentId},
      );
    } else {
      await ref.update(
        {'default_address': address.collectionDocumentId},
      );
    }
  }

  Future<AddressModel?> getDefaultAddress() async {
    if (defaultAddressId == null) {
      return null;
    } else {
      return addressList.firstWhereOrNull(
          (element) => element.collectionDocumentId == defaultAddressId);
    }
  }
}
