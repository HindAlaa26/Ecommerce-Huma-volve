import 'package:ecommerce_app_huma_volve/core/usecase/usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_categories_usecase.dart';
import '../../domain/usecases/get_products_usecase.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetCategoriesUseCase _getCategories;
  final GetProductsUseCase _getProducts;

  int _requestId = 0;

  HomeCubit(this._getCategories, this._getProducts)
      : super(const HomeState());

  GetProductsParams get _productsParams => GetProductsParams(
        categoryId: state.selectedCategoryId,
        title: state.searchQuery,
      );

  Future<void> loadHome() async {
    final id = ++_requestId;
    emit(state.copyWith(status: HomeStatus.loading));

    final categoriesFuture = _getCategories(const NoParams());
    final productsFuture = _getProducts(_productsParams);
    final categoriesResult = await categoriesFuture;
    final productsResult = await productsFuture;

    if (isClosed || id != _requestId) return;

    categoriesResult.fold(
      (failure) => emit(
        state.copyWith(
          status: HomeStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (categories) => productsResult.fold(
        (failure) => emit(
          state.copyWith(
            status: HomeStatus.failure,
            errorMessage: failure.message,
          ),
        ),
        (products) => emit(
          state.copyWith(
            status: HomeStatus.success,
            categories: categories,
            products: products,
          ),
        ),
      ),
    );
  }

  Future<void> selectCategory(int? categoryId) async {
    if (categoryId == state.selectedCategoryId) return;
    emit(state.copyWith(
      selectedCategoryId: categoryId,
      clearCategory: categoryId == null,
      status: HomeStatus.loading,
    ));
    await _fetchProducts();
  }

  Future<void> search(String query) async {
    if (query.trim() == state.searchQuery) return;
    emit(state.copyWith(searchQuery: query.trim(), status: HomeStatus.loading));
    await _fetchProducts();
  }

  Future<void> _fetchProducts() async {
    final id = ++_requestId;
    final result = await _getProducts(_productsParams);

    if (isClosed || id != _requestId) return;

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: HomeStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (products) => emit(
        state.copyWith(status: HomeStatus.success, products: products),
      ),
    );
  }
}
