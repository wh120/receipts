import 'package:flutter/material.dart';
import '../../../../core/constants/AppColors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class SignInButton extends StatelessWidget {
  final VoidCallback onPressed;

  const SignInButton({Key key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      child: Text(
        "sign_in".tr(),
        style: TextStyle(
            fontSize: 13.0.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white),
      ),
      color: AppColors.primary,
      elevation: 5,
      minWidth: 25.0.w,
      height: 8.0.h,

      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)),
    );
  }
}
