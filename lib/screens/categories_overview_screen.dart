import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart';
import '../screens/cart_screen.dart';
import '../widgets/app_drawer.dart';
import '../widgets/badge.dart';
import '../widgets/categories_grid.dart';
import '../providers/categories_provider.dart';
import '../widgets/show_error.dart';

class CategoriesOverviewScreen extends StatelessWidget {
  static const routeName = '/categories';
  CategoriesOverviewScreen({Key? key}) : super(key: key);
  bool isInit = false;
  bool isLoading = false;

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> refreshProducts(BuildContext context) async {
    Provider.of<CategoriesProvider>(context, listen: false)
        .fetchAndSetCategories();
  }

  @override
  Widget build(BuildContext context) {
    if (!isInit) {
      Provider.of<CategoriesProvider>(context)
          .fetchAndSetCategories()
          .then((value) => isLoading = false)
          .catchError((error) {
        isLoading = false;
        showDialog(
            context: context,
            builder: (context) {
              return const ShowError(
                title: 'An error occured !',
                content: 'Error when attempting to load products',
              );
            });
      });
    }
    isInit = true;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meals Categories'),
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          Consumer<Cart>(
            builder: (_, cartData, child) => Badge(
              child: child!,
              value: cartData.itemCount.toString(),
              color: Colors.red.shade700,
            ),
            child: IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: () async{
                //await firestore.collection("projects").add({"title": "bilel"});
                Navigator.of(context).pushNamed(CartScrenn.routeName);
              },
            ),
          )
        ],
      ),
      drawer: const AppDrawer(),
      body: RefreshIndicator(
        onRefresh: () => refreshProducts(context),
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : CategoriesGrid(),
      ),
    );
  }
}
