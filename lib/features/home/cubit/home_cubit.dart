import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/category_model.dart';
import '../models/product_model.dart';
import '../services/home_service.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeService _service;

  int _requestId = 0;

  HomeCubit(this._service) : super(const HomeState());

  Future<void> loadHome() async {
    final id = ++_requestId;
    emit(state.copyWith(status: HomeStatus.loading));
    try {
      final results = await Future.wait([
        _service.getCategories(),
        _service.getProducts(
          categoryId: state.selectedCategoryId,
          title: state.searchQuery,
        ),
      ]);
      if (id != _requestId) return;
      emit(state.copyWith(
        status: HomeStatus.success,
        categories: results[0] as List<CategoryModel>,
        products: results[1] as List<ProductModel>,
      ));
    } catch (e) {
      if (id != _requestId) return;
      emit(state.copyWith(status: HomeStatus.failure, errorMessage: _mapError(e)));
    }
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
    try {
      final products = await _service.getProducts(
        categoryId: state.selectedCategoryId,
        title: state.searchQuery,
      );
      if (id != _requestId) return;
      emit(state.copyWith(status: HomeStatus.success, products: products));
    } catch (e) {
      if (id != _requestId) return;
      emit(state.copyWith(status: HomeStatus.failure, errorMessage: _mapError(e)));
    }
  }

  String _mapError(Object e) {
    if (e is DioException) {
      switch (e.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          return 'Connection timed out. Please try again.';
        case DioExceptionType.connectionError:
          return 'No internet connection.';
        default:
          return 'Server error${e.response?.statusCode != null ? ' (${e.response!.statusCode})' : ''}. Please try again.';
      }
    }
    return 'Something went wrong. Please try again.';
  }
}
