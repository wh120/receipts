// import 'package:flutter/cupertino.dart';
// import 'package:receipts/core/utils/Navigation/Navigation.dart';
// import 'package:receipts/core/widgets/forms/SelectDropDown.dart';
// import 'package:receipts/features/Tracker/json/department_json.dart';
// import 'package:receipts/features/Tracker/json/role_json.dart';
//
// import '../json/create_budget_json.dart';
// import '../theme/colors.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_icons/flutter_icons.dart';
//
// import 'fill_receipt_page.dart';
//
// class CreatBudgetPage extends StatefulWidget {
//   @override
//   _CreatBudgetPageState createState() => _CreatBudgetPageState();
// }
//
// class _CreatBudgetPageState extends State<CreatBudgetPage> {
//   int activeCategory = 0;
//
//    @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: grey.withOpacity(0.05),
//       body: getBody(),
//     );
//   }
//
//   Widget getBody() {
//     var size = MediaQuery.of(context).size;
//     return SingleChildScrollView(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
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
//                         "إنشاء إيصال",
//                         style: TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                             color: black),
//                       ),
//                       Row(
//                         children: [Icon(AntDesign.search1)],
//                       )
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
//             child: Text(
//               "اختر نوع الإيصال",
//               style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                   color: black.withOpacity(0.5)),
//             ),
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           SingleChildScrollView(
//             scrollDirection: Axis.horizontal,
//             child: Row(
//                 children: List.generate(categories.length, (index) {
//               return GestureDetector(
//                 onTap: () {
//                   setState(() {
//                     activeCategory = index;
//                   });
//                 },
//                 child: Padding(
//                   padding: const EdgeInsets.only(
//                     left: 10,
//                   ),
//                   child: Container(
//                     margin: EdgeInsets.only(
//                       left: 10,
//                     ),
//
//                     decoration: BoxDecoration(
//                         color: white,
//                         border: Border.all(
//                             width: 2,
//                             color: activeCategory == index
//                                 ? primary
//                                 : Colors.transparent),
//                         borderRadius: BorderRadius.circular(12),
//                         boxShadow: [
//                           BoxShadow(
//                             color: grey.withOpacity(0.01),
//                             spreadRadius: 10,
//                             blurRadius: 3,
//                             // changes position of shadow
//                           ),
//                         ]),
//                     child: Padding(
//                       padding: const EdgeInsets.only(
//                           left: 25, right: 25, top: 20, bottom: 20),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Container(
//                               width: 40,
//                               height: 40,
//                               decoration: BoxDecoration(
//                                   shape: BoxShape.circle,
//                                   color: grey.withOpacity(0.15)),
//                               child: Center(
//                                 child: Image.asset(
//                                   categories[index]['icon'],
//                                   width: 30,
//                                   height: 30,
//                                   fit: BoxFit.contain,
//                                 ),
//                               )),
//                           Text(
//                             categories[index]['name'],
//                             style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 20,
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               );
//             })),
//           ),
//           SizedBox(
//             height: 50,
//           ),
//           Padding(
//             padding: const EdgeInsets.only(left: 20, right: 20),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//
//                 SizedBox(
//                   height: 20,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Container(
//                       width: (size.width - 140),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceAround,
//                             children: [
//                               Text(
//                                 "المستودع",
//
//                               ),
//                               ObjectDropDown<ObjectDropDownItem>(
//                      //       selectedValue: ObjectDropDownItem(id :0 , name: roles[0]["name"]),
//                                 items: List.generate(departments.length, (index) => ObjectDropDownItem(id :index , name: departments[index]["name"])),
//                                 text: 'العميل',
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                     SizedBox(
//                       width: 20,
//                     ),
//
//                   ],
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Container(
//                       width: (size.width - 140),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceAround,
//                             children: [
//                               Text(
//                                 "العميل",
//
//                               ),
//                               ObjectDropDown<ObjectDropDownItem>(
//                                 //       selectedValue: ObjectDropDownItem(id :0 , name: roles[0]["name"]),
//                                 items: List.generate(roles.length, (index) => ObjectDropDownItem(id :index , name: roles[index]["name"])),
//                                 text: 'العميل',
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                     SizedBox(
//                       width: 20,
//                     ),
//
//                   ],
//                 )
//               ],
//             ),
//           ),
//           SizedBox(height: 25,),
//           Center(
//             child: TextButton(
//               child: Text('التالي'),
//
//               onPressed: (){
//                 Navigation.push(CreateReceiptPage());
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
