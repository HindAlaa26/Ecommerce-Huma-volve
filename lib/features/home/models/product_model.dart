import 'category_model.dart';

class ProductModel {
  final int id;
  final String title;
  final double price;
  final String description;
  final List<String> images;
  final CategoryModel? category;

  const ProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.images,
    this.category,
  });

  String get imageUrl => images.isNotEmpty ? images.first : '';

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] as int,
      title: (json['title'] ?? '') as String,
      price: (json['price'] as num?)?.toDouble() ?? 0,
      description: (json['description'] ?? '') as String,
      images: _cleanImages(json['images']),
      category: json['category'] is Map<String, dynamic>
          ? CategoryModel.fromJson(json['category'] as Map<String, dynamic>)
          : null,
    );
  }

  static List<String> _cleanImages(dynamic raw) {
    if (raw is! List) return [];
    return raw
        .map((e) => e.toString().replaceAll(RegExp(r'[\[\]"]'), '').trim())
        .where((e) => e.startsWith('http'))
        .toList();
  }
}
