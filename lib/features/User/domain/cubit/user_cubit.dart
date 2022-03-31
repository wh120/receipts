import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import '../../../../core/API/CoreModels/base_response_model.dart';
import '../../../../core/API/CoreModels/empty_model.dart';
import '../../../../core/API/errors/base_error.dart';
import '../../../../core/utils/SharedPreferences/SharedPreferencesHelper.dart';
import '/features/App/domain/cubit/application_cubit.dart';
import '/features/Notifications/domain/cubit/notification_cubit.dart';
import '/features/User/data/LoginRequestModel.dart';
import '/features/User/data/LoginResponseModel.dart';
import '/features/User/data/PermissionListResponseModel.dart';
import '/features/User/domain/repo/UserRepository.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../core/Notification/notification.dart';



part 'user_state.dart';


class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());

  Future<void> login(String email , String password )async
  {
    emit(LoginLoading());

    var response= await UserRepository.login(  null);

    if(response is OtpLoginResponseModel){
      emit(OtpSuccessfully(response.code));
    }

    else if(response is BaseError){
      print(response.message);
      emit(LoginError(response.message));
    }

    else if (response is ServerError){
      emit(LoginError(response.message));
    }
  }


  Future<void> loginWithToken( )async
  {
    // if(this.state is LoginSuccessfully){
    //   emit(LoginSuccessfully());
    //   return;
    // }
    if(AppSharedPreferences.hasAccessToken){
  //    emit(LoginLoading());

      bool result =await afterLogin();
      // if(result)
      //   emit(LoginSuccessfully());
     // else
       // emit(LoginError('Error occurred while login'.tr()));
    }
  }


  static Future<bool> afterLogin( )async {

    //todo
    bool result = true;//await NotificationCubit().updateFCMToken(Messaging.token);

    if(!result)return false;
   //  var permissionResponse= await UserRepository.getPermissions();
   //  if(permissionResponse is PermissionListResponse){
   //
   // //   AppSharedPreferences.permissions = permissionResponse.permissions;
   //    GetIt.I<PermissionListResponse>().permissions = permissionResponse.permissions;
   //    result = true;
   //  }
   //  else
   //    return false;

  //  connectyCubeLogin();
    await changeLanguage(AppSharedPreferences.lang);
   // result = await ApplicationCubit.getLocalization();
    return result;
  }

  logout() async{
    bool result =await NotificationCubit().updateFCMToken(null);
     AppSharedPreferences.clearForLogOut();
    return result;
  }
  static changeLanguage(String lang) async{
    var response= await UserRepository.changeLanguage(lang);
    return response is EmptyModel;
  }

}
