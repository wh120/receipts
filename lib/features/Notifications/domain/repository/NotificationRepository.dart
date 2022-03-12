import '../../../../core/API/CoreModels/base_result_model.dart';
import '../../../../core/API/CoreModels/empty_model.dart';import '../../../../core/API/data_source/remote_data_source.dart';
import '../../../../core/API/http/api_urls.dart';
import '../../../../core/API/http/http_method.dart';

import '/features/Notifications/data/models/GetNotificationRequest.dart';
import '/features/Notifications/data/models/NotificationsList.dart';
import '/features/User/data/LoginRequestModel.dart';
import '/features/User/data/LoginResponseModel.dart';

class NotificationRepository {

  static Future<BaseResultModel> getNotifications(dynamic requestData) async {
    return await RemoteDataSource.request<NotificationList>(
        converter: (json) => NotificationList.fromJson(json),
        method: HttpMethod.GET,
        withAuthentication: true,
        queryParameters: requestData.toJson(),
        url: ApiURLs.GET_NOTIFICATIONS);
  }

  static Future<BaseResultModel> readNotification(String id) async {
    return await RemoteDataSource.request<EmptyModel>(
        converter: (json) => EmptyModel.fromJson(json),
        method: HttpMethod.POST,
        withAuthentication: true,
        data: {'id' : id},
        url: ApiURLs.READ_NOTIFICATIONS);
  }
  static Future<BaseResultModel> updateFCMToken(String token) async {
    return await RemoteDataSource.request<EmptyModel>(
        converter: (json) => EmptyModel.fromJson(json),
        method: HttpMethod.POST,
        withAuthentication: true,
        queryParameters: {'input' : token},
        url: ApiURLs.SET_FCM_TOKEN);
  }
}
