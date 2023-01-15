import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:receipts/core/Boilerplate/CreateModel/cubits/create_model_cubit.dart';
import 'package:receipts/core/Boilerplate/CreateModel/widgets/CreateModel.dart';
import 'package:receipts/core/Boilerplate/GetModel/cubits/get_model_cubit.dart';
import 'package:receipts/core/Boilerplate/GetModel/widgets/GetModel.dart';
import 'package:receipts/core/utils/extensions/extensions.dart';
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
      appBar: AppBar(
        title: Text(
          "إدارة المواد",
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
                  Navigation.push(CreateItemWidget(
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

            r.add(Row(
              children: [
                IconButton(onPressed: (){
                  MyBottomSheet.showConfirmBottomSheet(
                    context: context,
                    text: 'هل تريد الحذف' ,
                    onClicked: (b){
                      if(b)cubit?.getModel();
                    },repositoryCallBack: (data)=>AdminRepository.deleteItem(model.items[index].id),

                  );
                }, icon: Icon(Icons.delete)
                ),

                IconButton(onPressed: (){

                  Navigation.push(CreateItemWidget(item:model.items[index] , onCreated: (_){cubit.getModel();},));
                }, icon: Icon(Icons.edit))

              ],
            )
            );




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

class CreateItemWidget extends StatefulWidget {
  final ValueChanged onCreated;
  final Item item;

  const CreateItemWidget({Key key, this.onCreated, this.item}) : super(key: key);
  @override
  _CreateItemWidgetState createState() => _CreateItemWidgetState();
}

class _CreateItemWidgetState extends State<CreateItemWidget> {

  CreateModelCubit cubit;
  TextEditingController nameController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  TextEditingController unitController = TextEditingController();

  Item item = new Item(units: []);


  @override
  void initState() {

    if(widget.item != null){


      item  = widget.item;
      selectedMainCategory=item.itemCategory;
    }


    super.initState();
  }

 // List<Unit> units =[];
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
                // controller: nameController,
                initialValue:item.name ,
                onChanged: (v){item.name=v;},
              ),

              RoundedTextField(
                hintText: "الكود",
                initialValue: item.code,
                // controller: codeController,
                onChanged: (v){item.code=v;},
              ),

              getItemMainCategories(),
              SizedBox(height: 25,),
              RoundedTextField(
                hintText: "الوحدة الرئيسية",
                // controller: unitController,
                initialValue:item.unit ,
                onChanged: (v){item.unit=v;},
              ),
              ColumnBuilder(
                // shrinkWrap: true,
                // physics: NeverScrollableScrollPhysics(),
                itemCount: item.units.length,
                itemBuilder: (context, index) {
                  return Row(children: [
                    Expanded(
                      child: RoundedTextField(
                        initialValue: item.units[index].name,
                        hintText: "الوحدة " +(index+1).toString(),
                        onChanged: (value){
                          item.units[index].name=value;
                        },
                      ),
                    ),
                    SizedBox(width: 18,),
                    Expanded(
                      child: RoundedNumberField(
                        initialValue: item.units[index].conversionFactor.toDouble(),
                        hintText: "عامل التحويل "  ,
                        onChanged: (value){
                          item.units[index].conversionFactor=double.tryParse(value);
                        },
                      ),
                    ),
                    IconButton(onPressed: (){
                      item.units.removeAt(index);
                      setState(() {

                      });
                    },
                        icon: Icon(Icons.remove)
                    ),

                  ],);

              },),
              IconButton(onPressed: (){
                item.units.add(Unit(
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
                  repositoryCallBack: (data) =>widget.item==null? AdminRepository.createItem(data):AdminRepository.updateItem(widget.item.id,data) ,
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
                        item.units.forEach((element) {
                          if(element.name.isEmpty || element.conversionFactor==null ||element.conversionFactor==0)
                            validate =false;
                        });

                        if(validate &&cubit!=null &&
                            // nameController.text.isNotEmpty &&
                            // unitController.text.isNotEmpty &&
                            // codeController.text.isNotEmpty&&
                            selectedMainCategory!= null) {



                          item.itemCategoryId =selectedMainCategory.id;


                          cubit.createModel(item);
                        }

                      },
                      child: Text(widget.item==null?'إضافة مادة جديدة':'تعديل المادة')
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



