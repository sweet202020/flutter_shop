import 'package:flutter/material.dart';
import './screens/edit_product.dart';
import './providers/orders.dart';
import 'package:flutter_shop/screens/cart_screen.dart';
import './providers/cart.dart';
import './screens/products_overview_screen.dart';

import './screens/product_details_screen.dart';

import 'package:provider/provider.dart';

import './providers/products_provider.dart';
import './screens/orders_screen.dart';
import './screens/user_products_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Products(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Orders(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          primaryColorLight: Colors.deepOrange,
          fontFamily: 'Lato',
        ),
        home: const ProductsOverviewScreen(),
        routes: {
          ProductDetailsScreen.routeName: (context) =>
              const ProductDetailsScreen(),
          CartScreen.routeName: (ctx) => const CartScreen(),
          OrdersScreen.routeName: (ctx) => const OrdersScreen(),
          UserProductsScreen.routeName: (ctx) => const UserProductsScreen(),
          EditProductScreen.routename: (ctx) => const EditProductScreen(),
        },
      ),
    );
  }
}
