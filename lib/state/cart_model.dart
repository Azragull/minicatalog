import 'package:flutter/foundation.dart';

import '../models/product.dart';

/// Simple cart state. Widgets listening to it rebuild when it changes.
class CartModel extends ChangeNotifier {
  final List<Product> _items = [];

  List<Product> get items => List.unmodifiable(_items);

  int get count => _items.length;

  bool get isEmpty => _items.isEmpty;

  double get total => _items.fold(0, (sum, p) => sum + p.priceValue);

  void add(Product product) {
    _items.add(product);
    notifyListeners();
  }

  void removeAt(int index) {
    _items.removeAt(index);
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}
