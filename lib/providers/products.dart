// ignore_for_file: unused_field

import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';
import '../exceptions/http_exception.dart';
import '../configs/configuration.dart';
import './product.dart';

class Products with ChangeNotifier {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<Product> _items = [];
  late bool _showFavoriteOnly = false;

  List<Product> get items {
    return [..._items];
  }

  Future<void> fetchAndSetProducts() async {
    var url = Uri.https(API_URL, '/products.json');
    try {
      final response = await http.get(url);
      final responseData = json.decode(response.body) as Map<String, dynamic>;
      final List<Product> productList = [];
      responseData.forEach((key, value) {
        productList.add(Product(
            id: key,
            title: value['title'],
            description: value['description'],
            price: value['price'],
            imageUrl: value['imageUrl'],
            isfavorite: value['isfavorite']));
      });
      _items = productList;
      notifyListeners();
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  Future<void> addProduct(Product product) async {

    try {
      const uuid = Uuid();
      var id = uuid.v4();
      await firestore.collection("products").add({
          'id': id,
          'title': product.title,
          'description': product.description,
          'price': product.price,
          'imageUrl': product.imageUrl,
          'isfavorite': product.isfavorite

      });
      // final response = await http.post(
      //   url,
      //   body: json.encode({
      //     'title': product.title,
      //     'description': product.description,
      //     'price': product.price,
      //     'imageUrl': product.imageUrl,
      //     'isfavorite': product.isfavorite
      //   }),
      // );
      product = Product(
        id: id,
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
      );
      _items.add(product);
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  void updateProduct(Product product) {
    final productIndex = _items.indexWhere((prod) => prod.id == product.id);
    _items[productIndex] = product;
    notifyListeners();
  }

  List<Product> getFavoriteProducts() {
    return _items.where((product) => product.isfavorite).toList();
  }

  Product getProductById(String productId) {
    return items.firstWhere((product) => product.id == productId);
  }

  Future<void> deleteProduct(String productId) async {
    final url = Uri.https(API_URL, '/products/$productId');
    final existingProdIndex =
        _items.indexWhere((product) => product.id == productId);
    var existingProduct = _items[existingProdIndex];
    _items.removeAt(existingProdIndex);
    notifyListeners();
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      _items.insert(existingProdIndex, existingProduct);
      notifyListeners();
      throw HttpException("could not remove product");
    }
  }

  void toggleFavoriteOnly(bool flag) {
    _showFavoriteOnly = flag;
    notifyListeners();
  }
}
