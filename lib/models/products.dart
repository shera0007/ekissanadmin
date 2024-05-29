import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String id;
  final String name;
  final double price;
  final double discount;
  final double stock;
  final bool isGovernmentScheme;
  final String imagePath;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.discount,
    required this.stock,
    required this.imagePath,
    required this.isGovernmentScheme,
  });

  factory Product.fromJson(Map<String, dynamic> json, String id) {
    return Product(
      id: id,
      name: json['name'] ?? '',
      price: json['price'] ?? 0.0,
      discount: json['discount'] ?? 0.0,
      stock: json['stock'] ?? 0.0,
      isGovernmentScheme: json['isGovernmentScheme'] ?? false,
      imagePath: json['imagepath']?? '',
    );
  }

    factory Product.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Product(
      id: doc.id,
      name: data['name'] ?? '',
      price: (data['price'] is int) ? (data['price'] as int).toDouble() : data['price'].toDouble(),
      discount: (data['discount'] is int) ? (data['discount'] as int).toDouble() : data['discount'].toDouble(),
      stock: data['stock'],
      imagePath: data['imagePath'] ?? '',
      isGovernmentScheme: data['isGovernmentScheme'] ?? false,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'price': price,
      'discount': discount,
      'stock': stock,
      'isGovernmentScheme': isGovernmentScheme,
      'imagePath': imagePath,
    };
  }
}
