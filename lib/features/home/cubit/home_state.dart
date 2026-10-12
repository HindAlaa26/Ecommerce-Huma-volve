import 'package:equatable/equatable.dart';

import '../models/category_model.dart';
import '../models/product_model.dart';

enum HomeStatus { initial, loading, success, failure }

class HomeState extends Equatable {
  final HomeStatus status;
  final List<CategoryModel> categories;
  final List<ProductModel> products;

  final int? selectedCategoryId;
  final String searchQuery;
  final String? errorMessage;

  const HomeState({
    this.status = HomeStatus.initial,
    this.categories = const [],
    this.products = const [],
    this.selectedCategoryId,
    this.searchQuery = '',
    this.errorMessage,
  });

  HomeState copyWith({
    HomeStatus? status,
    List<CategoryModel>? categories,
    List<ProductModel>? products,
    int? selectedCategoryId,
    bool clearCategory = false,
    String? searchQuery,
    String? errorMessage,
  }) {
    return HomeState(
      status: status ?? this.status,
      categories: categories ?? this.categories,
      products: products ?? this.products,
      selectedCategoryId:
          clearCategory ? null : (selectedCategoryId ?? this.selectedCategoryId),
      searchQuery: searchQuery ?? this.searchQuery,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        categories,
        products,
        selectedCategoryId,
        searchQuery,
        errorMessage,
      ];
}
