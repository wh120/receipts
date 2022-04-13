
import '../../../core/API/CoreModels/base_result_model.dart';

class LoginResponseModel extends BaseResultModel{
  String accessToken;
  String encryptedAccessToken;
  int expireInSeconds;
  int userId;
  String language;
  String userName;
  bool isAdmin;


  LoginResponseModel(
      {this.accessToken,
        this.encryptedAccessToken,
        this.expireInSeconds,
        this.userId,
        this.language,
        this.userName,
        this.isAdmin});

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    accessToken = json['accessToken'];
    encryptedAccessToken = json['encryptedAccessToken'];
    expireInSeconds = json['expireInSeconds'];
    userId = json['userId'];
    language = json['language'];
    userName = json['userName'];
    isAdmin = json['isAdmin'];
  }

}

class OtpLoginResponseModel extends BaseResultModel{
  bool canLogin;
  String code;

  OtpLoginResponseModel({this.canLogin, this.code});

  OtpLoginResponseModel.fromJson(Map<String, dynamic> json) {
    canLogin = json['canLogin'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['canLogin'] = this.canLogin;
    data['code'] = this.code;
    return data;
  }
}

