import '../../../../core/constants/AppTheme.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/AppColors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_styles.dart';
class IconFooter extends StatefulWidget {
  @override
  _IconFooterState createState() => _IconFooterState();
}

class _IconFooterState extends State<IconFooter> {
  @override
  Widget build(BuildContext context) {
    return _buildFooter();
  }
  _buildFooter() {
    return Align(
      alignment: FractionalOffset.bottomCenter,
      child: Container(
        decoration: BoxDecoration(
            boxShadow: AppStyles.redShadow,
            shape: BoxShape.circle

        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              textDirection: TextDirection.ltr,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround  ,
              children: [
                Card(
                  shadowColor: AppColors.primary[200],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(35.0),
                  ),
                  elevation: 10,
                  child: Container(

                    //    decoration: BoxDecoration(boxShadow: AppStyles.Shadow),
                      child: Opacity(
                        opacity: 0.7,
                        child: Image.asset('assets/images/icons/stem_cells.png' ,
                          //  width: 8.0.w,
                          height: 6.0.h ,

                        ),
                      )
                  ),
                ),
                Icon(Icons.add),
                Card(
                  shadowColor: AppColors.primary[200],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(35.0),
                  ),
                  elevation: 10,
                  child: Container(
                    //decoration: BoxDecoration(boxShadow: AppStyles.Shadow),
                      child: Opacity(
                        opacity: 0.7,
                        child: Image.asset(
                          'assets/images/icons/svu.png' ,
                          // width: 8.0.w ,
                          height: 6.0.h,


                        ),
                      )
                  ),
                ),
              ],
            ),
            Text(
              'Made With ♡ By ITLand Technologies',
              style: AppTheme.headline5,

            ),
          ],
        ),
      ),
    );
  }
}
