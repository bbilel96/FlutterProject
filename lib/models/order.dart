// ignore_for_file: file_names

import './meal.dart';

class Order {
  final int orderId;
  final List<Meal> meals;

  Order({
    required this.orderId,
    required this.meals,
  });
}
