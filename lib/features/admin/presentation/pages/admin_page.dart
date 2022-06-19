import 'package:receipts/core/utils/Navigation/Navigation.dart';


import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:receipts/features/admin/presentation/pages/transformations_page.dart';
import 'package:receipts/features/admin/presentation/pages/users_page.dart';
import 'package:receipts/features/receipt/presentation/page/receipts_list_page.dart';

import '../../../../core/constants/AppColors.dart';
import '../../../receipt/presentation/page/daily_receeipts_page.dart';
import 'departments_page.dart';
import 'item_category_page.dart';
import 'item_main_category_page.dart';
import 'item_page.dart';
import 'roles_page.dart';

class AdminPage extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  int activeDay = 3;

  bool showAvg = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey.withOpacity(0.05),
      body: getBody(),
    );
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;


    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
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
                        "صفحة الأدمن",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColors.black),
                      ),
                      Icon(AntDesign.search1)
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),


                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              tileColor: Colors.white,
              onTap: (){
                Navigation.push(ReceiptsListPage());
              },
              leading: Icon(Icons.settings),
              title: Text("الإيصالات"),),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              tileColor: Colors.white,
              onTap: (){
                Navigation.push(DailyReceiptsPage());
              },
              leading: Icon(Ionicons.md_stats),
              title: Text("الإحصائيات اليومية"),),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              tileColor: Colors.white,
              onTap: (){
                Navigation.push(DepartmentPage());
              },
              leading: Icon(Icons.settings),
              title: Text("الأقسام"),),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              tileColor: Colors.white,
              onTap: (){
                Navigation.push(RolePage());
              },
              leading: Icon(Icons.settings),
              title: Text("الأدوار"),),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              tileColor: Colors.white,
              onTap: (){
                Navigation.push(UserPage());
              },
              leading: Icon(Icons.settings),
              title: Text("المستخدمين"),),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              tileColor: Colors.white,
              onTap: (){
                Navigation.push(ItemMainCategoryPage());
              },
              leading: Icon(Icons.settings),
              title: Text("التصنيفات الرئيسية"),),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              tileColor: Colors.white,
              onTap: (){
                Navigation.push(ItemCategoryPage());
              },
              leading: Icon(Icons.settings),
              title: Text("التصنيفات الفرعية"),),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              tileColor: Colors.white,
              onTap: (){
                Navigation.push(ItemPage());
              },
              leading: Icon(Icons.settings),
              title: Text("المواد"),),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              tileColor: Colors.white,
              onTap: (){
                Navigation.push(TransformationPage());
              },
              leading: Icon(Icons.settings),
              title: Text("عمليات تحويل المواد"),),
          ),



        ],
      ),
    );
  }
}
