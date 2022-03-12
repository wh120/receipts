
import 'SharedPreferencesProvider.dart';

import '/features/App/data/LocalizationResponse.dart';

class AppSharedPreferences {
  
  //todo move these to constants
  static const KEY_ACCESS_TOKEN = "PREF_KEY_ACCESS_TOKEN";
  static const KEY_LANG = "PREF_KEY_LANG";
  static const KEY_FIRST_TIME = "PREF_KEY_FIRST_TIME";
  static const KEY_PERMISSIONS = "PREF_KEY_PERMISSIONS";
  static const KEY_LOCALIZATION = "PREF_KEY_LOCALIZATION";

  static bool initialized;
  static SharedPreferencesProvider _pref;
  static init() async {
    _pref = await SharedPreferencesProvider.getInstance();
  }
  static clear() {
    _pref.clear();
  }
  static clearForLogOut() {
    removeAccessToken();
  }

  //accessToken
  static String get accessToken => _pref.read(KEY_ACCESS_TOKEN);
  static set accessToken(String accessToken) => _pref.save(KEY_ACCESS_TOKEN, accessToken);
  static bool get hasAccessToken => _pref.contains(KEY_ACCESS_TOKEN);
  static removeAccessToken() => _pref.remove(KEY_ACCESS_TOKEN);



  //language
  static String get lang => _pref.read(KEY_LANG);
  static set lang(String lang) => _pref.save(KEY_LANG, lang);

  //FIRST_TIME
  static bool get firstTime {
    if(_pref.readBoolean(KEY_FIRST_TIME) == null)
      firstTime = true;

    return _pref.readBoolean(KEY_FIRST_TIME);
  }
  static set firstTime(bool first) => _pref.saveBoolean(KEY_FIRST_TIME, first);

  //permission
  static List<dynamic> get permissions => _pref.read(KEY_PERMISSIONS);
  static set permissions(List<String> accessToken) => _pref.save(KEY_PERMISSIONS, accessToken);

  //localization
  static  Map<String, dynamic> get localization => _pref.read(KEY_LOCALIZATION);
  static set localization( Map<String, Localization> localization) => _pref.save(KEY_LOCALIZATION, localization);

}
