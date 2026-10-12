import 'package:ecommerce_app_huma_volve/constants/api_constant.dart';
import 'package:ecommerce_app_huma_volve/network/api_client.dart';

import '../models/category_model.dart';
import '../models/product_model.dart';

class HomeService {
  final ApiClient apiClient;

  HomeService(this.apiClient);

  Future<List<CategoryModel>> getCategories() async {
    final response = await apiClient.dio.get(ApiConstant.categoriesEndpoint);
    return (response.data as List)
        .map((e) => CategoryModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

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
