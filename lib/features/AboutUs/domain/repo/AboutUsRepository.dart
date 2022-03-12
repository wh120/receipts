
import '/core/API/CoreModels/base_result_model.dart';
import '/core/API/data_source/remote_data_source.dart';
import '/core/API/http/api_urls.dart';
import '/core/API/http/http_method.dart';
import '/features/AboutUs/data/AboutUsResponse.dart';
import '/features/Homepage/data/SliderListModel.dart';

class AboutUsRepository{

  static Future<BaseResultModel> getData( ) async {
    return await RemoteDataSource.request<AboutUsResponse>(
        converter: (json) => AboutUsResponse.fromJson(json),
        method: HttpMethod.GET,
        withAuthentication: true,
        queryParameters: {'Id':1},
        url: ApiURLs.GET_ABOUT_US);

  }


}