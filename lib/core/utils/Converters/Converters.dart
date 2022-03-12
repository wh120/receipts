import '/core/utils/SharedPreferences/SharedPreferencesHelper.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

class MyConverter{

  static bool toBoolean(String str, [bool strict = false]) {
    str =str.toLowerCase();
    if (strict == true) {
      return str == '1' || str == 'true';
    }
    return str != '0' && str != 'false' && str != '';
  }

  static int stringToNumber(String stringNumber){

    if(stringNumber == null) return null;
    if(stringNumber.isEmpty) return null;
    Map numbers = {
      '٠':'0',
      '١':'1',
      '٢':'2',
      '٣':'3',
      '٤' :'4',
      '٥' :'5',
      '٦' :'6',
      '٧' :'7',
      '٨' :'8',
      '٩' :'9',
      '0':'0',
      '1':'1',
      '2':'2',
      '3':'3',
      '4' :'4',
      '5' :'5',
      '6' :'6',
      '7' :'7',
      '8' :'8',
      '9' :'9',
      '.' :'.',
      '،':'.'
    };

    String newNumber ='';

    for(int i =0 ; i < stringNumber.length ; i++){
      if(numbers.containsKey(stringNumber[i]))
        newNumber+=numbers[stringNumber[i]];

    }
    if(newNumber.isEmpty)
      return 0;

    return int.parse(newNumber);
  }

  static String timeToTimeAgo(DateTime dateTime){


    timeago.setLocaleMessages('ar', timeago.ArMessages());

    timeago.setLocaleMessages('en', timeago.EnMessages());

    return timeago.format(dateTime , locale:AppSharedPreferences.lang); // 15 min ago
  }

}