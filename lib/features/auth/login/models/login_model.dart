class LoginModel {
  String? accessToken;
  String? refreshToken;
  LoginModel({this.accessToken,this.refreshToken});

  
  LoginModel.fromJson(Map<String,dynamic> data){
    accessToken = data["access_token"];
    refreshToken = data["refresh_token"];
  }
}