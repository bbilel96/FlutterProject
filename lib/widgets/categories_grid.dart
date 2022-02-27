import 'package:flutter/material.dart';
import 'package:food_order_app/providers/categories_provider.dart';
import 'package:provider/provider.dart';
import '../widgets/category_item.dart';

class CategoriesGrid extends StatelessWidget {
  const CategoriesGrid({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final categories = Provider.of<CategoriesProvider>(context).items;
    return GridView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: categories.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (context, index) {
          return CategoryItem(category: categories[index]);
        });
  }
}
