import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';


const APP_NAME = 'My Health';




// Languages
const DEFAULT_LANGUAGE = 'ar';
const Map<String,Locale> LANGUAGES = {
  'ar':Locale('ar'),
  'en': Locale('en'),
};


// Headers
const HEADER_LANGUAGE = 'Language';
const HEADER_AUTH = 'authorization';
const HEADER_CONTENT_TYPE = 'Content-Type';
const HEADER_ACCEPT = 'accept';



enum NotificationType{
  NULL,
  DelegationGranted,
  DelegationEnded,
  NewApprovalRequestAdded,
  ApprovalRequestRejected,
  ApprovalRequestApproved,
  ItemMinQuantityReached,
  TaskAssigned,
  TaskLateFirstReminder,
  TaskLateSecondReminder,
  TaskLateEscalation
}

enum Gender {
male , female
}

enum NotificationsState{
  Unread,  Read
}

enum ContactType
{
  Landline,
  PhoneNumber,
  Email,
  Website,
  Other

}