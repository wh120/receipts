import '../../../../core/API/CoreModels/base_result_model.dart';
import '../../../../core/API/CoreModels/empty_model.dart';import '../../../../core/API/data_source/remote_data_source.dart';
import '../../../../core/API/http/api_urls.dart';
import '../../../../core/API/http/http_method.dart';

import '/features/User/data/LoginRequestModel.dart';
import '/features/User/data/LoginResponseModel.dart';
import '/features/User/data/PermissionListResponseModel.dart';

class UserRepository {
  static Future<BaseResultModel> login(LoginRequestModel loginModel) async {


    return await RemoteDataSource.request<LoginResponseModel>(
        converter: (json) => LoginResponseModel.fromJson(json),
        method: HttpMethod.POST,
        data: loginModel.toJson(),
        withAuthentication: false,
        url: ApiURLs.LOGIN);
  }

  static Future<BaseResultModel> getPermissions( ) async {
    return await RemoteDataSource.request<PermissionListResponse>(
        converter: (json) => PermissionListResponse.fromJson(json),
        method: HttpMethod.GET,
        withAuthentication: true,
        url: ApiURLs.GET_PERMISSIONS);
  }

  static Future<BaseResultModel> changeLanguage(String lang ) async {
    return await RemoteDataSource.request<EmptyModel>(
        converter: (json) => EmptyModel.fromJson(json),
        method: HttpMethod.POST,
        withAuthentication: true,
        data: {
          "languageName": lang
        },
    //    url: ApiURLs.CHANGE_LANGUAGE
    );
  }
}
