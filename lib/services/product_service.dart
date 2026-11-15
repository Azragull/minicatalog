import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

import '../models/product.dart';

/// Reads the product list from the local JSON file (API simulation)
class ProductService {
  static const _path = 'assets/data/products.json';

  static Future<List<Product>> loadProducts() async {
    final raw = await rootBundle.loadString(_path);
    final list = jsonDecode(raw) as List<dynamic>;
    return list
        .map((item) => Product.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}
