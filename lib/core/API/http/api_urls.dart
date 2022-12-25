
import '../../../../AppSettings.dart';

class ApiURLs {

   static  String BASE_URL = AppSettings.BASE_URL;

   static  String LOGIN = BASE_URL +'/api/auth/login';
   static  String CHANGE_PASSWORD = BASE_URL +'/api/auth/changePassword';
   static  String GET_PROFILE = BASE_URL +'/api/User/profile';
   static  String GET_Users = BASE_URL +'/api/User';
   static  String GET_User = BASE_URL +'/api/User/{id}';


   static  String GET_DEPARTMENTS = BASE_URL +'/api/Department';
   static  String GET_MY_DEPARTMENTS = BASE_URL +'/api/Department/my';
   static  String GET_DEPARTMENT = BASE_URL +'/api/Department/{id}';

   static  String GET_ROLES = BASE_URL +'/api/Role';
   static  String GET_ROLE = BASE_URL +'/api/Role/{id}';

   static  String GET_ITEM_MAIN_CATEGORIES = BASE_URL +'/api/ItemMainCategory';
   static  String GET_ITEM_MAIN_CATEGORY = BASE_URL +'/api/ItemMainCategory/{id}';

   static  String GET_ITEM_CATEGORIES = BASE_URL +'/api/ItemCategory';
   static  String GET_ITEM_CATEGORY = BASE_URL +'/api/ItemCategory/{id}';

   static  String GET_ITEMS = BASE_URL +'/api/Item';
   static  String GET_ITEM = BASE_URL +'/api/Item/{id}';

   static  String GET_TRANSFORMATIONS = BASE_URL +'/api/Transformation';
   static  String GET_INACTIVE_TRANSFORMATIONS = BASE_URL +'/api/Transformation/inactive';
   static  String GET_TRANSFORMATION = BASE_URL +'/api/Transformation/{id}';
   static  String SWITCH_ACTIVE_TRANSFORMATION = BASE_URL +'/api/Transformation/{id}/switchActivation';
   static  String TRANSFORM = BASE_URL +'/api/Transformation/transform';



   static  String CREATE_RECEIPT = BASE_URL +'/api/Receipt';
   static  String CREATE_RECEIPT_TYPE = BASE_URL +'/api/ReceiptType/count/{date}';
   static  String GET_RECEIPTS = BASE_URL +'/api/Receipt';
   static  String GET_MY_APPROVAL_RECEIPTS = BASE_URL +'/api/Receipt/MyApprovalReceipts';
   static  String GET_MY_RECEIPTS = BASE_URL +'/api/Receipt/MyReceipts';
   static  String APPROVE_RECEIPT = BASE_URL +'/api/Receipt/{id}/approveReceipt';

   static  String VERIFY_LOGIN = BASE_URL +'/api/TokenAuth/VerifyLoginFromPatiantApp';
   static  String OTP_AUTH_LOGIN = BASE_URL +'/api/services/app/Account/LoginFromPatientApp';
   static  String GET_PERMISSIONS = BASE_URL +'/api/services/app/User/GetCurrentUserPermissions';



   static  String GET_NOTIFICATIONS = BASE_URL +'/api/services/app/Notification/GetUserNotifications';
   static  String READ_NOTIFICATIONS = BASE_URL +'/api/services/app/Notification/MarkNotificationAsRead';
   static  String SET_FCM_TOKEN = BASE_URL +'/api/services/app/User/SetCurrentFcmToken';





   static  String GET_SLIDER_IMAGES = BASE_URL +'/api/services/app/SliderImage/GetAll';
   static  String GET_ABOUT_US = BASE_URL +'/api/services/app/Page/Get';



}


