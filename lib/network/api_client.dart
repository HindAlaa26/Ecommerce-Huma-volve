import 'package:dio/dio.dart';
import 'package:ecommerce_app_huma_volve/constants/api_constant.dart';

class ApiClient {
  late Dio dio;
  ApiClient()
  {
    dio = Dio(BaseOptions(
      baseUrl: ApiConstant.baseUrl,
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20)
    ));
  }
  
}