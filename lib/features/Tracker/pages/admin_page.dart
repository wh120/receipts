// import 'package:receipts/core/utils/Navigation/Navigation.dart';
//
// import '../json/day_month.dart';
// import '../theme/colors.dart';
// import '../widget/chart.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_icons/flutter_icons.dart';
// import 'package:fl_chart/fl_chart.dart';
//
// import 'departments_page.dart';
// import 'roles_page.dart';
//
// class AdminPage extends StatefulWidget {
//   @override
//   _AdminPageState createState() => _AdminPageState();
// }
//
// class _AdminPageState extends State<AdminPage> {
//   int activeDay = 3;
//
//   bool showAvg = false;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: grey.withOpacity(0.05),
//       body: getBody(),
//     );
//   }
//
//   Widget getBody() {
//     var size = MediaQuery.of(context).size;
//
//
//     return SingleChildScrollView(
//       child: Column(
//         children: [
//           Container(
//             decoration: BoxDecoration(color: white, boxShadow: [
//               BoxShadow(
//                 color: grey.withOpacity(0.01),
//                 spreadRadius: 10,
//                 blurRadius: 3,
//                 // changes position of shadow
//               ),
//             ]),
//             child: Padding(
//               padding: const EdgeInsets.only(
//                   top: 60, right: 20, left: 20, bottom: 25),
//               child: Column(
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         "صفحة الأدمن",
//                         style: TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                             color: black),
//                       ),
//                       Icon(AntDesign.search1)
//                     ],
//                   ),
//                   SizedBox(
//                     height: 25,
//                   ),
//
//
//                 ],
//               ),
//             ),
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 8),
//             child: ListTile(
//               tileColor: Colors.white,
//               onTap: (){
//                 Navigation.push(DepartmentPage());
//               },
//               leading: Icon(Icons.settings),
//               title: Text("الأقسام"),),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 8),
//             child: ListTile(
//               tileColor: Colors.white,
//               onTap: (){
//                 Navigation.push(RolePage());
//               },
//               leading: Icon(Icons.settings),
//               title: Text("الأدوار"),),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 8),
//             child: ListTile(
//               tileColor: Colors.white,
//               onTap: (){},
//               leading: Icon(Icons.settings),
//               title: Text("التصنيفات الرئيسية"),),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 8),
//             child: ListTile(
//               tileColor: Colors.white,
//               onTap: (){},
//               leading: Icon(Icons.settings),
//               title: Text("التصنيفات الفرعية"),),
//           ),
//
//
//
//         ],
//       ),
//     );
//   }
// }
