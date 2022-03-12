import '../constants/Keys.dart';
import '/features/Notifications/data/models/Notification.dart';
import '/features/Notifications/domain/middleware/NotificationMiddleware.dart';
//import 'package:flutter_fcm/flutter_fcm.dart';
import '../../../main.dart';


class Messaging {
  static String token;
  static initFCM()async{
    try{
      // await FCM.initializeFCM(
      //     onNotificationPressed: (Map<String, dynamic> data) {
      //       Notifications notification = Notifications.fromFCM(data);
      //       NotificationMiddleware.forward(notification);
      //     },
      //     onTokenChanged: (String token) {
      //       Messaging.token = token;
      //       print(token);
      //     },
      //     icon: 'ic_launcher',
      //   navigatorKey: Keys.navigatorKey
      // );
    }catch(e){}
  }
}