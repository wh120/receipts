import 'package:receipts/core/utils/SharedPreferences/SharedPreferencesHelper.dart';
import 'package:receipts/features/receipt/presentation/page/my_approval_receipts_page.dart';

import '../../../core/constants/AppColors.dart';
import '../../AboutApp/presentation/pages/AboutAppPage.dart';
import '../../admin/presentation/pages/admin_page.dart';
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
    DailyReceiptsPage(),
    MyApprovalReceiptsPage(),
    ProfilePage(),
    CreateReceiptPage()
  ];

  @override
  void initState() {
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
              selectedTab(4);
            },
            child: Icon(
              Ionicons.md_create,
              size: 25,
              color: Colors.white,
            ),
            backgroundColor: AppColors.primary
            //params
            ),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.centerDocked);
  }

  PageController controller = new PageController(initialPage: 4);
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
      Ionicons.md_stats,
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
