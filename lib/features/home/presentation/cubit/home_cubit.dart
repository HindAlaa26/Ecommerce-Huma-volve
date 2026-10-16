import 'package:ecommerce_app_huma_volve/core/usecase/usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_categories_usecase.dart';
import '../../domain/usecases/get_products_usecase.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  static const int _pageSize = 20;

  final GetCategoriesUseCase _getCategories;
  final GetProductsUseCase _getProducts;

  int _requestId = 0;

  HomeCubit(this._getCategories, this._getProducts)
      : super(const HomeState());

  GetProductsParams _paramsFor({required int offset}) => GetProductsParams(
        categoryId: state.selectedCategoryId,
        title: state.searchQuery,
        offset: offset,
        limit: _pageSize,
      );

  Future<void> loadHome() async {
    final id = ++_requestId;
    emit(state.copyWith(
      status: HomeStatus.loading,
      isLoadingMore: false,
      hasReachedMax: false,
      loadMoreFailed: false,
    ));

    final categoriesFuture = _getCategories(const NoParams());
    final productsFuture = _getProducts(_paramsFor(offset: 0));
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
            hasReachedMax: products.length < _pageSize,
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
      isLoadingMore: false,
      hasReachedMax: false,
      loadMoreFailed: false,
    ));
    await _fetchFirstPage();
  }

  Future<void> search(String query) async {
    if (query.trim() == state.searchQuery) return;
    emit(state.copyWith(
      searchQuery: query.trim(),
      status: HomeStatus.loading,
      isLoadingMore: false,
      hasReachedMax: false,
      loadMoreFailed: false,
    ));
    await _fetchFirstPage();
  }

  /// Loads page 1 for the current category / search query.
  Future<void> _fetchFirstPage() async {
    final id = ++_requestId;
    final result = await _getProducts(_paramsFor(offset: 0));

    if (isClosed || id != _requestId) return;

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: HomeStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (products) => emit(
        state.copyWith(
          status: HomeStatus.success,
          products: products,
          hasReachedMax: products.length < _pageSize,
        ),
      ),
    );
  }

  /// Loads the next page and appends it to the current list.
  /// [retry] = true is used by the "Retry" button after a failed load-more.
  Future<void> loadMore({bool retry = false}) async {
    if (state.status != HomeStatus.success) return;
    if (state.isLoadingMore || state.hasReachedMax) return;
    if (state.loadMoreFailed && !retry) return; // don't auto-retry while scrolling

    // Not incremented: if the user changes category/search meanwhile,
    // _requestId changes and this stale response is ignored.
    final id = _requestId;
    final offset = state.products.length;

    emit(state.copyWith(isLoadingMore: true, loadMoreFailed: false));

    final result = await _getProducts(_paramsFor(offset: offset));

    if (isClosed || id != _requestId) return;

    result.fold(
      (failure) => emit(
        state.copyWith(isLoadingMore: false, loadMoreFailed: true),
      ),
      (newProducts) => emit(
        state.copyWith(
          isLoadingMore: false,
          products: [...state.products, ...newProducts],
          hasReachedMax: newProducts.length < _pageSize,
        ),
      ),
    );
  }
}