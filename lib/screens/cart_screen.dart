import 'package:flutter/material.dart';

import '../state/cart_model.dart';
import '../theme/app_theme.dart';

/// Cart page: lists added products, allows removing them (simulation)
class CartScreen extends StatelessWidget {
  const CartScreen({super.key, required this.cart});

  static const routeName = '/cart';

  final CartModel cart;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cart')),
      body: ListenableBuilder(
        listenable: cart,
        builder: (context, _) {
          if (cart.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.shopping_cart_outlined, size: 64, color: Colors.grey.shade400),
                  const SizedBox(height: 12),
                  const Text('Your cart is empty',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 4),
                  Text('Add items to start shopping',
                      style: TextStyle(color: Colors.grey.shade600)),
                ],
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: cart.count,
            separatorBuilder: (_, __) => const Divider(indent: 16, endIndent: 16),
            itemBuilder: (context, index) {
              final product = cart.items[index];
              return ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Image.asset(product.image, width: 56, height: 56, fit: BoxFit.cover),
                ),
                title: Text(product.name, style: const TextStyle(fontWeight: FontWeight.w600)),
                subtitle: Text(product.price,
                    style: const TextStyle(color: AppTheme.primary, fontWeight: FontWeight.w600)),
                trailing: IconButton(
                  tooltip: 'Remove',
                  icon: const Icon(Icons.delete_outline),
                  onPressed: () => cart.removeAt(index),
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
          child: ListenableBuilder(
            listenable: cart,
            builder: (context, _) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Total', style: TextStyle(fontSize: 16)),
                      Text('\$${cart.total.toStringAsFixed(2)}',
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  FilledButton(
                    onPressed: cart.isEmpty
                        ? null
                        : () {
                            cart.clear();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Order placed (simulation)')),
                            );
                          },
                    child: const Text('Checkout'),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
