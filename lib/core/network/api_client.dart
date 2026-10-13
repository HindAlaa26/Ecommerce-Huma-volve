import 'package:dio/dio.dart';
import 'package:ecommerce_app_huma_volve/constants/api_constant.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiClient {
  late Dio dio;

  ApiClient() {
    dio = Dio(BaseOptions(
      baseUrl: ApiConstant.baseUrl,
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
    ));
    dio.interceptors.add(
      PrettyDioLogger(requestHeader: false, requestBody: false, responseBody: false),
    );
  }
}