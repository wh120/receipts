import '../../../../core/constants/AppColors.dart';
import '../../../../core/constants/AppTheme.dart';
import '../../../../core/constants/app_styles.dart';
import '../../../../core/utils/Navigation/Navigation.dart';
import '/features/AboutApp/presentation/pages/AboutAppPage.dart';
import '/features/AboutUs/presentation/pages/AboutUsPage.dart';
import '/features/App/presentation/pages/SettingsPage.dart';
import '/features/Notifications/presentation/pages/NotificationsListPage.dart';
import '/features/User/domain/cubit/user_cubit.dart';
import '/features/User/presentation/pages/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart' as t;
import 'package:flutter_screenutil/flutter_screenutil.dart';



class DrawerWidget extends StatelessWidget {
  static const routeName = '/LightDrawerPage';
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();




  @override
  Widget build(BuildContext context) {

    return _buildDrawer(context);

  }

  _buildDrawer(BuildContext context) {
    TextDirection textDirection = Directionality.of(context);
    final String image ='assets/icons/male.png';
    return Container(
      color: Colors.transparent,
      width: 60.0.w,
      child: ClipPath(
        clipper: textDirection == TextDirection.ltr ?OvalRightBorderClipper() :OvalLeftBorderClipper(),

        child: Theme(
          data: Theme.of(context).copyWith(
            // Set the transparency here
            canvasColor:  AppColors.primary .withOpacity(0.8), //or any other color you want. e.g Colors.blue.withOpacity(0.5)
          ),
          child: Drawer(
            elevation: 0,

            child: Container(

              padding:  EdgeInsets.all(5.r),
              // decoration: BoxDecoration(
              //    color: AppColors.primary[10] ,
              // ),
              child: SafeArea(
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.zero,
                  children: <Widget>[
                    Row(
                      children: [
                        Container(
                          alignment: Alignment.centerRight,
                          child: IconButton(
                            iconSize: 7.0.r,
                            icon: Icon(
                              Icons.power_settings_new,
                            ),
                            onPressed: () async{
                              await logOut(context);
                            },
                          ),
                        ),
                      ],
                    ),


                    Hero(
                      transitionOnUserGestures: true,
                      tag: 'profileImage',
                      child: Container(
                        padding: EdgeInsets.all(1.5.r),
                        alignment: Alignment.center,
                        decoration: AppStyles.circleImageSecondaryDecoration,
                        child: CircleAvatar(
                          radius: 12.r,
                          backgroundImage: AssetImage(image),
                        ),
                      ),
                    ),
                    SizedBox(height: 5.0),



                    Text('0933333333'  , style: AppTheme.headline4.copyWith(color: Colors.white),),


                    SizedBox(height: 30.0),
                   //
                   //  _buildRow(Icons.calendar_today, "My Appointments".tr() , onTap: () {
                   // //   Navigator.pop(context);
                   //    Navigation.push(AppointmentsListPage());
                   //
                   //  },),
                    Divider(),
                      drawerItem(Icons.message, "Messages".tr(), badgeCount: '+10',
                          onTap: (){
                     //   Navigation.popThenPush(ChatListPage());
                      }),
                    Divider(),
                    drawerItem(
                        Icons.notifications,
                        "Notifications".tr(),
                        badgeCount: '5',
                        onTap: () {
                          Navigation.popThenPush(NotificationsListPage());
                        },
                    ),
                    Divider(),
                    drawerItem(
                        Icons.settings,
                        "Settings".tr(),
                      onTap: () {
                          Navigation.popThenPush(SettingsPage());

                      },
                    ),
                    Divider(),
                    drawerItem(Icons.contact_support, 'About Us'.tr() , onTap: () {
                     Navigation.popThenPush(AboutUsPage());
                    },),
                    Divider(),

                    // drawerItem(Icons.apps , 'About App'.tr() , onTap: () {
                    //   Navigation.popThenPush(AboutAppPage());
                    // },),
                    // Divider(),

                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future logOut(BuildContext context) async {
    bool result = await UserCubit().logout();
    if(result){
      Navigation.pushReplacement(LoginPage());

    }
    else{
      //todo
      Navigation.pushReplacement(LoginPage());
    }
  }


  /// ---------------------------
  /// Building item  for drawer .
  /// ---------------------------

  Widget drawerItem(IconData icon, String title, {String badgeCount  ,   GestureTapCallback onTap }) {

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child:

      ListTile(
        contentPadding: EdgeInsets.zero,

        onTap: onTap ,
        isThreeLine: false,
        leading: Icon(
          icon,
          color: AppColors.white,

        ) ,
        title: Text(
          title,
          style: AppTheme.headline5.copyWith(color: Colors.white),

        ),
        trailing: badgeCount!=null ?Material(
          color: AppColors.secondary,
          elevation: 5.0,

        //  shadowColor: AppColors.secondary[100],
          borderRadius: BorderRadius.circular(5.0),
          child: Container(
            width: 5.0.r,
            height: 5.0.r,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.secondary[600],
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Text(
              badgeCount ,
              style: TextStyle(color: Colors.white,),

            ),
          ),
        ):null ,

      )
    );
  }
}


class OvalRightBorderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, 0);
    path.lineTo(size.width-40, 0);
    path.quadraticBezierTo(
        size.width+40, size.height / 2, size.width-40, size.height);
    // path.quadraticBezierTo(
    //     size.width, size.height - (size.height / 4), size.width-40, size.height);
    path.lineTo(0, size.height);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }

}

class OvalLeftBorderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, 0);
    path.lineTo(40, 0);
    path.quadraticBezierTo(
        -40, size.height / 2, 40, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.lineTo(40, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }

}


