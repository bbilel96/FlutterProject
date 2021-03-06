import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screens/add_edit_product_screen.dart';
import '../widgets/app_drawer.dart';
import '../widgets/user_product_item.dart';
import '../providers/products.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/user-products';
  const UserProductsScreen({Key? key}) : super(key: key);

  Future<void> refreshProducts(BuildContext context) async {
    Provider.of<Products>(context, listen: false).fetchAndSetProducts();
  }

  @override
  Widget build(BuildContext context) {
    final productContainer = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AddEditProductScreen.routeName);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: RefreshIndicator(
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: ListView.builder(
            itemBuilder: (context, index) => UserProductItem(
              id: productContainer.items[index].id as String,
              title: productContainer.items[index].title,
              imgUrl: productContainer.items[index].imageUrl,
            ),
            itemCount: productContainer.items.length,
          ),
        ),
        onRefresh: () => refreshProducts(context),
      ),
    );
  }
}
