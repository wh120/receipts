import '/core/constants/AppColors.dart';
import '/core/constants/AppTheme.dart';
import '/core/constants/app_styles.dart';
import '/features/User/domain/cubit/user_cubit.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../../../../core/constants/Keys.dart';
import '/features/App/presentation/widgets/DrawerWidget.dart';

import '/features/Homepage/presentation/pages/Homepage.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart' as t;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class HomeApp extends StatefulWidget {
  @override
  _HomeAppState createState() => _HomeAppState();
}

class _HomeAppState extends State<HomeApp> {
  List<GButton> items = [];
  List<Widget> children = [];
  static int startUp = 0;
  static int _currentPage = startUp;
  PageController _pageController;

  addPages() {
    items.clear();
    // List<String> permissions  =GetIt.I<PermissionListResponse>().permissions;
    // bool canViewRequests = false;
    // if(permissions != null)
    //   canViewRequests= permissions.where((element) => element == 'ApprovalRequest.View​').length >0;
    // items.add(BottomNavigationBarItem(icon: new Icon(Icons.scanner), label: 'Scanner'.tr()));

    //items.add(BottomNavigationBarItem(icon: new Icon(Icons.home), label: 'Home'.tr()));

    items.add(GButton(
        icon: Icons.home,
        text: 'Home'.tr())
    );

    items.add(GButton(
        icon:  Icons.medical_services_outlined  ,
       text: 'Clinics'.tr(),
    ));

    items.add(GButton(
        icon: Icons.person_outline,
      text: 'Doctors'.tr(),
    ),

    );
    //  if(canViewRequests)


    items.add(GButton(
        text: 'My Appointments'.tr( ),
        icon: Icons.calendar_today));

    items.add(GButton(
        text: 'My cards'.tr( ),
        icon: Icons.credit_card));
    
    children.clear();

    // children.add(ScannerPage());

    //children.add(Homepage());
    //children.add(HomeScreen());
    children.add(Homepage());
    children.add(Homepage());
    children.add(Homepage());
    children.add(Homepage());
    //  children.add(Slive());

    children.add(Homepage());
  }

  @override
  void initState() {
    addPages();
     context.read<UserCubit>().loginWithToken();


    _pageController = new PageController(
      initialPage: _currentPage,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _buildHomePage();
  }

  _buildHomePage() {
    return new Scaffold(
      key: Keys.scaffoldKey,
      drawer: DrawerWidget(),
      drawerEdgeDragWidth: 5.0.w,

      bottomNavigationBar: _buildTabBar(),
      body: WillPopScope(
        onWillPop: () async {
          if (_currentPage != startUp) {
            this._pageController.animateToPage(startUp,
                duration: const Duration(milliseconds: 10),
                curve: Curves.easeInOut);
            return false;
          }
          return true;
        },
        child: new PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: _pageController,
          onPageChanged: (newPage) {
            setState(() {
              _currentPage = newPage;
            });
          },
          children: children,
        ),
      ),
    );
  }

   _buildTabBar() {
    return GNav(
      onTabChange: (value) {
        _pageController.animateToPage(value, duration: Duration(milliseconds: 200), curve: Curves.decelerate);
        print(value);
      },
        rippleColor: AppColors.secondary , // tab button ripple color when pressed
        hoverColor: AppColors.secondary[25], // tab button hover color
        haptic: true, // haptic feedback
        tabBorderRadius: 20,
        tabMargin: AppStyles.verticalPadding,
        // tabActiveBorder: Border.all(color: AppColors.secondary, width: 1), // tab button border
      // /  tabBorder: Border.all(color: Colors.grey, width: 1), // tab button border
      //   tabShadow: [BoxShadow(color: Colors.red.withOpacity(0.2), blurRadius: 22)], // tab button shadow
        curve: Curves.decelerate, // tab animation curves
        duration: Duration(milliseconds: 200), // tab animation duration
      //  gap: 8, // the tab button gap between icon and text
        color: AppColors.primary, // unselected icon color
        activeColor: AppColors.primary[900], // selected icon and text color
         iconSize: 6.r, // tab button icon size
          backgroundColor: Colors.white,
          tabBackgroundGradient: RadialGradient(
            radius: 2.5,
          focalRadius: 7,
          // center: Alignment.center,
          // begin: Alignment.topLeft,
          // end: Alignment(1, 1), // 10% of the width, so there are ten blinds.
          colors: [AppColors.secondary[25],AppColors.secondary[50],AppColors.secondary[200],AppColors.secondary[300],AppColors.secondary[400] ,AppColors.secondary[500],AppColors.secondary[600],], // red to yellow
          tileMode: TileMode.repeated, // repeats the gradient over the canvas
        ),



        tabBackgroundColor: AppColors.secondary[25], // selected tab background color
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.5.h), // navigation bar padding
        tabs: items,

    );

    return  CupertinoTabBar(

      //iconSize: 20.0.sp,
      currentIndex: _currentPage,
      onTap: (index) {
        this._pageController.animateToPage(index,
            duration: const Duration(milliseconds: 10),
            curve: Curves.easeInOut);
      },
     // items: items,
    );
  }
}
