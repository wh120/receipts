import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:receipts/core/Boilerplate/CreateModel/cubits/create_model_cubit.dart';
import 'package:receipts/core/Boilerplate/CreateModel/widgets/CreateModel.dart';
import 'package:receipts/core/Boilerplate/GetModel/cubits/get_model_cubit.dart';
import 'package:receipts/core/Boilerplate/GetModel/widgets/GetModel.dart';
import 'package:receipts/core/widgets/BottomSheet.dart';
import 'package:receipts/core/widgets/cards/GeneralCard.dart';
import 'package:receipts/features/admin/data/department_list_response.dart';
import 'package:receipts/features/admin/repository/admin_repository.dart';
import 'package:search_choices/search_choices.dart';

import 'package:flutter_icons/flutter_icons.dart';
import '../../../../core/widgets/data_table/widget_data_table.dart';
import '../../../RootApp/json/department_json.dart';
import '/core/constants/AppColors.dart';
import '/core/utils/Navigation/Navigation.dart';
import '/core/widgets/data_table/data_table.dart';
import '/core/widgets/forms/RoundedNumberField.dart';
import '/core/widgets/forms/RoundedTextField.dart';
import '/core/widgets/forms/SelectDropDown.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class DepartmentPage extends StatefulWidget {
  @override
  _DepartmentPageState createState() => _DepartmentPageState();
}

class _DepartmentPageState extends State<DepartmentPage> {
  GetModelCubit cubit;



  @override
  void initState() {


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(
        "إدارة الاقسام",

      ),),
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
                        "إدارة الاقسام",
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


          Expanded(child: getBody()),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (_)=>SingleChildScrollView(
                        child: Align(
                          alignment: Alignment.center,
                          child: Dialog(
                              child: Container(
                                  height:50.h ,
                                  child: CreateDepartmentWidget(
                              onCreated: (_){
                                cubit.getModel();
                              },
                          )) ),
                        ),
                      ));
                },
                child: Text('إضافة قسم جديد')
            ),
          )
        ],
      ),
    );
  }

  getBody(){
    return GetModel<DepartmentListResponse>(
      onCubitCreated: (c) {
        cubit=c;
      },
      repositoryCallBack: (data) => AdminRepository.getDepartments(),
      modelBuilder: (DepartmentListResponse model)=>buildbody(model),

    );
  }
    buildbody(DepartmentListResponse model) {
    return SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      child: WidgetDataTable(
        columns: [
          Text("الرقم"),
          Text("الاسم"),
          Text("الأوامر"),

        ],
        rows: List.generate(model.items.length, (index) => [
          Text(model.items[index].id.toString()),
          Text(model.items[index].name) ,
          IconButton(onPressed: (){
            MyBottomSheet.showConfirmBottomSheet(
                context: context,
                text: 'هل تريد الحذف' ,
                onClicked: (b){
                 if(b)cubit?.getModel();
                },repositoryCallBack: (data)=>AdminRepository.deleteDepartment(model.items[index].id),

            );
          }, icon: Icon(Icons.delete))]),
      ),
    );
  }
  




}

class CreateDepartmentWidget extends StatefulWidget {
  final ValueChanged onCreated;

  const CreateDepartmentWidget({Key key, this.onCreated}) : super(key: key);
  @override
  _CreateDepartmentWidgetState createState() => _CreateDepartmentWidgetState();
}

class _CreateDepartmentWidgetState extends State<CreateDepartmentWidget> {

  CreateModelCubit cubit;
  TextEditingController nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("إضافة قسم"),),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min  ,
          children: [

            SizedBox(height: 25,),
            RoundedTextField(
              hintText: "اسم القسم",
              controller: nameController,
            ),

            Expanded(child: Container()),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CreateModel<Department>(
                repositoryCallBack: (data) => AdminRepository.createDepartment(data),
                onCubitCreated: (c){
                  cubit=c;
                },
                onSuccess: (m){

                  Navigation.pop();
                  widget.onCreated(m);

                },
                child: ElevatedButton(
                    onPressed: () {
                      if(cubit!=null && nameController.text.length>0)cubit.createModel(Department(name: nameController.text));

                    },
                    child: Text('إضافة قسم جديد')
                ),
              ),
            )

          ],
        ),
      ),
    );
  }
}



