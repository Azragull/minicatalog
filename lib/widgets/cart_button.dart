import 'package:flutter/material.dart';

import '../screens/cart_screen.dart';
import '../state/cart_model.dart';

/// App bar icon that opens the cart and shows the number of items
class CartButton extends StatelessWidget {
  const CartButton({super.key, required this.cart});

  final CartModel cart;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: cart,
      builder: (context, _) {
        return IconButton(
          tooltip: 'Cart',
          onPressed: () => Navigator.pushNamed(context, CartScreen.routeName),
          icon: Badge(
            isLabelVisible: cart.count > 0,
            label: Text('${cart.count}'),
            child: const Icon(Icons.shopping_bag_outlined),
          ),
        );
      },
    );
  }
}
