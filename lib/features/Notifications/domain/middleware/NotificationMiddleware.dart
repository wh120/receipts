 import '../../../../core/constants/constants.dart';
import '/features/Notifications/data/models/Notification.dart';

class NotificationMiddleware{

 static forward( Notifications notification){

    switch(notification.type)
    {
      case NotificationType.DelegationGranted:
      // TODO: Handle this case.
        break;
      case NotificationType.DelegationEnded:
      // TODO: Handle this case.
        break;

        break;
      case NotificationType.NULL:
        // TODO: Handle this case.
        break;
    }
  }
  static _goToTaskPage(int id){

  }


}