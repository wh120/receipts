import 'package:receipts/core/utils/Navigation/Navigation.dart';
import 'package:receipts/core/utils/SharedPreferences/SharedPreferencesHelper.dart';
import 'package:receipts/features/receipt/presentation/page/my_approval_receipts_page.dart';

import '../../../core/constants/AppColors.dart';
import '../../AboutApp/presentation/pages/AboutAppPage.dart';
import '../../admin/presentation/pages/admin_page.dart';
import '../../department/presentation/pages/my_department_page.dart';
import '../../profile/presentation/page/profile_page.dart';
import '../../receipt/presentation/page/create_receipt_page.dart';
import '../../receipt/presentation/page/daily_receeipts_page.dart';


import '../theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';


class RootApp extends StatefulWidget {
  @override
  _RootAppState createState() => _RootAppState();
}

class _RootAppState extends State<RootApp> {
  int pageIndex  ;
  List<Widget> pages = [

    AppSharedPreferences.isAdmin? AdminPage():AboutAppPage(),
    MyDepartmentPage(),
    MyApprovalReceiptsPage(),
    ProfilePage(),

  ];

  @override
  void initState() {
    pageIndex = 3;
   controller = new PageController(initialPage: pageIndex);
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: getBody(),
        bottomNavigationBar: getFooter(),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigation.push(CreateReceiptPage());
              //selectedTab(4);
            },
            child: Icon(
              Ionicons.md_add,
              size: 25,
              color: Colors.white,
            ),
            backgroundColor: AppColors.primary
            //params
            ),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.centerDocked);
  }

  PageController controller;
  Widget getBody() {
    return PageView(
      physics: NeverScrollableScrollPhysics(),



      controller: controller,

    //  index: pageIndex,
      children: pages,

    );
  }

  Widget getFooter() {
    List<IconData> iconItems = [
      Ionicons.ios_settings,
      Ionicons.ios_archive,
      Ionicons.md_wallet,
      Ionicons.ios_person,
    ];

    return AnimatedBottomNavigationBar(
      activeColor: AppColors.primary,
      splashColor: AppColors.secondary,
      inactiveColor: Colors.black.withOpacity(0.5),
      icons: iconItems,
      activeIndex: pageIndex,
      gapLocation: GapLocation.center,
      notchSmoothness: NotchSmoothness.softEdge,
      leftCornerRadius: 10,
      iconSize: 25,
      rightCornerRadius: 10,
      onTap: (index) {
        selectedTab(index);
      },
      //other params
    );
  }

  selectedTab(index) {
    controller.animateToPage(index ,duration: Duration(milliseconds: 100), curve: Curves.linear, );
    setState(() {
      pageIndex = index;
    });
  }
}
