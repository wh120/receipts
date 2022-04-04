import '/core/constants/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GeneralCard extends StatelessWidget {
  final GestureTapCallback onTap;
  final  Widget  child;
  final bool selected;

  const GeneralCard({Key key, this.onTap, this.child, this.selected=false }) : super(key: key);@override
  Widget build(BuildContext context) {
    return _buildCard();
  }
  Widget _buildCard( ) {
    return Material(
      color: Colors.transparent,
      child: Padding(
        padding: EdgeInsets.only(bottom: 0.5.h),
        child: InkWell(
          onTap: onTap ,
          customBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0.r)),
          ),
          child: Card(
              color:selected? AppColors.secondary[50 ]:null,
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0.r),

            ),
            child: Padding(
              padding: EdgeInsets.all(3.0.r),
              child:  child,
            ),
          ),
        ),
      ),
    );
  }
}
