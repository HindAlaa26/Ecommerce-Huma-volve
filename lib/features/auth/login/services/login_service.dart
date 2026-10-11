import 'package:dio/dio.dart';
import 'package:ecommerce_app_huma_volve/constants/api_constant.dart';
import 'package:ecommerce_app_huma_volve/features/auth/login/models/login_model.dart';
import 'package:ecommerce_app_huma_volve/network/api_client.dart';


class LoginService {
  final ApiClient apiClient;

  LoginService(this.apiClient);

  Future<LoginModel?> login({required String email, required String password}) async {
    try {
      Response response = await apiClient.dio.post(
        ApiConstant.loginEndpoint,
        data: {
          "email": email,
          "password": password,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return LoginModel.fromJson(response.data);
      }
      return null;
    } catch (e) {
      print("error when signing in : $e");
      return null;
    }
  }
}
