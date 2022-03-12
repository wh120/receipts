import '../../../../core/API/CoreModels/base_result_model.dart';
import '../../../../core/API/data_source/remote_data_source.dart';
import '../../../../core/API/http/api_urls.dart';
import '../../../../core/API/http/http_method.dart';

import '/features/App/data/LocalizationResponse.dart';

class ApplicationRepository{

  static Future<BaseResultModel> getLocalization()async
  {
    return await RemoteDataSource.request<LocalizationResponse>(
        converter: (json) => LocalizationResponse.fromJson(json),
        method: HttpMethod.GET,
        url: ApiURLs.GET_LOCALIZATION,
        isLongTime: true
    );
  }
}