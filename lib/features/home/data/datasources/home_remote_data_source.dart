import 'package:ecommerce_app_huma_volve/constants/api_constant.dart';
import 'package:ecommerce_app_huma_volve/core/network/api_client.dart';

import '../models/category_model.dart';
import '../models/product_model.dart';

abstract class HomeRemoteDataSource {
  Future<List<CategoryModel>> getCategories();

  Future<List<ProductModel>> getProducts({
    int? categoryId,
    String? title,
    int offset = 0,
    int limit = 20,
  });
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final ApiClient apiClient;

  HomeRemoteDataSourceImpl(this.apiClient);

  @override
  Future<List<CategoryModel>> getCategories() async {
    final response = await apiClient.dio.get(ApiConstant.categoriesEndpoint);
    return (response.data as List)
        .map((e) => CategoryModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<ProductModel>> getProducts({
    int? categoryId,
    String? title,
    int offset = 0,
    int limit = 20,
  }) async {
    final queryParameters = <String, dynamic>{
      'offset': offset,
      'limit': limit,
    };

    if (categoryId != null) {
      queryParameters['categoryId'] = categoryId;
    }
    if (title?.trim().isNotEmpty ?? false) {
      queryParameters['title'] = title!.trim();
    }

    final response = await apiClient.dio.get(
      ApiConstant.productsEndpoint,
      queryParameters: queryParameters,
    );
    return (response.data as List)
        .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
