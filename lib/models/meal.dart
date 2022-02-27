import './category.dart';
import './ingredients.dart';

class Meal {
  final int mealId;
  final String mealName;
  final String mealImg;
  final double mealPrice;
  final String mealDescription;
  final Category mealCategory;
  final Ingredients ingredients;
  final bool isGlutenFree;
  final bool isLactoseFree;
  final bool isVegan;
  final bool isVegetarian;

  Meal({
    required this.mealId,
    required this.mealName,
    required this.mealImg,
    required this.mealPrice,
    required this.mealDescription,
    required this.mealCategory,
    required this.ingredients,
    required this.isGlutenFree,
    required this.isLactoseFree,
    required this.isVegan,
    required this.isVegetarian,
  });
}
