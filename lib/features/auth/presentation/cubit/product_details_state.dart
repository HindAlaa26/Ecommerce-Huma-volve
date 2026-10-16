import 'package:equatable/equatable.dart';

import '../../home/domain/entities/product_entity.dart';

enum ProductDetailsStatus { initial, loading, success, failure }

class ProductDetailsState extends Equatable {
  final ProductDetailsStatus status;
  final ProductEntity? product;
  final String? errorMessage;

  const ProductDetailsState({
    this.status = ProductDetailsStatus.initial,
    this.product,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [status, product, errorMessage];
}