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
import '../../data/role_list_response.dart';
import '/core/constants/AppColors.dart';
import '/core/utils/Navigation/Navigation.dart';
import '/core/widgets/data_table/data_table.dart';
import '/core/widgets/forms/RoundedNumberField.dart';
import '/core/widgets/forms/RoundedTextField.dart';
import '/core/widgets/forms/SelectDropDown.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class RolePage extends StatefulWidget {
  @override
  _DepartmentPageState createState() => _DepartmentPageState();
}

class _DepartmentPageState extends State<RolePage> {
  GetModelCubit cubit;



  @override
  void initState() {


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "إدارة الأدوار",
        ),
      ),
      // backgroundColor: Colors.grey[100],
      body: Column(
        children: [
          Container(

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
                child: Text('إضافة دور جديد')
            ),
          )
        ],
      ),
    );
  }

  getBody(){
    return GetModel<RoleListResponse>(
      onCubitCreated: (c) {
        cubit=c;
      },
      repositoryCallBack: (data) => AdminRepository.getRoles(),
      modelBuilder: (RoleListResponse model)=>buildbody(model),

    );
  }
  buildbody(RoleListResponse model) {
    return SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      child: WidgetDataTable(
        columns: [
          Text("الرقم"),
          Text("الاسم"),
          Text("القسم"),
          Text("الأوامر"),

        ],
        rows: List.generate(model.items.length, (index) => [
          Text(model.items[index].id.toString()),
          Text(model.items[index].name) ,
          Text(model.items[index].department?.name??'-') ,
          IconButton(onPressed: (){
            MyBottomSheet.showConfirmBottomSheet(
              context: context,
              text: 'هل تريد الحذف' ,
              onClicked: (b){
                if(b)cubit?.getModel();
              },repositoryCallBack: (data)=>AdminRepository.deleteRole(model.items[index].id),

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
      appBar: AppBar(title: Text("إضافة دور جديد"),),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min  ,
          children: [

            SizedBox(height: 25,),
            RoundedTextField(
              hintText: "اسم الدور",
              controller: nameController,
            ),

            getDepartmentsAndRoles(),

            Expanded(child: Container()),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CreateModel<Role>(
                repositoryCallBack: (data) => AdminRepository.createRole(data),
                onCubitCreated: (c){
                  cubit=c;
                },
                onSuccess: (m){

                  Navigation.pop();
                  widget.onCreated(m);

                },
                child: ElevatedButton(
                    onPressed: () {
                      if(cubit!=null && nameController.text.length>0 &&selectedDepartment!= null)
                        cubit.createModel(Role(name: nameController.text,departmentId: selectedDepartment.id));

                    },
                    child: Text('إضافة دور جديد')
                ),
              ),
            )

          ],
        ),
      ),
    );
  }
  getDepartmentsAndRoles(){
    return GetModel<DepartmentListResponse>(
      repositoryCallBack: (data) => AdminRepository.getDepartments(),
      modelBuilder: (DepartmentListResponse model)=>buildDepartments(model),

    );
  }
  Department selectedDepartment;

  buildDepartments(DepartmentListResponse model) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          "المستودع",
        ),
        ObjectDropDown<Department>(
          selectedValue: selectedDepartment,
          items: model.items,
          text: 'المستودع',
          onChanged: (Department department){
            selectedDepartment = department;

            setState(() {

            });
          },
        ),
      ],
    );
  }

}



