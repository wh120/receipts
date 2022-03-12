import '/features/Notifications/data/models/Notification.dart';

import '../../../../core/Boilerplate/Pagination/cubits/pagination_cubit.dart';
import '../../../../core/Boilerplate/Pagination/widgets/PaginationList.dart';
import '/features/Notifications/domain/repository/NotificationRepository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/AppColors.dart';
import '../../../../core/constants/app_styles.dart';
import '../../../../core/widgets/errors/NoDataWidget.dart';
import '/features/Notifications/presentation/widgets/NotifcationCard.dart';
import 'package:easy_localization/easy_localization.dart';


class NotificationsListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: ListUpButton(
      //   scrollController: _scrollController,
      // ),

      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Notifications".tr(),
      )),
      body: pagination(),
    );
  }
  pagination(){
    RepositoryCallBack getData = (data) => NotificationRepository.getNotifications(data);
    return PaginationList<Notifications>(
     repositoryCallBack: getData,
      listBuilder: (List<Notifications> list) => _buildNotifications(list),
    );
  }

  _buildNotifications( List notifications) {

    if(notifications.length == 0 )
      return NoDataWidget(
        message: "No ِnotifications".tr(),
      );
    else

    return Padding(
      padding: AppStyles.horizontalPadding,
      child: ListView.separated(

        itemCount: notifications.length,
        itemBuilder: (context, index) {
          return InkWell(
            child: NotifcationCard(
              notification: notifications[index],
            ),
            onTap: (){

            },
          );
        },
        separatorBuilder: (context, index) {
          return Divider(
            // thickness: 5,
            endIndent: 5.0.w,
            indent: 5.0.w,
            height: 0,
            color: AppColors.lightText,
          );
        },
      ),
    );

  }
}

