
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ColumnListTile extends StatelessWidget {
  final title;
  final subtitle;
  final underLine;

  const ColumnListTile(
      {Key key, this.title, this.subtitle, this.underLine = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style:  Theme.of(context).textTheme.headline5,
          overflow: TextOverflow.ellipsis,
          softWrap: false,
        ),
        if (underLine)
          SizedBox(
            height: 0.5.h,
          ),
        Text(subtitle, style: Theme.of(context).textTheme.bodyText2,overflow: TextOverflow.ellipsis,
          softWrap: false,),

          // Expanded(
          //   child: Divider(
          //     indent: 1.w,
          //     endIndent: 1.w,
          //   ),
          // ),
      ],
    );
  }
}
