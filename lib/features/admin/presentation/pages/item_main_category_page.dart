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
import '../../data/item_main_category_list_response.dart';
import '/core/constants/AppColors.dart';
import '/core/utils/Navigation/Navigation.dart';
import '/core/widgets/data_table/data_table.dart';
import '/core/widgets/forms/RoundedNumberField.dart';
import '/core/widgets/forms/RoundedTextField.dart';
import '/core/widgets/forms/SelectDropDown.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class ItemMainCategoryPage extends StatefulWidget {
  @override
  _DepartmentPageState createState() => _DepartmentPageState();
}

class _DepartmentPageState extends State<ItemMainCategoryPage> {
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
          "إدارة الأصناف الرئيسية",
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
                                  height:60.h ,
                                  child: CreateDepartmentWidget(
                                    onCreated: (_){
                                      cubit.getModel();
                                    },
                                  )) ),
                        ),
                      ));
                },
                child: Text('إضافة صنف جديد')
            ),
          )
        ],
      ),
    );
  }

  getBody(){
    return GetModel<ItemMainCategoryListResponse>(
      onCubitCreated: (c) {
        cubit=c;
      },
      repositoryCallBack: (data) => AdminRepository.getItemMainCategories(),
      modelBuilder: (ItemMainCategoryListResponse model)=>buildbody(model),

    );
  }
  buildbody(ItemMainCategoryListResponse model) {
    return SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      child: WidgetDataTable(
        columns: [
          Text("الرقم"),
          Text("الاسم"),
          Text("الكود"),
          Text("القسم"),
          Text("الأوامر"),

        ],
        rows: List.generate(model.items.length, (index) => [
          Text(model.items[index].id.toString()),
          Text(model.items[index].name) ,
          Text(model.items[index].code) ,
          Text(model.items[index].department?.name??'جميع الأقسام') ,
          Row(
            children: [
              IconButton(onPressed: (){
                MyBottomSheet.showConfirmBottomSheet(
                  context: context,
                  text: 'هل تريد الحذف' ,
                  onClicked: (b){
                    if(b)cubit?.getModel();
                  },repositoryCallBack: (data)=>AdminRepository.deleteItemMainCategory(model.items[index].id),

                );
              }, icon: Icon(Icons.delete)),

              IconButton(onPressed: (){

                Navigation.push(CreateDepartmentWidget(itemMainCategory:model.items[index] , onCreated: (_){cubit.getModel();},));
              }, icon: Icon(Icons.edit))
            ],
          )


        ]),
      ),
    );
  }





}

class CreateDepartmentWidget extends StatefulWidget {
  final ValueChanged onCreated;
  final ItemMainCategory itemMainCategory;

  const CreateDepartmentWidget({Key key, this.onCreated, this.itemMainCategory}) : super(key: key);
  @override
  _CreateDepartmentWidgetState createState() => _CreateDepartmentWidgetState();
}

class _CreateDepartmentWidgetState extends State<CreateDepartmentWidget> {

  CreateModelCubit cubit;
  TextEditingController nameController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  ItemMainCategory itemMainCategory;

  void initState() {

    if(widget.itemMainCategory!= null){
      itemMainCategory=widget.itemMainCategory;
    }
    else{
      itemMainCategory = new ItemMainCategory(
        name: '',
        code: ''
      );
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("إضافة صنف"),),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min  ,
          children: [

            SizedBox(height: 25,),
            RoundedTextField(
              hintText: "اسم الصنف",
              onChanged: (v){itemMainCategory.name = v;},
              initialValue: itemMainCategory.name,
              // controller: nameController,
            ),
            RoundedTextField(
              hintText: "الكود",
              onChanged: (v){itemMainCategory.code = v;},
              initialValue: itemMainCategory.code,
              // controller: codeController,
            ),
            getDepartmentsAndRoles(),

            Expanded(child: Container()),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CreateModel<ItemMainCategory>(
                repositoryCallBack: (data) =>widget.itemMainCategory==null? AdminRepository.createItemMainCategory(data):AdminRepository.updateItemMainCategory(data),
                onCubitCreated: (c){
                  cubit=c;
                },
                onSuccess: (m){

                  Navigation.pop();
                  widget.onCreated(m);

                },
                child: ElevatedButton(
                    onPressed: () {
                      if(cubit!=null && itemMainCategory.name.isNotEmpty && itemMainCategory.code.isNotEmpty) {
                        print(itemMainCategory.department);
                        itemMainCategory.departmentId = itemMainCategory.department.id;
                        cubit.createModel(itemMainCategory);
                      }

                    },
                    child: Text('إضافة صنف جديد')
                ),
              ),
            )

          ],
        ),
      ),
    );
  }
  Department selectedDepartment;

  getDepartmentsAndRoles(){
    return GetModel<DepartmentListResponse>(
      repositoryCallBack: (data) => AdminRepository.getDepartments(),
      modelBuilder: (DepartmentListResponse model) {

        List<Department> items = [];
        items.addAll(model.items);
        items.insert(0, Department(name: "جميع الأقسام" ,id: null ));
        return buildDepartments(items);
      },

    );
  }
  buildDepartments(List<Department> items) {

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          "القسم",
        ),
        ObjectDropDown<Department>(
          selectedValue: itemMainCategory.department,
          items:  items,
          text: 'المستودع',
          onChanged: (Department department){
           // selectedDepartment = department;
            itemMainCategory.department = department;


            setState(() {

            });
          },
        ),
      ],
    );
  }
}



