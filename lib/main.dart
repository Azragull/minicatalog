import 'package:flutter/material.dart';

import 'screens/cart_screen.dart';
import 'screens/home_screen.dart';
import 'screens/product_detail_screen.dart';
import 'state/cart_model.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(MiniCatalogApp(cart: CartModel()));
}

class MiniCatalogApp extends StatelessWidget {
  const MiniCatalogApp({super.key, required this.cart});

  /// Shared cart state (simple state management with ChangeNotifier)
  final CartModel cart;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mini Catalog',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      // Named routes
      initialRoute: HomeScreen.routeName,
      routes: {
        HomeScreen.routeName: (_) => HomeScreen(cart: cart),
        ProductDetailScreen.routeName: (_) => ProductDetailScreen(cart: cart),
        CartScreen.routeName: (_) => CartScreen(cart: cart),
      },
    );
  }
}
