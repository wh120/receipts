
import '/core/constants/app_styles.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
const CustomEdgeInsetsSymmetric = EdgeInsets.symmetric(
  horizontal: DefaultPadding,
  vertical: DefaultPadding,
);
final iconSize = 15.0;

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final Color color;
  final IconData icon;
  final minWidth;

  CustomButton({
    Key key,
    this.onPressed,
    this.title = 'press',
    this.color = blue,
    this.icon = Icons.circle,
    this.minWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FlatButton.icon(
        minWidth: minWidth ?? 25.w,
        height: 4.h,
        color: color,
        shape: roundedRectangleBorder,
        onPressed: onPressed,
        padding: CustomEdgeInsetsSymmetric,
        icon: Icon(
          icon,
          color: indigoAccent.withOpacity(0.7),
          size: iconSize,
        ),
        label: Text(
          title.tr(),
          style: Theme.of(context)
              .textTheme
              .headline6
              .copyWith(fontSize: SmallFontSize.sp),
        ),
      ),
      decoration: buttonBoxDecoration,
    )
    //     .addNeumorphism(
    //   bottomShadowColor: color.withOpacity(0.4),
    // )
    ;
  }
}

class CustomIconButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final Color color;
  final minWidth;
  final String tooltip;

  CustomIconButton(
      {Key key,
      this.onPressed,
      this.icon = Icons.circle,
      this.color = grey,
      this.minWidth,
      this.tooltip = 'press'})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
            width: minWidth ?? 40,
            height: minWidth ?? 40,
            child: IconButton(
              icon: Icon(
                icon,
                color: indigoAccent.withOpacity(0.7),
                size: iconSize,
              ),
              onPressed: onPressed,
              tooltip: tooltip.tr(),
            ),
            decoration: iconBoxDecoration)
    //     .addNeumorphism(
    //   bottomShadowColor: color.withOpacity(0.4),
    // )
    ;
  }
}

class CustomTextButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final Color color;
  final minWidth;

  CustomTextButton({
    Key key,
    this.onPressed,
    this.title = 'press',
    this.color = blue,
    this.minWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: buttonBoxDecoration,
//        padding: EdgeInsets.all(0.5.h),
      child: FlatButton(
        minWidth: minWidth ?? 20.w,
        height: 4.h,
        color: color,
        shape: roundedRectangleBorder,
        onPressed: onPressed,
        padding: CustomEdgeInsetsSymmetric,
        child: Text(
          title.tr(),
          style: Theme.of(context).textTheme.bodyText2.copyWith(
              fontSize: SmallFontSize.sp,
              color: color == grey ? indigoAccent : white),
        ),
      ),
    )
    //     .addNeumorphism(
    //   bottomShadowColor: color.withOpacity(0.4),
    // )
    ;
  }
}
