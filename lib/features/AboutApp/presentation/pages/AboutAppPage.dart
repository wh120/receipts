import '../../../../core/constants/AppColors.dart';
import '../../../../core/constants/AppTheme.dart';
import '../../../../core/widgets/SectionTitle.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart' as t;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:cached_network_image/cached_network_image.dart';

class AboutAppPage extends StatefulWidget {
  @override
  _AboutAppPageState createState() => _AboutAppPageState();
}

class _AboutAppPageState extends State<AboutAppPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        decoration: BoxDecoration(color: AppColors.white, boxShadow: [
          BoxShadow(
            color: AppColors.grey.withOpacity(0.01),
            spreadRadius: 10,
            blurRadius: 3,
            // changes position of shadow
          ),
        ]),
        child: Padding(
          padding: const EdgeInsets.only(
              top: 60, right: 20, left: 20, bottom: 25),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "عن التطبيق",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.black),
                  ),


                ],
              ),
              _buildBody()
            ],
          ),
        ),
      ),
    );
  }

  _buildBody() {
    return Expanded(
      child: Column(
        children: [
         buildLogo(),
          header(context),


        ],
      ),
    );
  }

   buildLogo() {
    return Expanded(
      child: Padding(

        padding:   EdgeInsets.all(3.0.r),
        child:CachedNetworkImage(
          imageUrl: 'http://www.sh-kd.co/shammout.png',
          placeholder: (context, url) => Center(child: CircularProgressIndicator()),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),

      ),
    );
  }

  header(context) {
    return Padding(
      padding:   EdgeInsets.all(3.0.r),
      child: Column(
        children: [
          Text('إيصالات',
            style: AppTheme.headline3,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Receipts",
              style: AppTheme.headline5,
              textDirection: TextDirection.ltr,
            ),
          )
        ],
      ),
    );
  }



}
