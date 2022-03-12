import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../../../core/API/CoreModels/base_response_model.dart';import '../../../../core/API/CoreModels/empty_model.dart';import '../../../../core/API/errors/base_error.dart';

import '/features/Notifications/data/models/GetNotificationRequest.dart';
import '/features/Notifications/data/models/Notification.dart';
import '/features/Notifications/data/models/NotificationsList.dart';
import '/features/Notifications/domain/repository/NotificationRepository.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit() : super(NotificationInitial());

  List<Notifications> notifications;
  int maxResultCount = 20;
  int skipCount = 0;

  getNotifications({bool loadMore = false})async{

    if(!loadMore)
    {
      skipCount = 0;
      emit(NotificationLoading());
    }
    else
      skipCount += maxResultCount;


    var requestData = GetNotificationRequest(
      maxResultCount: maxResultCount,
      skipCount: skipCount
    );
    var response = await NotificationRepository.getNotifications(requestData);
    if(response is NotificationList)
    {
      if(loadMore)
      notifications.addAll(response.list as List<Notifications>);
      else
        notifications = response.list;


      emit(GetNotificationSuccessfully
        (notifications: notifications ,
          noMoreData: response.list.length==0)
      );
    }
    else if(response is BaseError)  emit(NotificationError(response.message));
    else if (response is ServerError) emit(NotificationError(response.message));

  }
  static readNotification(String id)async{
    var response = await NotificationRepository.readNotification(id);
    return response is EmptyModel;
  }
  updateFCMToken(String token)async{
    var response = await NotificationRepository.updateFCMToken(token);
    print(response);
    return response is EmptyModel;

  }
}
