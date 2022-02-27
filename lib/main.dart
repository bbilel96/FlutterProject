import 'dart:io';

import 'package:flutter/material.dart';
import 'package:food_order_app/providers/categories_provider.dart';
import 'package:food_order_app/screens/categories_overview_screen.dart';
import 'package:provider/provider.dart';
import '../screens/add_edit_product_screen.dart';
import '../screens/order_screen.dart';
import '../screens/user_products_screen.dart';
import '../providers/orders.dart';
import '../screens/cart_screen.dart';
import '../providers/cart.dart';
import '../screens/product_detail_screen.dart';
import './providers/products.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async{
WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
           apiKey: "AIzaSyDWscFpm7GhyCG476xEKZWxxUvz5uSJ8MM",
  authDomain: "flutter-project-73421.firebaseapp.com",
  projectId: "flutter-project-73421",
  storageBucket: "flutter-project-73421.appspot.com",
  messagingSenderId: "501298118913",
  appId: "1:501298118913:web:d9f16c7afdbeda4eb3db00",
  measurementId: "G-MR3FE1M6W1"));


  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ThemeData theme = ThemeData();

  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CategoriesProvider()),
        ChangeNotifierProvider(create: (context) => Products()),
        ChangeNotifierProvider(create: (context) => Cart()),
        ChangeNotifierProvider(create: (context) => Order()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'MyShop',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          backgroundColor: Colors.grey[200],
          colorScheme: theme.colorScheme.copyWith(
              secondary: Colors.blue.shade800,
              primary: Colors.indigo,
              background: Colors.grey[200]),
          fontFamily: 'Lato',
        ),
        home: CategoriesOverviewScreen(),
        routes: {
          ProductDetailScreen.routeName: (context) =>
              const ProductDetailScreen(),
          CartScrenn.routeName: (context) => const CartScrenn(),
          OrderScreen.routename: (context) => const OrderScreen(),
          UserProductsScreen.routeName: (context) => const UserProductsScreen(),
          AddEditProductScreen.routeName: (context) =>
              const AddEditProductScreen(),
        },
      ),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
