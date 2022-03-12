import '../../../../core/API/CoreModels/base_result_model.dart';
import '/features/Notifications/data/models/Notification.dart';

class NotificationList extends ListResultModel<Notifications> {
  int totalCount;
  NotificationList({this.totalCount , List list })  ;

  NotificationList.fromJson(Map<String, dynamic> json){
    totalCount = json['totalCount'];
    if (json['items'] != null) {
      list = [];
      json['items'].forEach((v) {
        list.add(new Notifications.fromJson(v));
      });
    }
  }


}

