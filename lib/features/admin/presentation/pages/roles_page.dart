import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:receipts/core/widgets/cards/GeneralCard.dart';
import 'package:receipts/core/widgets/forms/SelectDropDown.dart';
import 'package:search_choices/search_choices.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_icons/flutter_icons.dart';
import '../../../RootApp/json/department_json.dart';
import '../../../RootApp/json/role_json.dart';
import '/core/constants/AppColors.dart';
import '/core/utils/Navigation/Navigation.dart';
import '/core/widgets/data_table/data_table.dart';
import '/core/widgets/forms/RoundedNumberField.dart';
import '/core/widgets/forms/RoundedTextField.dart';



class RolePage extends StatefulWidget {
  @override
  _RolePageState createState() => _RolePageState();
}

class _RolePageState extends State<RolePage> {


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

                    children: [
                      Text(
                        "إدارة الأدوار",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColors.black),
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
                  "القسم"

                ],
                rows: List.generate(roles.length, (index) => [index.toString(),roles[index]["name"] ,roles[index]["department"] ]),
              )
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).restorablePush(_dialogBuilder);
                },
                child: Text('إضافة دور جديد')
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
          Dialog(child: Container(height:50.h ,child: CreateRoleWidget()) )
    );
  }

}



class CreateRoleWidget extends StatefulWidget {
  @override
  _CreateRoleWidgetState createState() => _CreateRoleWidgetState();
}

class _CreateRoleWidgetState extends State<CreateRoleWidget> {
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
            ObjectDropDown<ObjectDropDownItem>(
              width: 100.w,
              //       selectedValue: ObjectDropDownItem(id :0 , name: roles[0]["name"]),
              items: List.generate(departments.length, (index) => ObjectDropDownItem(id :index , name: departments[index]["name"])),
              text: 'العميل',
            ),
            Expanded(child: Container()),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: () {
                    Navigation.pop();

                  },
                  child: Text('إضافة دور جديد')
              ),
            )

          ],
        ),
      ),
    );
  }
}


