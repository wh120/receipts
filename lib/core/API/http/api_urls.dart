
import '../../../../AppSettings.dart';

class ApiURLs {

   static const String BASE_URL = AppSettings.BASE_URL;

   static const String LOGIN = BASE_URL +'/api/auth/login';
   static const String GET_PROFILE = BASE_URL +'/api/auth/profile';


   static const String GET_DEPARTMENTS = BASE_URL +'/api/Department';
   static const String GET_ITEMS = BASE_URL +'/api/Item';

   static const String VERIFY_LOGIN = BASE_URL +'/api/TokenAuth/VerifyLoginFromPatiantApp';
   static const String OTP_AUTH_LOGIN = BASE_URL +'/api/services/app/Account/LoginFromPatientApp';
   static const String GET_PERMISSIONS = BASE_URL +'/api/services/app/User/GetCurrentUserPermissions';



   static const String GET_NOTIFICATIONS = BASE_URL +'/api/services/app/Notification/GetUserNotifications';
   static const String READ_NOTIFICATIONS = BASE_URL +'/api/services/app/Notification/MarkNotificationAsRead';
   static const String SET_FCM_TOKEN = BASE_URL +'/api/services/app/User/SetCurrentFcmToken';





   static const String GET_SLIDER_IMAGES = BASE_URL +'/api/services/app/SliderImage/GetAll';
   static const String GET_ABOUT_US = BASE_URL +'/api/services/app/Page/Get';



}


