import 'package:flutter/material.dart';
import 'package:receipts/core/Boilerplate/CreateModel/cubits/create_model_cubit.dart';
import 'package:receipts/core/Boilerplate/CreateModel/widgets/CreateModel.dart';
import 'package:receipts/core/Boilerplate/GetModel/cubits/get_model_cubit.dart';
import 'package:receipts/core/Boilerplate/GetModel/widgets/GetModel.dart';

import '../../../../core/API/CoreModels/empty_model.dart';
import '../../../../core/constants/AppColors.dart';
import '../../../../core/utils/Navigation/Navigation.dart';
import '../../../../core/widgets/BottomSheet.dart';
import '../../../../core/widgets/ColumnBuilder.dart';
import '../../../../core/widgets/cards/GeneralCard.dart';
import '../../../../core/widgets/forms/RoundedTextField.dart';
import '../../../../core/widgets/tab_bar/default_tab_bar.dart';
import '../../../receipt/presentation/page/fill_receipt_page.dart';
import '../../../receipt/repository/ReceiptRepository.dart';
import '../../data/item_list_response.dart';
import '../../data/transformation_list_response.dart';
import '../../repository/admin_repository.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TransformationPage extends StatefulWidget {
  const TransformationPage({Key key}) : super(key: key);

  @override
  State<TransformationPage> createState() => _TransformationPageState();
}

class _TransformationPageState extends State<TransformationPage> {
  GetModelCubit cubit;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "إدارة عمليات التحويل",
        ),
      ),
      body: Column(
        children: [
          Container(

          ),
          Expanded(child: buildPage()),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                onPressed: () {
                  Navigation.push(AddTransformationPage(
                    onCreated: (_){cubit.getModel();},
                  ));
                },
                child: Text('إضافة عملية جديدة')),
          )
        ],
      ),
    );
  }

  buildPage(){
    return DefaultTabBar(
      tabs: {
        'الفعالة':getBody(true),
        'المؤرشفة':getBody(false)
      },
    );
  }
  getBody(bool isActive) {
    return GetModel<TransformationList>(
      repositoryCallBack: (data) => AdminRepository.getTransformations(isActive: isActive),
      modelBuilder: (TransformationList model) => buildBody(model),
      onCubitCreated: (c){cubit=c;},
    );
  }

  buildBody(TransformationList model) {
    return ListView.builder(
        itemCount: model.items.length,
        itemBuilder: (c, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GeneralCard(
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
                          child: GeneralCard(
                            selected: true,
                            child: ColumnBuilder(
                        itemCount: model.items[index].inputs.length,
                        itemBuilder: (c, i) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10.0),
                              child: Wrap(
                                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Text(model.items[index].inputs[i].defaultUnitValue.toString() ),
                                  SizedBox(width: 5,),
                                  Text(model.items[index].inputs[i].defaultUnit),
                                  SizedBox(width: 8,),
                                  Text(model.items[index].inputs[i].name  ),
                                ],
                              ),
                            );
                        },
                      ),
                          )),
                      Icon(Icons.subdirectory_arrow_left_sharp),
                      Expanded(
                          child: GeneralCard(
                            selected: true,
                            child: ColumnBuilder(
                        itemCount: model.items[index].outputs.length,
                        itemBuilder: (c, i) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10.0),
                              child: Wrap(
                                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  SizedBox(width: 5,),
                                  Text(model.items[index].outputs[i].defaultUnitValue
                                      .toString()),
                                  SizedBox(width: 5,),
                                  Text(model.items[index].outputs[i].defaultUnit),
                                  SizedBox(width: 8,),
                                  Text(model.items[index].outputs[i].name),
                                ],
                              ),
                            );
                        },
                      ),
                          )),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(onPressed: (){
                        Navigation.push(AddTransformationPage(
                          onCreated: (_){cubit.getModel();},
                          transformation: model.items[index],
                        )).then((value) => cubit.getModel());

                      }, child: Text('تعديل')),
                      buildDeleteButton(model.items[index]),
                      buildSwitchActiveButton(model.items[index]),

                    ],
                  ),

                ],
              ),
            ),
          );
        });
  }

   buildDeleteButton(Transformation transformation) {

    return ElevatedButton(onPressed: (){
      MyBottomSheet.showConfirmBottomSheet(
        context: context,
        text: 'هل تريد الحذف' ,
        onClicked: (b){
           if(b)cubit?.getModel();
        },
        repositoryCallBack: (data)=>AdminRepository.deleteTransformation(transformation.id),

      );

    }, child: Text('حذف'));
  }

  buildSwitchActiveButton(Transformation transformation) {

    return ElevatedButton(onPressed: (){
      MyBottomSheet.showConfirmBottomSheet(
        context: context,
        text: 'هل تريد إلغاء التفعيل؟' ,
        onClicked: (b){
          if(b)cubit?.getModel();
        },
        repositoryCallBack: (data)=>AdminRepository.switchActiveTransformation(transformation.id),

      );

    }, child: Text(
        transformation.isActive? 'إلغاء التفعيل':'تفعيل'));
  }

}

class AddTransformationPage extends StatefulWidget {
  final ValueChanged onCreated;
  final Transformation transformation;
  const AddTransformationPage({Key key, this.onCreated, this.transformation}) : super(key: key);

  @override
  State<AddTransformationPage> createState() => _AddTransformationPageState();
}

class _AddTransformationPageState extends State<AddTransformationPage> {
  List<DropdownMenuItem<Item>> items = [];
  Transformation transformation = Transformation(inputs: [], outputs: []);

  CreateModelCubit cubit;
  bool isUpdate = false;

  TextEditingController nameController = TextEditingController();

  @override
  void initState() {

    if(widget.transformation != null) {
      isUpdate = true;
      transformation = widget.transformation;
      nameController.text = transformation.name;
    }

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            isUpdate?
                'تعديل العملية':
            'إضافة عملية جديدة'
        ),
      ),
      body: loadBody(),
    );
  }


  Widget loadBody() {
    return GetModel<ItemListResponseModel>(
      repositoryCallBack: (data) => ReceiptRepository.getItems(),
      modelBuilder: (ItemListResponseModel model) => Column(
        children: [
          Expanded(child: buildBody()),
          buildCreateButton()
        ],
      ),
      onSuccess: (model) {
        model.items.forEach((element) {
          items.add(DropdownMenuItem<Item>(
            child: Text(element.name),
            value: element,
          ));
        });
      },
    );
  }

  Widget buildBody() {
    return Column(
     // mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          flex: 2,
          child: Row(
            // textBaseline: TextBaseline.ideographic,
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // crossAxisAlignment: CrossAxisAlignment.baseline,
            children: [
              Expanded(
                  child: GeneralCard(child: Column(
                  children: [
                    Text('الطرف الأول '),
                    SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: ListView.separated(
                        itemCount: transformation.inputs.length,
                        itemBuilder: (context, index) => buildItem(transformation.inputs,index),
                        separatorBuilder: (BuildContext context, int index) {
                          return Divider();
                      },
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                            showDialog(
                                context: context,
                                useRootNavigator: true,
                                builder: (_) {
                                  return Align(
                                    alignment: Alignment.center,
                                    child: SingleChildScrollView(
                                      child: Container(
                                          child: SelectItemWidget(
                                        items: items,
                                        onDone: (Item item) {
                                          transformation.inputs.add(item);
                                          // if(item!= null)
                                          //   widget.receipt.items.add(item);
                                          setState(() {});
                                        },
                                      )),
                                    ),
                                  );
                                });
                            //  Navigator.of(context).restorablePush(_dialogBuilder);
                          });
                        },
                        child: Text('إضافة مادة أخرى')),
                  ],
                ),
              )),
              Icon(Icons.subdirectory_arrow_left_sharp),
              Expanded(
                  child: GeneralCard(
                child: Column(
                  children: [
                    Text('الطرف الثاني '),
                    SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: transformation.outputs.length,
                        itemBuilder: (context, index) => buildItem(transformation.outputs,index),
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                            showDialog(
                                context: context,
                                useRootNavigator: true,
                                builder: (_) {
                                  return Align(
                                    alignment: Alignment.center,
                                    child: SingleChildScrollView(
                                      child: Container(
                                          child: SelectItemWidget(
                                        items: items,
                                        onDone: (Item item) {
                                       //   List<double> values = [];
                                          // item.units.forEach((element) {
                                          //   values.add(element.value);
                                          // });
                                          // item.values = values;

                                          transformation.outputs.add(item);
                                          // if(item!= null)
                                          //   widget.receipt.items.add(item);
                                          setState(() {});
                                        },
                                      )),
                                    ),
                                  );
                                });
                            //  Navigator.of(context).restorablePush(_dialogBuilder);
                          });
                        },
                        child: Text(

                            'إضافة مادة أخرى')),
                  ],
                ),
              )),
            ],
          ),
        ),
        Expanded(child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              RoundedTextField(
                controller: nameController,
                hintText: 'الاسم',
              )
            ],
          ),
        ))
      ],
    );
  }

   buildItem( List<Item> items,int index) {
    return ListTile(
      leading: IconButton(
        icon: Icon(Icons.close),
        onPressed: (){
          items.removeAt(index);
          setState(() {});
        },
      ),
      title: Text(items[index].name),
      subtitle: Text(items[index].unitValue
          .toString() +
          ' ' +
          items[index].unit.toString()),
    );
    return Wrap(
                        children: [
                          IconButton(
                            icon: Icon(Icons.close),
                            onPressed: (){
                              items.removeAt(index);
                              setState(() {});
                            },
                          ),
                          Text(items[index].name),
                          Spacer(),
                          Text(items[index].unitValue
                                  .toString() +
                              ' ' +
                              items[index].unit.toString())
                        ],
                      );
  }

  buildCreateButton() {
    return CreateModel<EmptyModel>(
      repositoryCallBack: (data)=>isUpdate?AdminRepository.updateTransformation(transformation.id,data):AdminRepository.createTransformation(data),
      onCubitCreated: (c){cubit=c;},
      onSuccess: (m){
        widget.onCreated(m);
        Navigation.pop();
      },
      child: ElevatedButton(
          onPressed: () {
            if(nameController.text.isNotEmpty){
              transformation.name = nameController.text;
              cubit.createModel(transformation);
            }
          },
          child: Text(
              isUpdate?
              'تعديل المادة':
              'إضافة عملية جديدة')
      ),
    );
  }


}
