import 'package:equatable/equatable.dart';

import '../../domain/entities/category_entity.dart';
import '../../domain/entities/product_entity.dart';

enum HomeStatus { initial, loading, success, failure }

class HomeState extends Equatable {
  final HomeStatus status;
  final List<CategoryEntity> categories;
  final List<ProductEntity> products;

  final int? selectedCategoryId;
  final String searchQuery;
  final String? errorMessage;

  // Pagination
  final bool isLoadingMore;
  final bool hasReachedMax;
  final bool loadMoreFailed;

  const HomeState({
    this.status = HomeStatus.initial,
    this.categories = const [],
    this.products = const [],
    this.selectedCategoryId,
    this.searchQuery = '',
    this.errorMessage,
    this.isLoadingMore = false,
    this.hasReachedMax = false,
    this.loadMoreFailed = false,
  });

  HomeState copyWith({
    HomeStatus? status,
    List<CategoryEntity>? categories,
    List<ProductEntity>? products,
    int? selectedCategoryId,
    bool clearCategory = false,
    String? searchQuery,
    String? errorMessage,
    bool? isLoadingMore,
    bool? hasReachedMax,
    bool? loadMoreFailed,
  }) {
    return HomeState(
      status: status ?? this.status,
      categories: categories ?? this.categories,
      products: products ?? this.products,
      selectedCategoryId:
          clearCategory ? null : (selectedCategoryId ?? this.selectedCategoryId),
      searchQuery: searchQuery ?? this.searchQuery,
      errorMessage: errorMessage,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      loadMoreFailed: loadMoreFailed ?? this.loadMoreFailed,
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
        isLoadingMore,
        hasReachedMax,
        loadMoreFailed,
      ];
}