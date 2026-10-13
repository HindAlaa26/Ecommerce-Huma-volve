import 'package:equatable/equatable.dart';

import 'category_entity.dart';

class ProductEntity extends Equatable {
  final int id;
  final String title;
  final double price;
  final String description;
  final List<String> images;
  final CategoryEntity? category;

  const ProductEntity({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.images,
    this.category,
  });

  String get imageUrl => images.isNotEmpty ? images.first : '';

  @override
  List<Object?> get props => [id, title, price, description, images, category];
}
