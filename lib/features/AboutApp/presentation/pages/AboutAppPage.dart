import '../../../../core/constants/AppColors.dart';
import '../../../../core/constants/AppTheme.dart';
import '../../../../core/widgets/SectionTitle.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart' as t;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';


class AboutAppPage extends StatefulWidget {
  @override
  _AboutAppPageState createState() => _AboutAppPageState();
}

class _AboutAppPageState extends State<AboutAppPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text('About App'.tr()),
      ),
      body: _buildBody(),
    );
  }

  _buildBody() {
    return ListView(
      children: [
       buildLogo(),
        header(context),


      ],
    );
  }

   buildLogo() {
    return Padding(

      padding:   EdgeInsets.all(3.0.r),
      child: CircleAvatar(

         backgroundColor:  Colors.white,
         radius: 100,
         child: ClipRRect(
           borderRadius:BorderRadius.circular(100),
           child: Image.network('https://www.gravatar.com/avatar/bbdab18bb5caee5f127f7780da0b5623?s=800&d=identicon'),
         ),
         // foregroundImage: NetworkImage(
         //     'http://itland-sy.com/wp-content/uploads/2020/07/IT-Land-PNG.png',
         //   scale: 0.1
         //
         // ),
       ),
    );
  }

  header(context) {
    return Padding(
      padding:   EdgeInsets.all(3.0.r),
      child: Column(
        children: [
          Text('My Health'.tr(),
            style: AppTheme.headline3,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Clinic App",
              style: AppTheme.headline5,
              textDirection: TextDirection.ltr,
            ),
          )
        ],
      ),
    );
  }



}
