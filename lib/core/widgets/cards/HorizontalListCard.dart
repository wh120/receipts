import 'package:cached_network_image/cached_network_image.dart';

import '../../constants/AppTheme.dart';
import '../../constants/AppColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HorizontalListCard extends StatelessWidget {
  HorizontalListCard({
    Key key,
    @required this.title,
    @required this.subtitle,
     @required this.imagePath,
    this.onTap,
    this.width,
    this.selected = false,
  }) : super(key: key);


  final bool selected;
  final String title;
  final String subtitle;
   final String imagePath;
   final GestureTapCallback onTap;
     double width;

  @override
  Widget build(BuildContext context) {
    if(width == null )
      width =25.0.w;

    return Container(

        width: width,
       // / height: 35.0.h,
        child: Card(
          elevation: 1,
          shape: RoundedRectangleBorder(
            side: selected?BorderSide(
                width:  2 ,
                color: AppColors.secondary
            ):BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(4.0.r)),
          ),
          color: Colors.white,
          child: new InkWell(
            customBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(4.0.r)),
            ),
            onTap: onTap,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 5.0,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(
                            top: 5.0,
                            bottom: 12.5,
                          ),
                          child: CircleAvatar(


                            radius: width/3.5,
                            backgroundImage: CachedNetworkImageProvider(
                                imagePath,
                            ),

                          ),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(

                      title,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,

                    ),
                  ),
                  if(subtitle != null)
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: 3.0,
                      ),
                      child: Text(
                        subtitle ,
                        textAlign: TextAlign.center,

                        style: AppTheme.caption,
                        overflow: TextOverflow.ellipsis,

                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

}