// lib/models/product.dart
class Product {
  final int id;
  final String name;
  final String description;
  final String price;

  Product(
      {required this.id,
      required this.name,
      required this.description,
      required this.price}
      );

  // Factory constructor to create a Product from JSON
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        price: json['price']);
  }

  // Method to convert Product to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
    };
  }
}
