import 'package:flutter/cupertino.dart';
import 'package:receipts/core/constants/AppColors.dart';
import 'package:receipts/core/utils/Navigation/Navigation.dart';
import 'package:receipts/core/widgets/forms/SelectDropDown.dart';
import 'package:receipts/features/Tracker/json/department_json.dart';
import 'package:receipts/features/Tracker/json/role_json.dart';

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:receipts/features/admin/data/department_list_response.dart';
import 'package:receipts/features/receipt/data/receipt_list_response.dart';

import '../../../../core/Boilerplate/GetModel/widgets/GetModel.dart';
import '../../../Tracker/json/create_budget_json.dart';
import '../../../admin/data/role_list_response.dart';
import '../../../admin/repository/admin_repository.dart';
import '../../data/receipt_type_json.dart';
import 'fill_receipt_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreateReceiptPage extends StatefulWidget {
  @override
  _CreatBudgetPageState createState() => _CreatBudgetPageState();
}

class _CreatBudgetPageState extends State<CreateReceiptPage> {
  int selectedReceiptType = 0;

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
          getDepartmentsAndRoles( ),
          SizedBox(height: 25,),
          Center(
            child: TextButton(
              child: Text('التالي'),

              onPressed: (){
                if(selectedRole != null && selectedDepartment != null) {
                  selectedRole.department = selectedDepartment;
                  Navigation.push(FillReceiptPage(
                    receipt: Receipt(
                      items: [],
                      mustApprovedByRole: selectedRole,
                      receiptTypeId: selectedReceiptType+1,
                    ),
                  ));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
  getDepartmentsAndRoles(){
     return GetModel<DepartmentListResponse>(
       repositoryCallBack: (data) => AdminRepository.getDepartments(),
       modelBuilder: (DepartmentListResponse model)=>buildDepartmentsAndRoles(model),

     );
  }

  Department selectedDepartment;
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
                              "المستودع",
                            ),
                            ObjectDropDown<Department>(
                              selectedValue: selectedDepartment,
                              items: model.items,
                              text: 'العميل',
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
              )
            ],
          ),
        );
  }
}
