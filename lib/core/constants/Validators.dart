import 'package:easy_localization/easy_localization.dart';
class Validators{


  static String validateEmptyValue(String value){

    if (value == null || value.isEmpty) {
      return 'The text is empty'.tr();
    }
    return null;

  }

  static String validatePhoneNumber(String value){

    if (value == null || value.isEmpty) {
      return 'The text is empty'.tr();
    }

    if( value.length == 10) return null;
    else if (value.length < 10)
      return "Please_enter_a_longer_x".tr(args: ['Phone Number'.tr()]);
    else return "x_must_not_be_longer_than_y_characters".tr(args: ['Phone Number'.tr() ,'10']);


  }
}