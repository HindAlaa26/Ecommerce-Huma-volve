import 'package:dio/dio.dart';
import 'package:ecommerce_app_huma_volve/constants/api_constant.dart';
import 'package:ecommerce_app_huma_volve/network/api_client.dart';

class SignUpService {
  final ApiClient apiClient;

  SignUpService(this.apiClient);

  Future<bool> signUp({
    required String name,
    required String email,
    required String password,
    String avatar = "https://picsum.photos", 
  }) async {
    try {
      Response response = await apiClient.dio.post(
        ApiConstant.signUpEndpoint,
        data: {
          "name": name,
          "email": email,
          "password": password,
          "avatar": avatar,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      }
      return false;
    } catch (e) {
      print("error : $e");
      return false;
    }
  }
}
