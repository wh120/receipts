import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../core/constants/AppColors.dart';
import '../../../../core/constants/app_styles.dart';
import '../../../../core/constants/constants.dart';
import '/features/Notifications/data/models/Notification.dart';
import '/features/Notifications/domain/cubit/notification_cubit.dart';
import '/features/Notifications/domain/middleware/NotificationMiddleware.dart';


class NotifcationCard extends StatefulWidget {
  final Notifications  notification;


  const NotifcationCard({Key key ,this.notification}) : super(key: key);

  @override
  _NotifcationCardState createState() => _NotifcationCardState();
}

class _NotifcationCardState extends State<NotifcationCard> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      tileColor:  widget.notification.state == NotificationsState.Unread ? AppColors.secondary[50] : null,
      title: Text(
        widget.notification.notificationName,
      ),
      leading: FittedBox(
        child: Icon(
          Icons.check_circle_outline_rounded,
          size: 50.0.sp,
          color: AppColors.primary,
        ),
      ),
      onTap: () {

        NotificationCubit.readNotification(widget.notification.id);
        NotificationMiddleware.forward(widget.notification);
        setState(() {
          widget.notification.state = NotificationsState.Read;
        });
      },
      subtitle: Text( widget.notification.message),
    );
  }
}
