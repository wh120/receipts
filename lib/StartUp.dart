import 'core/Notification/notification.dart';
import 'core/utils/SharedPreferences/SharedPreferencesHelper.dart';

import 'package:get_it/get_it.dart';
import 'core/utils/ServiceLocator/ServiceLocator.dart';



class StartUp
{
  static void setup()async {
    ServiceLocator.registerModels();
    await AppSharedPreferences.init();
   await Messaging.initFCM();


  }


}
