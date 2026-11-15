/// Product model created from the JSON data in assets/data/products.json
class Product {
  const Product({
    required this.id,
    required this.name,
    required this.tagline,
    required this.description,
    required this.price,
    required this.currency,
    required this.image,
    required this.specs,
  });

  final int id;
  final String name;
  final String tagline;
  final String description;
  final String price; // e.g. "$1,299"
  final String currency;
  final String image; // asset path, e.g. "assets/images/iphone.jpg"
  final Map<String, String> specs;

  /// Creates a Product from a JSON map
  factory Product.fromJson(Map<String, dynamic> json) {
    final rawSpecs = (json['specs'] as Map<String, dynamic>?) ?? {};
    return Product(
      id: json['id'] as int,
      name: json['name'] as String,
      tagline: json['tagline'] as String? ?? '',
      description: json['description'] as String? ?? '',
      price: json['price'] as String? ?? '',
      currency: json['currency'] as String? ?? 'USD',
      image: json['image'] as String,
      specs: rawSpecs.map((key, value) => MapEntry(key, value.toString())),
    );
  }

  /// Converts the Product back to a JSON map
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'tagline': tagline,
        'description': description,
        'price': price,
        'currency': currency,
        'image': image,
        'specs': specs,
      };

  /// Numeric price used for the cart total, e.g. "$1,299" -> 1299.0
  double get priceValue =>
      double.tryParse(price.replaceAll(RegExp(r'[^0-9.]'), '')) ?? 0;
}
