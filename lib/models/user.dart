import 'package:food_order_app/models/meal.dart';
import 'Order.dart';

class User {
  final int userId;
  final String firstName;
  final String lastName;
  final String email;
  final String telephone;
  final String password;
  final Order commandes;
  final List<Meal> favoriteMeals;

  User({
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.telephone,
    required this.password,
    required this.commandes,
    required this.favoriteMeals,
  });
}
