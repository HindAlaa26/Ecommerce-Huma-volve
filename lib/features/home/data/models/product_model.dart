import '../../domain/entities/product_entity.dart';
import 'category_model.dart';

class ProductModel extends ProductEntity {
  const ProductModel({
    required super.id,
    required super.title,
    required super.price,
    required super.description,
    required super.images,
    super.category,
  });

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
