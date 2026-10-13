import 'package:dartz/dartz.dart';
import 'package:ecommerce_app_huma_volve/core/error/error_handler.dart';
import 'package:ecommerce_app_huma_volve/core/error/failures.dart';

import '../../domain/entities/category_entity.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/repositories/home_repository.dart';
import '../datasources/home_remote_data_source.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;

  HomeRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<CategoryEntity>>> getCategories() async {
    try {
      final categories = await remoteDataSource.getCategories();
      return Right(categories);
    } catch (e) {
      return Left(mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> getProducts({
    int? categoryId,
    String? title,
    int offset = 0,
    int limit = 20,
  }) async {
    try {
      final products = await remoteDataSource.getProducts(
        categoryId: categoryId,
        title: title,
        offset: offset,
        limit: limit,
      );
      return Right(products);
    } catch (e) {
      return Left(mapExceptionToFailure(e));
    }
  }
}
