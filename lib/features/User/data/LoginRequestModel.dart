class LoginRequestModel {
  String userNameOrEmailAddress;
  String password;
  bool rememberClient;
  String phoneNumber;
  String verificationCode;

  LoginRequestModel(
      {this.userNameOrEmailAddress,
        this.password,
        this.rememberClient,
        this.phoneNumber,
        this.verificationCode});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userNameOrEmailAddress'] = this.userNameOrEmailAddress;
    data['password'] = this.password;
    data['rememberClient'] = this.rememberClient;
    data['phoneNumber'] = this.phoneNumber;
    data['verificationCode'] = this.verificationCode;
    return data;
  }

}
