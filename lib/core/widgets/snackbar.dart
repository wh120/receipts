import '../constants/Keys.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../constants/AppColors.dart';

showSnackBar(String message,{bool isLong=false}){
  ScaffoldMessenger.of(Keys.navigatorKey.currentContext)
      .showSnackBar(snackBar(message.toString() ,isLong));
}
snackBar(String message,bool isLong){
  return SnackBar(
    elevation: 25,
    duration: isLong? Duration(seconds: 10):Duration(seconds: 1),
    backgroundColor: AppColors.primary[200],

    content: Text(message),
    action: SnackBarAction(

      label: 'Close'.tr(),
      textColor: Colors.white,
      onPressed: () {
        // Some code to undo the change.
      },
    ),
  );
}

