import 'package:flutter/material.dart';

import '../models/product.dart';
import '../services/product_service.dart';
import '../state/cart_model.dart';
import '../theme/app_theme.dart';
import '../widgets/cart_button.dart';
import '../widgets/product_card.dart';
import 'product_detail_screen.dart';

/// Home page: search bar, banner and product grid
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.cart});

  static const routeName = '/';

  final CartModel cart;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final Future<List<Product>> _productsFuture;
  String _query = '';

  @override
  void initState() {
    super.initState();
    _productsFuture = ProductService.loadProducts();
  }

  /// Simple search: filters products by name
  List<Product> _filter(List<Product> products) {
    if (_query.isEmpty) return products;
    final q = _query.toLowerCase();
    return products.where((p) => p.name.toLowerCase().contains(q)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text.rich(
          TextSpan(
            children: [
              TextSpan(text: 'MINI '),
              TextSpan(text: 'CATALOG', style: TextStyle(color: AppTheme.primary)),
            ],
          ),
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, letterSpacing: 4),
        ),
        actions: [CartButton(cart: widget.cart), const SizedBox(width: 8)],
      ),
      body: FutureBuilder<List<Product>>(
        future: _productsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Could not load products: ${snapshot.error}'));
          }

          final products = _filter(snapshot.data ?? []);

          return SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Search
                TextField(
                  onChanged: (value) => setState(() => _query = value.trim()),
                  decoration: const InputDecoration(
                    hintText: 'Search products',
                    prefixIcon: Icon(Icons.search),
                  ),
                ),
                const SizedBox(height: 12),

                // Banner
                ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: Image.asset('assets/images/banner.png', fit: BoxFit.cover),
                ),
                const SizedBox(height: 16),
                Text(
                  'Products (${products.length})',
                  style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 10),

                // Product grid
                if (products.isEmpty)
                  const Padding(
                    padding: EdgeInsets.only(top: 40),
                    child: Center(child: Text('No products found.')),
                  )
                else
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: products.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: 0.75,
                    ),
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return ProductCard(
                        product: product,
                        // Pass the selected product to the detail page as a route argument
                        onTap: () => Navigator.pushNamed(
                          context,
                          ProductDetailScreen.routeName,
                          arguments: product,
                        ),
                      );
                    },
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
