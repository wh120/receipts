part of 'notification_cubit.dart';

@immutable
abstract class NotificationState {}

class NotificationInitial extends NotificationState {}

class GetNotificationSuccessfully  extends NotificationState {
   final List<Notifications> notifications;
   final bool noMoreData;

   GetNotificationSuccessfully({this.notifications, this.noMoreData});
}

class NotificationLoading extends NotificationState {}
class NotificationError extends NotificationState {
  final String message;


  NotificationError(this.message);
}

