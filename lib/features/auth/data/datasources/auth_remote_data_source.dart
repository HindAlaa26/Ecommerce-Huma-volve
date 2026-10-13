import 'package:ecommerce_app_huma_volve/constants/api_constant.dart';
import 'package:ecommerce_app_huma_volve/core/network/api_client.dart';

import '../models/auth_tokens_model.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<AuthTokensModel> login({
    required String email,
    required String password,
  });

  Future<UserModel> signUp({
    required String name,
    required String email,
    required String password,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiClient apiClient;

  AuthRemoteDataSourceImpl(this.apiClient);

  static const String _defaultAvatar = 'https://picsum.photos';

  @override
  Future<AuthTokensModel> login({
    required String email,
    required String password,
  }) async {
    final response = await apiClient.dio.post(
      ApiConstant.loginEndpoint,
      data: {'email': email, 'password': password},
    );
    return AuthTokensModel.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Future<UserModel> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    final response = await apiClient.dio.post(
      ApiConstant.signUpEndpoint,
      data: {
        'name': name,
        'email': email,
        'password': password,
        'avatar': _defaultAvatar,
      },
    );
    return UserModel.fromJson(response.data as Map<String, dynamic>);
  }
}
