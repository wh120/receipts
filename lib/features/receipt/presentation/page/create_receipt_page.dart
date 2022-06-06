import 'package:flutter/cupertino.dart';
import 'package:receipts/core/Boilerplate/CreateModel/cubits/create_model_cubit.dart';
import 'package:receipts/core/constants/AppColors.dart';
import 'package:receipts/core/utils/Navigation/Navigation.dart';
import 'package:receipts/core/widgets/forms/SelectDropDown.dart';
import 'package:receipts/features/RootApp/json/department_json.dart';
import 'package:receipts/features/RootApp/json/role_json.dart';

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:receipts/features/admin/data/department_list_response.dart';
import 'package:receipts/features/receipt/data/receipt_list_response.dart';

import '../../../../core/API/CoreModels/empty_model.dart';
import '../../../../core/Boilerplate/CreateModel/widgets/CreateModel.dart';
import '../../../../core/Boilerplate/GetModel/widgets/GetModel.dart';
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

  CreateModelCubit Cubit;

   @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: getBody(),
      // floatingActionButton: Padding(
      //   padding: const EdgeInsets.all(8.0),
      //   child: ElevatedButton(
      //     child: Text('التالي'),
      //
      //     onPressed: (){
      //       if(selectedRole != null && selectedDepartment != null) {
      //         selectedRole.department = selectedDepartment;
      //         Navigation.push(FillReceiptPage(
      //           receipt: Receipt(
      //             items: [],
      //             fromDepartmentId: selectedMyDepartment.id,
      //             toDepartmentId: selectedDepartment.id,
      //             mustApprovedByRole: selectedRole,
      //             receiptTypeId: selectedReceiptType+1,
      //           ),
      //         ));
      //       }
      //     },
      //   ),
      // ),
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
                        "إنشاء إيصال",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColors.black),
                      ),
                      Row(
                        children: [Icon(AntDesign.search1)],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
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
     if(selectedReceiptType == 3) return getTransformations();
     else return getDepartmentsAndRoles();
  }

  getDepartmentsAndRoles(){
     return GetModel<DepartmentListResponse>(
       repositoryCallBack: (data) => AdminRepository.getDepartments(),
       modelBuilder: (DepartmentListResponse departmentsModel)=>GetModel<DepartmentListResponse>(
         repositoryCallBack: (data) => AdminRepository.getMyDepartments(),
         modelBuilder: (DepartmentListResponse model) {
           departmentsModel.myDepartment = [];
           departmentsModel.myDepartment.addAll(model.items);
           departmentsModel.myDepartment.insert(0, Department(name: 'غير محدد'));
           return buildDepartmentsAndRoles(departmentsModel);
         },
       ),

     );
  }


  Department selectedDepartment;
  Department selectedMyDepartment;
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "من المستودع",
                            ),
                            ObjectDropDown<Department>(
                              selectedValue: selectedMyDepartment,
                              items: model.myDepartment,
                              text: 'المستودع',
                              onChanged: (Department department){
                                selectedMyDepartment = department;

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
                              "إلى المستودع",
                            ),
                            ObjectDropDown<Department>(
                              selectedValue: selectedDepartment,
                              items: model.items,
                              text: 'المستودع',
                              onChanged: (Department department){
                                selectedDepartment = department;
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
                              items: selectedDepartment?.roles??[],
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
                      if(selectedRole != null && selectedDepartment != null) {
                        selectedRole.department = selectedDepartment;
                        Navigation.push(FillReceiptPage(
                          receipt: Receipt(
                            items: [],
                            fromDepartmentId: selectedMyDepartment.id,
                            toDepartmentId: selectedDepartment.id,
                            mustApprovedByRole: selectedRole,
                            receiptTypeId: selectedReceiptType+1,
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


  Widget getTransformations(){
    return GetModel<TransformationList>(
      repositoryCallBack: (data) => AdminRepository.getTransformations(),
      modelBuilder: (model)=>buildTransformations(model)

    );
  }
  int selectedTransformationId = 0;
  buildTransformations(TransformationList model) {
    return Column(
      children: [
        getMyDepartment(),
        SizedBox(height: 10,),
        ListView.builder(
          shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: model.items.length,
            itemBuilder: (c, index) {
              return GeneralCard(
                onTap: (){
                  selectedTransformationId = model.items[index].id;
                  setState(() {

                  });
                },
                selected: selectedTransformationId==model.items[index].id,
                child: Column(
                  children: [
                    Center(
                      child: Text(model.items[index].name),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                            child: ColumnBuilder(
                              itemCount: model.items[index].inputs.length,
                              itemBuilder: (c, i) {
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(model.items[index].inputs[i].unitValue
                                        .toString()),
                                    Text(model.items[index].inputs[i].name),
                                  ],
                                );
                              },
                            )),
                        Icon(Icons.subdirectory_arrow_left_sharp),
                        Expanded(
                            child: ColumnBuilder(
                              itemCount: model.items[index].outputs.length,
                              itemBuilder: (c, i) {
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(model.items[index].outputs[i].unitValue
                                        .toString()),
                                    Text(model.items[index].outputs[i].name),
                                  ],
                                );
                              },
                            )),
                      ],
                    ),
                  ],
                ),
              );
            }),


        CreateModel<EmptyModel>(
          repositoryCallBack: (data) => ReceiptRepository.transformItems(selectedMyDepartment.id, selectedTransformationId),
          onCubitCreated: (c){Cubit=c;},
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: ElevatedButton(
                child: Text('التالي'),

                onPressed: (){
                  Cubit.createModel(null);
                },
              ),
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
              selectedValue: selectedMyDepartment,
              items: model.items,
              text: 'المستودع',
              onChanged: (Department department){
                selectedMyDepartment = department;

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
