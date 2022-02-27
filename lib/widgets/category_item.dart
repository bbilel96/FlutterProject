import 'package:flutter/material.dart';
import 'package:food_order_app/models/category.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart';
import '../screens/product_detail_screen.dart';
import '../providers/product.dart';

class CategoryItem extends StatelessWidget {
  final Category category;

  const CategoryItem({
    required this.category,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Card(
        elevation: 10,
        child: GridTile(
          child: GestureDetector(
            child: Image.network(
              category.categoryImage,
              fit: BoxFit.cover,
              height: 200,
            ),
          ),
          footer: GridTileBar(
            backgroundColor: Colors.indigo,
            title: FittedBox(
              child: Text(
                category.categoryName,
                textAlign: TextAlign.center,
                softWrap: false,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
