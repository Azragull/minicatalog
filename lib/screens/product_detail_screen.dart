import 'package:flutter/material.dart';

import '../models/product.dart';
import '../state/cart_model.dart';
import '../theme/app_theme.dart';
import '../widgets/cart_button.dart';

/// Product detail page. The product comes from the route arguments.
class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key, required this.cart});

  static const routeName = '/detail';

  final CartModel cart;

  @override
  Widget build(BuildContext context) {
    // Read the product passed with Navigator.pushNamed(..., arguments: product)
    final product = ModalRoute.of(context)!.settings.arguments as Product;

    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
        actions: [CartButton(cart: cart), const SizedBox(width: 8)],
      ),
      body: ListView(
        children: [
          AspectRatio(
            aspectRatio: 4 / 3,
            child: Image.asset(product.image, fit: BoxFit.cover),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(product.name,
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600)),
                const SizedBox(height: 4),
                Text(product.tagline, style: const TextStyle(color: AppTheme.textMuted)),
                const SizedBox(height: 10),
                Text(
                  product.price,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.primary,
                  ),
                ),
                const SizedBox(height: 20),
                const Text('Description',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
                const SizedBox(height: 6),
                Text(product.description, style: const TextStyle(height: 1.45)),
                const SizedBox(height: 20),
                const Text('Specifications',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600)),
                const SizedBox(height: 6),
                // Simple two-column list of specifications
                ...product.specs.entries.map(
                  (e) => Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: const BoxDecoration(
                      border: Border(bottom: BorderSide(color: AppTheme.border)),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            _capitalize(e.key),
                            style: const TextStyle(color: AppTheme.textMuted),
                          ),
                        ),
                        Text(e.value, style: const TextStyle(fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
          child: FilledButton.icon(
            icon: const Icon(Icons.add_shopping_cart),
            label: const Text('Add to Cart'),
            onPressed: () {
              cart.add(product);
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(content: Text('${product.name} added to cart')),
                );
            },
          ),
        ),
      ),
    );
  }

  static String _capitalize(String s) =>
      s.isEmpty ? s : s[0].toUpperCase() + s.substring(1);
}
