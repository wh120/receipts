import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import '../../../../core/utils/SharedPreferences/SharedPreferencesHelper.dart';
import '/features/App/data/LocalizationResponse.dart';
import '/features/App/domain/repo/ApplicationRepository.dart';
import '/features/Notifications/domain/cubit/notification_cubit.dart';

part 'application_state.dart';

class ApplicationCubit extends Cubit<ApplicationState> {

  ApplicationCubit() : super(ApplicationInitial());




  static Future<bool> getLocalization() async{
    if( AppSharedPreferences.localization == null){

      var response= await ApplicationRepository.getLocalization();
      if(response is LocalizationResponse)
        return saveLocalizationInCache(response.localizations);
      else return false;
    }
    else{
      ApplicationRepository.getLocalization().then((response) {
        if(response is LocalizationResponse)
           saveLocalizationInCache(response.localizations);
         });
      return true;
    }

  }
  static saveLocalizationInCache( Map<String, Localization> localizations){
    // AppSharedPreferences.localization = localizations;
    // return true;
  }
  static saveLocalizationInLocator( Map<String, Localization> localizations){
    GetIt.I<LocalizationResponse>().localizations = localizations;
  }

 // static _awaitLocalization()async{
 //    var response= await ApplicationRepository.getLocalization();
 //    if(response is LocalizationResponse)
 //    {
 //      GetIt.I<LocalizationResponse>().localizations =response.localizations;
 //    }
 //  }
  static String translate(String key) {
    var localizations = AppSharedPreferences.localization;
   if(localizations.containsKey(key)){
     if(AppSharedPreferences.lang == 'ar')
     return localizations[key]['arabicValue'];
     else  return localizations[key]['englishValue'];
   }
   else
     return key;
  }

}
