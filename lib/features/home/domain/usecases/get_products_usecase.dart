import 'package:dartz/dartz.dart';
import 'package:ecommerce_app_huma_volve/core/error/failures.dart';
import 'package:ecommerce_app_huma_volve/core/usecase/usecase.dart';
import 'package:equatable/equatable.dart';

import '../entities/product_entity.dart';
import '../repositories/home_repository.dart';

class GetProductsParams extends Equatable {
  final int? categoryId;
  final String? title;
  final int offset;
  final int limit;

  const GetProductsParams({
    this.categoryId,
    this.title,
    this.offset = 0,
    this.limit = 20,
  });

  @override
  List<Object?> get props => [categoryId, title, offset, limit];
}

class GetProductsUseCase implements UseCase<List<ProductEntity>, GetProductsParams> {
  final HomeRepository repository;

  GetProductsUseCase(this.repository);

  @override
  Future<Either<Failure, List<ProductEntity>>> call(GetProductsParams params) {
    return repository.getProducts(
      categoryId: params.categoryId,
      title: params.title,
      offset: params.offset,
      limit: params.limit,
    );
  }
}
