
import '/core/API/CoreModels/base_result_model.dart';
import '/core/API/data_source/remote_data_source.dart';
import '/core/API/http/api_urls.dart';
import '/core/API/http/http_method.dart';
import '/features/Homepage/data/SliderListModel.dart';

class SlideRepository{

  static Future<BaseResultModel> getSlides( ) async {
    return await RemoteDataSource.request<SliderListModel>(
        converter: (json) => SliderListModel.fromJson(json),
        method: HttpMethod.GET,
        withAuthentication: true,
        queryParameters: {'MaxResultCount':50},
        url: ApiURLs.GET_SLIDER_IMAGES);

  }


}