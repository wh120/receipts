import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../constants/AppColors.dart';
import '../../constants/AppTheme.dart';

class BaseErrorWidget extends StatefulWidget {
  final GestureTapCallback onTap;
  final String title;
  final String subtitle;
  final Widget icon;

  const BaseErrorWidget({Key key, this.onTap, this.title, this.subtitle, this.icon}) : super(key: key);

  @override
  State<BaseErrorWidget> createState() => _BaseErrorWidgetState();
}

class _BaseErrorWidgetState extends State<BaseErrorWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 100.0.w,
        child: InkWell(
          highlightColor: AppColors.secondary[10],
          onTap: widget.onTap,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding:  EdgeInsets.all(5.0.sp),
                child: widget.icon,
              ),
              // Icon(
              //   Icons.error_outline,
              //   color: AppColors.darkerText,
              //   size: 50.0.sp,
              // ),
              Text(
                  widget.title??'',
                  style: AppTheme.headline3
              ),
              Text(widget.subtitle,
                style: AppTheme.headline4,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
