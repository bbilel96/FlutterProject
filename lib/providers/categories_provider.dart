import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/category.dart';

class CategoriesProvider with ChangeNotifier {
  List<Category> _categories = [];

  List<Category> get items {
    return [..._categories];
  }

  Future<void> fetchAndSetCategories() async {
    try {
      final response =
          await http.get(Uri.https('localhost:44370', 'api/Category'));
      final responseData = json.decode(response.body) as List<dynamic>;
      _categories = responseData.map((value) {
        return Category(
            categoryId: value['categoryId'],
            categoryName: value['categoryName'],
            categoryImage: value['categoryImage']);
      }).toList();
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }
}
