import 'package:flutter_bloc/flutter_bloc.dart';

import '../../home/domain/usecases/get_product_by_id_usecase.dart';
import 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  final GetProductByIdUseCase _getProductById;

  ProductDetailsCubit(this._getProductById)
      : super(const ProductDetailsState());

  Future<void> load(int id) async {
    emit(const ProductDetailsState(status: ProductDetailsStatus.loading));

    final result = await _getProductById(GetProductByIdParams(id));

    if (isClosed) return;

    result.fold(
      (failure) => emit(
        ProductDetailsState(
          status: ProductDetailsStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (product) => emit(
        ProductDetailsState(
          status: ProductDetailsStatus.success,
          product: product,
        ),
      ),
    );
  }
}