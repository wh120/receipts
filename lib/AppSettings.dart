import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'core/constants/Keys.dart';
import 'core/constants/constants.dart';
import 'core/utils/SharedPreferences/SharedPreferencesHelper.dart';


class AppSettings {



  // static const String BASE_URL = kDebugMode? 'http://172.20.10.8:1997':'https://alumaracoffe.com/receipts/public';
  // static  String BASE_URL = AppSharedPreferences.baseURL??'http://sh-kd-service.com/receipts_api/public';
  static const String BASE_URL =  'http://sh-kd-service.com/receipts_api/public';

  static const String APK_URL = 'http://greentreasure.co/clinic.apk';
  static const String VERSION = '1.0.0:3';


  static showUpdatePopup(){
    showCupertinoModalPopup<void>(
      context: Keys.navigatorKey.currentContext,
      builder: (BuildContext context) => CupertinoActionSheet(

        title:   Text('Settings'.tr()),
        message:  Text(APP_NAME+ ' $VERSION'),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            child:  Text('Update Application'.tr()),
            onPressed: () {
              Navigator.pop(context);
              upgradeFromUrl();

            },
          ),

        ],
        cancelButton: CupertinoActionSheetAction(
          child:  Text("Cancel".tr() ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
  static void upgradeFromUrl() async {
    // int id = await RUpgrade.upgrade(
    //     APK_URL,
    //     fileName: 'app.apk',
    //     isAutoRequestInstall: true);
    //
    // final snackBar = SnackBar(
    //     action: SnackBarAction(
    //       label: 'Stop' ,
    //       textColor: Colors.white,
    //       onPressed: () {
    //         RUpgrade.cancel(id);
    //       },
    //     ),
    //     duration: Duration(seconds: 100),
    //
    //     content: StreamBuilder(
    //       stream: RUpgrade.stream,
    //       builder: (context, snapshot) {
    //         if(snapshot.hasData)
    //         {
    //           var d = snapshot.data as DownloadInfo;
    //           return Text(d.percent.toString() + '%');
    //         }
    //         else return Text('');
    //       } ,
    //     ));
    //
    //
    // ScaffoldMessenger.of(MyApp.navigatorKey.currentContext).showSnackBar(snackBar);

  }

}
