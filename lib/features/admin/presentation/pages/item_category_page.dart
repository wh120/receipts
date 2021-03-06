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
import '../../data/item_category_list_response.dart';
import '../../data/item_main_category_list_response.dart';
import '../../data/role_list_response.dart';
import '/core/constants/AppColors.dart';
import '/core/utils/Navigation/Navigation.dart';
import '/core/widgets/data_table/data_table.dart';
import '/core/widgets/forms/RoundedNumberField.dart';
import '/core/widgets/forms/RoundedTextField.dart';
import '/core/widgets/forms/SelectDropDown.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class ItemCategoryPage extends StatefulWidget {
  @override
  _ItemCategoryPageState createState() => _ItemCategoryPageState();
}

class _ItemCategoryPageState extends State<ItemCategoryPage> {
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
          "إدارة التصنيفات الفرعية",
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
                                  height:70.h ,
                                  child: CreateDepartmentWidget(
                                    onCreated: (_){
                                      cubit.getModel();
                                    },
                                  )) ),
                        ),
                      ));
                },
                child: Text('إضافة تصنيف جديد')
            ),
          )
        ],
      ),
    );
  }

  getBody(){
    return GetModel<ItemCategoryListResponse>(
      onCubitCreated: (c) {
        cubit=c;
      },
      repositoryCallBack: (data) => AdminRepository.getItemCategories(),
      modelBuilder: (ItemCategoryListResponse model)=>buildbody(model),

    );
  }
  buildbody(ItemCategoryListResponse model) {
    return SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      child: WidgetDataTable(
        columns: [
          Text("الرقم"),
          Text("الاسم"),
          Text("الكود"),
          Text("التصنيف الرئيسي"),
          Text("الأوامر"),

        ],
        rows: List.generate(model.items.length, (index) => [
          Text(model.items[index].id.toString()),
          Text(model.items[index].name) ,
          Text(model.items[index].code) ,
          Text(model.items[index].itemMainCategory?.name??'-') ,
          IconButton(onPressed: (){
            MyBottomSheet.showConfirmBottomSheet(
              context: context,
              text: 'هل تريد الحذف' ,
              onClicked: (b){
                if(b)cubit?.getModel();
              },repositoryCallBack: (data)=>AdminRepository.deleteItemCategory(model.items[index].id),

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
  TextEditingController codeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("إضافة تصنيف جديد"),),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min  ,
          children: [

            SizedBox(height: 25,),
            RoundedTextField(
              hintText: "اسم التصنيف",
              controller: nameController,
            ),

            RoundedTextField(
              hintText: "الكود",
              controller: codeController,
            ),

            getItemMainCategories(),

            Expanded(child: Container()),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CreateModel<ItemCategory>(
                repositoryCallBack: (data) => AdminRepository.createItemCategory(data),
                onCubitCreated: (c){
                  cubit=c;
                },
                onSuccess: (m){

                  Navigation.pop();
                  widget.onCreated(m);

                },
                child: ElevatedButton(
                    onPressed: () {
                      if(cubit!=null && nameController.text.isNotEmpty  && codeController.text.isNotEmpty&&selectedMainCategory!= null)
                        cubit.createModel(ItemCategory(name: nameController.text, code: codeController.text,itemMainCategoryId: selectedMainCategory.id));

                    },
                    child: Text('إضافة تصنيف جديد')
                ),
              ),
            )

          ],
        ),
      ),
    );
  }
  getItemMainCategories(){
    return GetModel<ItemMainCategoryListResponse>(
      repositoryCallBack: (data) => AdminRepository.getItemMainCategories(),
      modelBuilder: (ItemMainCategoryListResponse model)=>buildItemMainCategories(model),

    );
  }
  ItemMainCategory selectedMainCategory;

   buildItemMainCategories(ItemMainCategoryListResponse model) {

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          "التصنيف الرئيسي",
        ),
        ObjectDropDown<ItemMainCategory>(
          selectedValue: selectedMainCategory,
          items: model.items,
          text: 'التصنيف الرئيسي',
          onChanged: (ItemMainCategory department){
            selectedMainCategory = department;

            setState(() {

            });
          },
        ),
      ],
    );
  }

}



