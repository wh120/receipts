import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../constants/AppColors.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final Color color;

  const CustomButton({Key key, this.onPressed, this.text, this.color=AppColors.primary}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.all(1.0.w),
      child: MaterialButton(
        onPressed:  onPressed,
        //since this is only a UI app
        child: Text(
          text,
          style: TextStyle(
            fontSize: 15.0.sp,
            //  fontFamily: 'SFUIDisplay',
            //   fontWeight: FontWeight.bold,
          ),
        ),
        color: color,
        elevation: 2,

        // minWidth: 400,
        // height: 50,
        textColor: Colors.white,

        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4)
        ),
      ),
    );
  }
}
