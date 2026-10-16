import 'package:dartz/dartz.dart';
import 'package:ecommerce_app_huma_volve/core/error/failures.dart';
import 'package:ecommerce_app_huma_volve/core/usecase/usecase.dart';
import 'package:equatable/equatable.dart';

import '../entities/product_entity.dart';
import '../repositories/home_repository.dart';

class GetProductByIdParams extends Equatable {
  final int id;

  const GetProductByIdParams(this.id);

  @override
  List<Object?> get props => [id];
}

class GetProductByIdUseCase
    implements UseCase<ProductEntity, GetProductByIdParams> {
  final HomeRepository repository;

  GetProductByIdUseCase(this.repository);

  @override
  Future<Either<Failure, ProductEntity>> call(GetProductByIdParams params) {
    return repository.getProductById(params.id);
  }
}