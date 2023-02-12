
import '../../../features/receipt/data/receipt_list_response.dart';
import 'package:get_it/get_it.dart';

class ServiceLocator{
  static void registerModels(){

    GetIt.I.registerLazySingleton<CubitsStore>(() => CubitsStore() );



    // GetIt.I.registerLazySingleton<PermissionListResponse>(() => PermissionListResponse() );
    // GetIt.I.registerLazySingleton<LocalizationResponse>(() => LocalizationResponse( localizations: Map()) );

  }

  static T instance<T> (){
    return GetIt.I<T>();
  }
  static CubitsStore getCubitsStore (){
    return GetIt.I<CubitsStore>();
  }


}

class CubitsStore{
  // List<Receipt> receipts;
  Map<String , Receipt> receipts;
  Receipt receipt;


  CubitsStore();

}


