
import '../data/profile_response.dart';
import '/core/API/CoreModels/base_result_model.dart';
import '/core/API/data_source/remote_data_source.dart';
import '/core/API/http/api_urls.dart';
import '/core/API/http/http_method.dart';
import '/features/AboutUs/data/AboutUsResponse.dart';
import '/features/Homepage/data/SliderListModel.dart';

class ProfileRepository{

  static Future<BaseResultModel> getProfile( ) async {
    return await RemoteDataSource.request<MyProfile>(
        converter: (json) => MyProfile.fromJson(json),
        method: HttpMethod.GET,
        withAuthentication: true,

        url: ApiURLs.GET_PROFILE);

  }


}