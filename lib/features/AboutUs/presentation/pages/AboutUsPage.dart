import '/core/Boilerplate/GetModel/widgets/GetModel.dart';
import '/core/widgets/google_maps/google_map.dart';
import '/features/AboutUs/data/AboutUsResponse.dart';
import '/features/AboutUs/domain/repo/AboutUsRepository.dart';
import '/features/Contact/presentation/widgets/contact_widget.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../core/constants/AppColors.dart';
import '../../../../core/constants/AppTheme.dart';
import '../../../../core/constants/app_styles.dart';
import '../../../../core/widgets/SectionTitle.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart' as t;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
class AboutUsPage extends StatefulWidget {
  @override
  _AboutUsPageState createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text('About Us'.tr()),
      ),
      body: getBody(),
    );
  }
  getBody(){
    return GetModel<AboutUsResponse>(
      repositoryCallBack: (data) => AboutUsRepository.getData(),
      modelBuilder: (AboutUsResponse model) => _buildBody(model),

    );
  }

  _buildBody(AboutUsResponse model) {
    return Padding(
      padding: AppStyles.horizontalPadding,
      child: ListView(
        children: [
         buildLogo(),
          company(),
          SectionTitle(title: 'Contact Us'.tr(),),
          ContactsWidget(contacts: model.contacts),
          contactUs(context),
          SectionTitle(title: "Location".tr(),),
          GoogleMaps(point: LatLng(model.latitude,model.longitude),)

        ],
      ),
    );
  }

   buildLogo( ) {
    return Padding(

      padding:   AppStyles.verticalPadding,
      child: CircleAvatar(

         backgroundColor:  Colors.white,
         radius: 100,
         child: ClipRRect(
           borderRadius:BorderRadius.circular(100),
           child: Image.network('http://itland-sy.com/wp-content/uploads/2020/07/IT-Land-PNG.png'),
         ),
         // foregroundImage: NetworkImage(
         //     'http://itland-sy.com/wp-content/uploads/2020/07/IT-Land-PNG.png',
         //   scale: 0.1
         //
         // ),
       ),
    );
  }

  company() {
    return Padding(
      padding:   AppStyles.verticalPadding,
      child: Column(
        children: [
          Text('IT Land Technologies',
            style: AppTheme.headline3,
          ),
          Text("IT Land Technologies provides automated solutions for your trade and industry. Depending on the size and field of your organization, we have different products and services to meet your requirements.We provide the optimum and customized solutions made for your organization",
            style: AppTheme.headline5,
            textDirection: TextDirection.ltr,
          )
        ],
      ),
    );
  }

  contactUs(context) {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.all(0),
          onTap: ()async{
            String url = 'tel:00963987218505';
            await canLaunch(url) ? await launch(url) : print ('Could not launch $url');
          },
          leading: Icon(Icons.phone , color: AppColors.secondary[700],),
          title: Text('phone',style: AppTheme.headline5,),

          trailing: Text('+963 987 218505',style: AppTheme.headline5,textDirection: TextDirection.ltr,),

        ),
        ListTile(
          contentPadding: EdgeInsets.all(0),
          onTap: ()async{

            String url = 'mailto:hr@itland-sy.com';
            await canLaunch(url) ? await launch(url) : print ('Could not launch $url');

          },
          leading: Icon(Icons.mail , color: AppColors.secondary[700]),
          title: Text('Email' ,style: AppTheme.headline5,),

          trailing: Text('hr@itland-sy.com',style: AppTheme.headline5,),

        ),
        ListTile(
          contentPadding: EdgeInsets.all(0),
          onTap: ()async{

           String homeLat = "33.513698";
           String homeLng = "36.276939";
           String googleMapslocationUrl = "https://www.google.com/maps/search/?api=1&query=${homeLat},${homeLng}";



            final String url = Uri.encodeFull(googleMapslocationUrl);


            await canLaunch(url) ? await launch(url) : print ('Could not launch $url');
          },
          leading: Icon(Icons.location_on , color: AppColors.secondary[700]),
          title: Text('Address' ,style: AppTheme.headline5,),

          trailing: Text('Mezzah highway Damascus',style: AppTheme.headline5,),

        ),
        ListTile(
          contentPadding: EdgeInsets.all(0),
          onTap: ()async{
            String url = 'https://www.facebook.com';
            await canLaunch(url) ? await launch(url) : print ('Could not launch $url');
          },
          leading: Icon(Icons.facebook , color: AppColors.secondary[700]),
          title: Text('Facebook' ,style: AppTheme.headline5,),

          trailing: Text('IT Land Technologies',style: AppTheme.headline5,),

        )
      ],
    );
  }

}
