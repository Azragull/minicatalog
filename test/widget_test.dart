import 'package:flutter_test/flutter_test.dart';

import 'package:mini_catalog/main.dart';
import 'package:mini_catalog/models/product.dart';
import 'package:mini_catalog/state/cart_model.dart';

void main() {
  test('Product.fromJson / toJson round trip', () {
    final json = {
      'id': 1,
      'name': 'iPhone 15 Pro',
      'tagline': 'Titanium.',
      'description': 'Desc',
      'price': r'$1,299',
      'currency': 'USD',
      'image': 'assets/images/iphone.jpg',
      'specs': {'chip': 'A17 Pro'},
    };
    final product = Product.fromJson(json);
    expect(product.name, 'iPhone 15 Pro');
    expect(product.priceValue, 1299);
    expect(product.toJson()['specs'], {'chip': 'A17 Pro'});
  });

  test('CartModel adds and removes products', () {
    final cart = CartModel();
    final product = Product.fromJson({
      'id': 2,
      'name': 'HomePod Mini',
      'price': r'$99',
      'image': 'assets/images/homepod_mini.jpg',
    });
    cart.add(product);
    cart.add(product);
    expect(cart.count, 2);
    expect(cart.total, 198);
    cart.removeAt(0);
    expect(cart.count, 1);
  });

  testWidgets('Home screen shows the app title', (tester) async {
    await tester.pumpWidget(MiniCatalogApp(cart: CartModel()));
    expect(find.text('MINI CATALOG'), findsOneWidget);
  });
}
