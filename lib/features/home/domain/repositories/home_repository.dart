import 'package:dartz/dartz.dart';
import 'package:ecommerce_app_huma_volve/core/error/failures.dart';

import '../entities/category_entity.dart';
import '../entities/product_entity.dart';

abstract class HomeRepository {
  Future<Either<Failure, List<CategoryEntity>>> getCategories();

  Future<Either<Failure, List<ProductEntity>>> getProducts({
    int? categoryId,
    String? title,
    int offset = 0,
    int limit = 20,
  });
}
