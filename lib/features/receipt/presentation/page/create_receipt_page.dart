import 'package:flutter/cupertino.dart';
import 'package:receipts/core/Boilerplate/CreateModel/cubits/create_model_cubit.dart';
import 'package:receipts/core/constants/AppColors.dart';
import 'package:receipts/core/utils/Navigation/Navigation.dart';
import 'package:receipts/core/widgets/forms/RoundedNumberField.dart';
import 'package:receipts/core/widgets/forms/SelectDropDown.dart';
import 'package:receipts/features/RootApp/json/department_json.dart';
import 'package:receipts/features/RootApp/json/role_json.dart';

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:receipts/features/admin/data/department_list_response.dart';
import 'package:receipts/features/receipt/data/receipt_list_response.dart';
import 'package:receipts/features/receipt/presentation/page/transform_receipt_page.dart';

import '../../../../core/API/CoreModels/empty_model.dart';
import '../../../../core/Boilerplate/CreateModel/widgets/CreateModel.dart';
import '../../../../core/Boilerplate/GetModel/widgets/GetModel.dart';
import '../../../../core/utils/SharedPreferences/SharedPreferencesHelper.dart';
import '../../../../core/widgets/ColumnBuilder.dart';
import '../../../../core/widgets/cards/GeneralCard.dart';
import '../../../../core/widgets/forms/RoundedTextField.dart';
import '../../../RootApp/json/create_budget_json.dart';
import '../../../admin/data/role_list_response.dart';
import '../../../admin/data/transformation_list_response.dart';
import '../../../admin/repository/admin_repository.dart';
import '../../data/receipt_type_json.dart';
import '../../repository/ReceiptRepository.dart';
import 'fill_receipt_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreateReceiptPage extends StatefulWidget {
  @override
  _CreatBudgetPageState createState() => _CreatBudgetPageState();
}

class _CreatBudgetPageState extends State<CreateReceiptPage> {
  int selectedReceiptType = 0;
  int count = 1;

  CreateModelCubit Cubit;

  TextEditingController descriptionController = TextEditingController();

   @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "إنشاء إيصال",
          ),
        ),

      body: getBody(),

        floatingActionButtonLocation:
        FloatingActionButtonLocation.centerDocked
    );
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
            child: Text(
              "اختر نوع الإيصال",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black.withOpacity(0.5)),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
                children: List.generate(receipt_type.length, (index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedReceiptType = index;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                  ),
                  child: Container(
                    margin: EdgeInsets.only(
                      left: 10,
                    ),

                    decoration: BoxDecoration(
                        color: AppColors.white,
                        border: Border.all(
                            width: 2,
                            color: selectedReceiptType == index
                                ? AppColors.primary
                                : Colors.transparent),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.grey.withOpacity(0.01),
                            spreadRadius: 10,
                            blurRadius: 3,
                            // changes position of shadow
                          ),
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 25, right: 25, top: 20, bottom: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.grey.withOpacity(0.15)),
                              child: Center(
                                child: Image.asset(
                                  receipt_type[index]['icon'],
                                  width: 30,
                                  height: 30,
                                  fit: BoxFit.contain,
                                ),
                              )),
                          Text(
                            receipt_type[index]['name'],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            })),
          ),
          SizedBox(
            height: 50,
          ),
          buildbody( ),

          SizedBox(height: 50,),

        ],
      ),
    );
  }

  buildbody(){
    if(selectedReceiptType == 2) return buildTransformations();

     else return getDepartmentsAndRoles();
  }

  getDepartment(){
    return GetModel<DepartmentListResponse>(
      repositoryCallBack: (data) => AdminRepository.getDepartments(),
      modelBuilder: (DepartmentListResponse departmentsModel)=>GetModel<DepartmentListResponse>(
        repositoryCallBack: (data) => AdminRepository.getMyDepartments(),
        modelBuilder: (DepartmentListResponse model) {
          departmentsModel.myDepartment = [];
          departmentsModel.myDepartment.addAll(model.items);
          // departmentsModel.myDepartment.insert(0, Department(name: 'غير محدد'));
          return buildDepartmentsAndRoles(departmentsModel);
        },
      ),

    );
  }

  getDepartmentsAndRoles(){
     return GetModel<DepartmentListResponse>(
       repositoryCallBack: (data) => AdminRepository.getDepartments(),
       modelBuilder: (DepartmentListResponse departmentsModel)=>GetModel<DepartmentListResponse>(
         repositoryCallBack: (data) => AdminRepository.getMyDepartments(),
         modelBuilder: (DepartmentListResponse model) {
           departmentsModel.myDepartment = [];
           departmentsModel.myDepartment.addAll(model.items);
          // departmentsModel.myDepartment.insert(0, Department(name: 'غير محدد'));
           return buildDepartmentsAndRoles(departmentsModel);
         },
       ),

     );
  }



  Department selectedToDepartment;
  Department selectedFromDepartment;
  Role selectedRole;
   buildDepartmentsAndRoles(DepartmentListResponse model ) {


    return Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: (100.w - 140),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if(selectedReceiptType != 3)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "من القسم",
                            ),
                            ObjectDropDown<Department>(
                              selectedValue: selectedFromDepartment,
                              items: model.myDepartment,
                              text: 'القسم',
                              onChanged: (Department department){
                                selectedFromDepartment = department;

                                setState(() {

                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),

                ],
              ),
              SizedBox(
                height: 20,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: (100.w - 140),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "إلى القسم",
                            ),
                            ObjectDropDown<Department>(
                              selectedValue: selectedToDepartment,
                              items: model.items,
                              text: 'القسم',
                              onChanged: (Department department){
                                selectedToDepartment = department;
                                selectedRole =null;
                                setState(() {

                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),

                ],
              ),
              SizedBox(
                height: 20,
              ),

              if(selectedReceiptType != 3)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: (100.w - 140),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "العميل",

                            ),
                            ObjectDropDown<Role>(
                              selectedValue: selectedRole,
                              items: selectedToDepartment?.roles??[],
                              onChanged: (role){
                                selectedRole = role;
                                setState(() {

                                });
                              },
                              text: 'العميل',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),

                ],
              ),
              SizedBox(
                height: 20,
              ),
              Container(

                child: RoundedTextField(
                  controller: descriptionController,
                  maxLines: 2,
                  hintText: 'ملاحظات',
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: ElevatedButton(
                    child: Text('التالي'),

                    onPressed: (){
                      if(selectedToDepartment!=null && selectedToDepartment != null) {

                        Navigation.push(FillReceiptPage(
                          receipt: Receipt(
                            items: [],

                            fromDepartmentId: selectedFromDepartment?.id,
                            fromDepartment: selectedFromDepartment ,

                            toDepartmentId: selectedToDepartment.id,
                            toDepartment: selectedToDepartment,
                            mustApprovedByRole: selectedRole,
                            receiptTypeId: selectedReceiptType+1,
                            description: descriptionController.text
                          ),
                        ));
                      }
                    },
                  ),
                ),
              )




            ],
          ),
        );
  }



  int selectedTransformationId = 0;
  buildTransformations( ) {
    return Column(
      children: [

        getMyDepartment(),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 30),
          child: RoundedNumberField(
            onChanged: (v){
              count = int.tryParse(v)??1;
            },
            initialValue: 1,
            hintText: 'عدد المرات',
          ),
        ),


        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: ElevatedButton(
              child: Text('التالي'),

              onPressed: (){
                if(selectedFromDepartment != null)
                Navigation.push(TransformationReceiptPage(
                  count: count,
                  department: selectedFromDepartment,
                ));

              },
            ),
          ),
        )
      ],
    );
  }
  Widget getMyDepartment(){
    return GetModel<DepartmentListResponse>(
      repositoryCallBack: (data) => AdminRepository.getMyDepartments(),
      modelBuilder: (DepartmentListResponse model) {
        return  Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              "من المستودع",
            ),
            ObjectDropDown<Department>(
              selectedValue: selectedFromDepartment,
              items: model.items,
              text: 'المستودع',
              onChanged: (Department department){
                selectedFromDepartment = department;

                setState(() {

                });
              },
            ),
          ],
        );
      },
    );
  }

}
