import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:receipts/core/Boilerplate/CreateModel/cubits/create_model_cubit.dart';
import 'package:receipts/core/Boilerplate/CreateModel/widgets/CreateModel.dart';
import 'package:receipts/core/Boilerplate/GetModel/cubits/get_model_cubit.dart';
import 'package:receipts/core/Boilerplate/GetModel/widgets/GetModel.dart';
import 'package:receipts/core/widgets/BottomSheet.dart';
import 'package:receipts/core/widgets/ColumnBuilder.dart';
import 'package:receipts/core/widgets/forms/RoundedNumberField.dart';

import 'package:receipts/features/admin/repository/admin_repository.dart';


 import '../../../../core/widgets/data_table/widget_data_table.dart';
 import '../../data/item_category_list_response.dart';
import '../../data/item_list_response.dart';
import '../../data/item_main_category_list_response.dart';

import '/core/constants/AppColors.dart';
import '/core/utils/Navigation/Navigation.dart';
import '/core/widgets/forms/RoundedTextField.dart';
import '/core/widgets/forms/SelectDropDown.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class ItemPage extends StatefulWidget {
  @override
  _ItemPageState createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  GetModelCubit cubit;



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
                        "إدارة المواد",
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
                  Navigation.push(CreateDepartmentWidget(
                    onCreated: (_){
                      cubit.getModel();
                    },
                  ));
                  // showDialog(
                  //     context: context,
                  //     builder: (_)=>SingleChildScrollView(
                  //       child: Align(
                  //         alignment: Alignment.center,
                  //         child: Dialog(
                  //             child: Container(
                  //                 height:80.h ,
                  //                 child: CreateDepartmentWidget(
                  //                   onCreated: (_){
                  //                     cubit.getModel();
                  //                   },
                  //                 )) ),
                  //       ),
                  //     ));
                },
                child: Text('إضافة مادة جديد')
            ),
          )
        ],
      ),
    );
  }

  getBody(){
    return GetModel<ItemListResponseModel>(
      onCubitCreated: (c) {
        cubit=c;
      },
      repositoryCallBack: (data) => AdminRepository.getItems(),
      modelBuilder: (ItemListResponseModel model)=>buildbody(model),

    );
  }
  buildbody(ItemListResponseModel model) {

    int maxUnitCount = 0;

    model.items.forEach((element) {
      if(element.units.length > maxUnitCount)maxUnitCount=element.units.length;
    });

      List<Widget> columns = [
        Text("الرقم"),
        Text("الاسم"),
        Text("الكود"),
        Text("التصنيف الرئيسي"),
        Text("الوحدة 1"),
      ];

      for(int i = 0; i < maxUnitCount;i++)
        columns.add(Text('الوحدة' +(i+2).toString()));


      columns.add( Text("الأوامر"));
      List<List<Widget>> rows = List.generate(
          model.items.length, (index) {
        List<Widget> r = [
              Text(model.items[index].id.toString()),
              Text(model.items[index].name) ,
              Text(model.items[index].code) ,
              Text(model.items[index].itemCategory?.name??'-') ,
             Text(model.items[index].unit) ,

            ];
            for(int i = 0; i < maxUnitCount;i++)
              r.add(Text(model.items[index].units.tryGet(i)?.name??'-'));

            r.add(IconButton(onPressed: (){
              MyBottomSheet.showConfirmBottomSheet(
                context: context,
                text: 'هل تريد الحذف' ,
                onClicked: (b){
                  if(b)cubit?.getModel();
                },repositoryCallBack: (data)=>AdminRepository.deleteItem(model.items[index].id),

              );
            }, icon: Icon(Icons.delete)));


            return r;

      });
    
    return SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      child: WidgetDataTable(
        columns: columns,
        rows:rows,
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
  TextEditingController unitController = TextEditingController();

  List<Unit> units =[];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("إضافة مادة جديدة"),),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            
            children: [

              SizedBox(height: 25,),
              RoundedTextField(
                hintText: "اسم المادة",
                controller: nameController,
              ),

              RoundedTextField(
                hintText: "الكود",
                controller: codeController,
              ),

              getItemMainCategories(),
              SizedBox(height: 25,),
              RoundedTextField(
                hintText: "الوحدة الرئيسية",
                controller: unitController,
              ),
              ColumnBuilder(
                // shrinkWrap: true,
                // physics: NeverScrollableScrollPhysics(),
                itemCount: units.length,
                itemBuilder: (context, index) {
                  return Row(children: [
                    Expanded(
                      child: RoundedTextField(
                        hintText: "الوحدة " +(index+1).toString(),
                        onChanged: (value){
                          units[index].name=value;
                        },
                      ),
                    ),
                    SizedBox(width: 18,),
                    Expanded(
                      child: RoundedNumberField(
                        hintText: "عامل التحويل "  ,
                        onChanged: (value){
                          units[index].conversionFactor=int.tryParse(value);
                        },
                      ),
                    ),
                    IconButton(onPressed: (){
                      units.removeAt(index);
                      setState(() {

                      });
                    },
                        icon: Icon(Icons.remove)
                    ),

                  ],);

              },),
              IconButton(onPressed: (){
                units.add(Unit(
                  name: '',
                  conversionFactor: 0
                ));
                setState(() {

                });
              },
                  icon: Icon(Icons.add)
              ),





              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CreateModel<Item>(
                  repositoryCallBack: (data) => AdminRepository.createItem(data),
                  onCubitCreated: (c){
                    cubit=c;
                  },
                  onSuccess: (m){

                    Navigation.pop();
                    widget.onCreated(m);

                  },
                  child: ElevatedButton(
                      onPressed: () {
                        bool validate = true;
                        units.forEach((element) {
                          if(element.name.isEmpty || element.conversionFactor==null ||element.conversionFactor==0)
                            validate =false;
                        });
                        if(validate &&cubit!=null && nameController.text.isNotEmpty && unitController.text.isNotEmpty && codeController.text.isNotEmpty&&selectedMainCategory!= null) {

                          var item = Item(
                              name: nameController.text,
                              code: codeController.text,
                              isDefaultUnit: true,
                              itemCategoryId: selectedMainCategory.id,
                               unit: unitController.text,
                              units: units
                          );
                          cubit.createModel(item);
                        }

                      },
                      child: Text('إضافة مادة جديدة')
                  ),
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
  getItemMainCategories(){
    return GetModel<ItemCategoryListResponse>(
      repositoryCallBack: (data) => AdminRepository.getItemCategories(),
      modelBuilder: (ItemCategoryListResponse model)=>buildItemMainCategories(model),

    );
  }
  ItemCategory selectedMainCategory;

  buildItemMainCategories(ItemCategoryListResponse model) {

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          "التصنيف الرئيسي",
        ),
        ObjectDropDown<ItemCategory>(
          selectedValue: selectedMainCategory,
          items: model.items,
          text: 'التصنيف الرئيسي',
          onChanged: (ItemCategory department){
            selectedMainCategory = department;

            setState(() {

            });
          },
        ),
      ],
    );
  }

}



extension ListGetExtension<T> on List<T> {
  T tryGet(int index) =>
      index < 0 || index >= this.length ? null : this[index];
}