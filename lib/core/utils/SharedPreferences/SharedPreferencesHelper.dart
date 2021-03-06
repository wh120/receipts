
import 'SharedPreferencesProvider.dart';

import '/features/App/data/LocalizationResponse.dart';

class AppSharedPreferences {
  
  //todo move these to constants
  static const KEY_ACCESS_TOKEN = "PREF_KEY_ACCESS_TOKEN";
  static const KEY_LANG = "PREF_KEY_LANG";
  static const KEY_FIRST_TIME = "PREF_KEY_FIRST_TIME";
  static const KEY_PERMISSIONS = "PREF_KEY_PERMISSIONS";
  static const KEY_LOCALIZATION = "PREF_KEY_LOCALIZATION";
  static const KEY_IS_ADMIN= "PREF_KEY_IS_ADMIN";
  static const KEY_BASE_URL= "PREF_KEY_BASE_URL";

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
    isAdmin=false;
  }

  //accessToken
  static String get accessToken => _pref.read(KEY_ACCESS_TOKEN);
  static set accessToken(String accessToken) => _pref.save(KEY_ACCESS_TOKEN, accessToken);
  static bool get hasAccessToken => _pref.contains(KEY_ACCESS_TOKEN);
  static removeAccessToken() => _pref.remove(KEY_ACCESS_TOKEN);

  //isAdmin
  static bool get isAdmin => _pref.read(KEY_IS_ADMIN);
  static set isAdmin(bool admin) => _pref.save(KEY_IS_ADMIN, admin);


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

  //BASE_URL
  static  String get baseURL => _pref.read(KEY_BASE_URL);
  static set baseURL( String url) => _pref.save(KEY_BASE_URL, url);
}
