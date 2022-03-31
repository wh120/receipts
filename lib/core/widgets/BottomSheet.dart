import 'package:flutter/material.dart';
import '../constants/AppColors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'CustomButton.dart';
import 'package:easy_localization/easy_localization.dart';

class MyBottomSheet{

  static showConfirmBottomSheet({context , String text ,   ValueChanged<bool> onClicked , Widget form  }) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 10,
        enableDrag: true,
        isScrollControlled: true,
        context: context,
        builder: (BuildContext bc) {
          return Padding(
            padding: EdgeInsets.only(bottom: 3.0.h , top:  3.0.h , right: 3.0.w , left: 3.0.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding:  EdgeInsets.only(bottom: 3.0.h),
                  child: Text(text ,),
                ),
                form??Container(),

                Container(
                  child: new Wrap(
                    direction: Axis.horizontal,
                    children: <Widget>[
                      CustomButton(
                        text: 'Confirm'.tr(),
                        onPressed: () {
                          onClicked(true);
                          Navigator.pop(context);
                          // cubit.finishTask(task);
                        },
                      ),
                      CustomButton(
                        color: AppColors.grey,
                        text: 'Cancel'.tr(),
                        onPressed: () {
                          onClicked(false);
                          Navigator.pop(context);
                          // cubit.finishTask(task);
                        },
                      )
                    ],
                  ),
                ),

              ],
            ),
          );
        }
        );
  }
}