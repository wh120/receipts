import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../constants/app_assets.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'BaseErrorWidget.dart';

class NoDataWidget extends StatelessWidget {
  final String message;
  const NoDataWidget({Key key, this.message}) : super(key: key);
  @override
  Widget build(BuildContext context) {


    return BaseErrorWidget(
      onTap: null,
      title: message??'No Data'.tr(),
      subtitle: '',
      icon: Image.asset(
        AppAssets.no_data,
        height: 15.0.h,
      ),

    );

  }
}
