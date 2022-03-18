import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:receipts/core/widgets/cards/GeneralCard.dart';
import 'package:search_choices/search_choices.dart';

import 'package:flutter_icons/flutter_icons.dart';
import '../../../core/constants/AppColors.dart';
import '../../../core/utils/Navigation/Navigation.dart';
import '../../../core/widgets/data_table/data_table.dart';
import '../../../core/widgets/forms/RoundedNumberField.dart';
import '../../../core/widgets/forms/RoundedTextField.dart';
import '../../../core/widgets/forms/SelectDropDown.dart';
import '../json/department_json.dart';
import '../theme/colors.dart';
import 'create_budge_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DepartmentPage extends StatefulWidget {
  @override
  _DepartmentPageState createState() => _DepartmentPageState();
}

class _DepartmentPageState extends State<DepartmentPage> {


  @override
  void initState() {


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.grey[100],
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(color: white, boxShadow: [
              BoxShadow(
                color: grey.withOpacity(0.01),
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

                    children: [
                      Text(
                        "إدارة الاقسام",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: black),
                      ),

                    ],
                  ),
                ],
              ),
            ),
          ),


          Expanded(
              child: MyDataTable(
                columns: [
                  "الرقم",
                  "الاسم",

                ],
                rows: List.generate(departments.length, (index) => [index.toString(),departments[index]["name"]]),
              )
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).restorablePush(_dialogBuilder);
                },
                child: Text('إضافة قسم جديد')
            ),
          )
        ],
      ),
    );
  }
  static Route<Object> _dialogBuilder(
      BuildContext context, Object arguments) {
    return DialogRoute<void>(
      context: context,
      builder: (BuildContext context) =>
          Dialog(child: Container(height:50.h ,child: CreateDepartmentWidget()) ),
    );
  }



}

class CreateDepartmentWidget extends StatefulWidget {
  @override
  _CreateDepartmentWidgetState createState() => _CreateDepartmentWidgetState();
}

class _CreateDepartmentWidgetState extends State<CreateDepartmentWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("إضافة دور"),),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min  ,
          children: [

            SizedBox(height: 25,),
            RoundedTextField(
              hintText: "اسم الدور",
            ),

            Expanded(child: Container()),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: () {
                    Navigation.pop();

                  },
                  child: Text('إضافة قسم جديد')
              ),
            )

          ],
        ),
      ),
    );
  }
}



