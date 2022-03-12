
import '../../../../AppSettings.dart';

class ApiURLs {

   static const String BASE_URL = AppSettings.BASE_URL;

   static const String VERIFY_LOGIN = BASE_URL +'/api/TokenAuth/VerifyLoginFromPatiantApp';
   static const String OTP_AUTH_LOGIN = BASE_URL +'/api/services/app/Account/LoginFromPatientApp';
   static const String GET_PERMISSIONS = BASE_URL +'/api/services/app/User/GetCurrentUserPermissions';
   static const String CHANGE_LANGUAGE = BASE_URL +'/api/services/app/User/ChangeLanguage';

   static const String GET_DASHBOARD = BASE_URL +'/api/services/app/Dashboard/GetDashboard';

   static const String GET_NOTIFICATIONS = BASE_URL +'/api/services/app/Notification/GetUserNotifications';
   static const String READ_NOTIFICATIONS = BASE_URL +'/api/services/app/Notification/MarkNotificationAsRead';
   static const String SET_FCM_TOKEN = BASE_URL +'/api/services/app/User/SetCurrentFcmToken';

   static const String GET_LOCALIZATION = BASE_URL +'/api/services/app/Language/GetAll';


   static const String GET_DOCTORS  = BASE_URL +'/api/services/app/Doctor/GetAllDoctors';
   static const String GET_DOCTOR  = BASE_URL +'/api/services/app/Doctor/GetDoctor';
   static const String GET_CLINICS = BASE_URL +'/api/services/app/Clinic/GetAll';
   static const String GET_SPECIALITIES = BASE_URL +'/api/services/app/Speciality/GetAll';
   static const String GET_HEALTH_CARE_CENTERS = BASE_URL +'/api/services/app/HealthCareCenter/GetAll';
   static const String GET_HEALTH_CARE_CENTER = BASE_URL +'/api/services/app/HealthCareCenter/Get';

   static const String GET_SLIDER_IMAGES = BASE_URL +'/api/services/app/SliderImage/GetAll';
   static const String GET_ABOUT_US = BASE_URL +'/api/services/app/Page/Get';
   static const String GET_POSTS = BASE_URL +'/api/services/app/Posts/GetAll';

   static const String GET_APPOINTMENTS = BASE_URL +'/api/services/app/Appointment/GetAll';
   static const String GET_PATIENT_CARDS = BASE_URL +'/api/services/app/Patient/GetAll';
   static const String CREATE_PATIENT_CARDS = BASE_URL +'/api/services/app/Patient/Create';
   static const String GET_INTERVAL = BASE_URL +'/api/services/app/DoctorShiftInterval/GetSuggestedIntervalsForAppointment';


}

class EAVApiURLs {

   static const String BASE_URL = AppSettings.EAV_BASE_URL;

   static const String GET_ATTRIBUTE_GROUP = BASE_URL +'/api/services/app/AttributeGroup/Get';
   static const String CREATE_ENTITY = BASE_URL +'/api/services/app/Entity/Create';
}

class MedconURLs{

   static const String GET_ALL_SPECIALTIES = 'http://samma3thakeem.com/API/api/Specialties/List';
   static const String GET_ALL_DOCTORS = 'http://samma3thakeem.com/API/api/MedicalAgents/List';

}
