import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:receipts/core/Boilerplate/CreateModel/widgets/CreateModel.dart';
import 'package:receipts/core/utils/extensions/extensions.dart';
import 'package:receipts/core/widgets/cards/GeneralCard.dart';
import 'package:receipts/features/admin/data/department_list_response.dart';
import 'package:receipts/features/receipt/data/create_receipt_request.dart';
import '../../../admin/data/item_list_response.dart';
import 'package:receipts/features/receipt/data/receipt_list_response.dart';
import 'package:receipts/features/receipt/data/receipt_type_json.dart';
import 'package:receipts/features/receipt/repository/ReceiptRepository.dart';
import 'package:search_choices/search_choices.dart';

import 'package:flutter_icons/flutter_icons.dart';
import '../../../../core/API/CoreModels/empty_model.dart';
import '../../../../core/Boilerplate/CreateModel/cubits/create_model_cubit.dart';
import '../../../../core/Boilerplate/GetModel/widgets/GetModel.dart';
import '../../../../core/widgets/data_table/data_table.dart';
import '../../../../core/widgets/data_table/widget_data_table.dart';
import '/core/constants/AppColors.dart';
import '/core/utils/Navigation/Navigation.dart';
import '/core/widgets/forms/RoundedNumberField.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter/cupertino.dart';
import 'package:receipts/core/Boilerplate/CreateModel/cubits/create_model_cubit.dart';
import 'package:receipts/core/constants/AppColors.dart';
import 'package:receipts/core/utils/Navigation/Navigation.dart';
import 'package:receipts/core/widgets/forms/RoundedNumberField.dart';
import 'package:receipts/core/widgets/forms/SelectDropDown.dart';

import '../../../../core/Boilerplate/CreateModel/widgets/CreateModel.dart';

import '../../../../core/utils/SharedPreferences/SharedPreferencesHelper.dart';
import '../../../../core/widgets/ColumnBuilder.dart';
import '../../../../core/widgets/cards/GeneralCard.dart';

import '../../../admin/data/transformation_list_response.dart';
import '../../../admin/repository/admin_repository.dart';
import '../../data/receipt_type_json.dart';
import '../../repository/ReceiptRepository.dart';


class TransformationReceiptPage extends StatefulWidget {
  final Department department;
  final int count;

  const TransformationReceiptPage({Key key, this.department , this.count}) : super(key: key);
  @override
  _CreateReceiptPageState createState() => _CreateReceiptPageState();
}

class _CreateReceiptPageState extends State<TransformationReceiptPage> {
  List<DropdownMenuItem<Item>> items = [];
  bool isNew;
  @override
  void initState() {
    // isNew = widget.receipt.id == null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          receipt_type[2]["name"]+ ' '+
          widget.department?.name??'-',
          style: TextStyle(fontSize: 15, color: AppColors.black),
        )

      ),
      // backgroundColor: Colors.grey[100],
      body: Column(
        children: [

          Expanded(
              child: Padding(
                child: getTransformations(),
                padding: const EdgeInsets.all(8.0),
              )
          ),
          CreateModel<EmptyModel>(
            onSuccess: (_){
              Navigation.pop();
            },
            repositoryCallBack: (data) => ReceiptRepository.transformItems(widget.department.id, selectedTransformationId,widget.count),
            onCubitCreated: (c){Cubit=c;},
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: ElevatedButton(
                  child: Text('التالي'),

                  onPressed: (){
                    if(widget.department!= null && selectedTransformationId!= null)
                      Cubit.createModel(null);
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  CreateModelCubit cubit;


  Widget getTransformations(){
    return GetModel<TransformationList>(
        repositoryCallBack: (data) => AdminRepository.getTransformations(),
        modelBuilder: (model)=>buildTransformations(model)

    );
  }
  int selectedTransformationId;
  int count = 1;
  CreateModelCubit Cubit;
  buildTransformations(TransformationList model) {
    return ListView.builder(
        // shrinkWrap: true,
        // physics: NeverScrollableScrollPhysics(),
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
                if(AppSharedPreferences.isAdmin)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                          child: ColumnBuilder(
                            itemCount: model.items[index].inputs.length,
                            itemBuilder: (c, i) {
                              return Wrap(
                              //  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Text(model.items[index].inputs[i].defaultUnitValue
                                      .toString()),
                                  SizedBox(width: 4,),

                                  Text(model.items[index].inputs[i].defaultUnit
                                      .toString()),
                                  SizedBox(width: 4,),

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
                              return Wrap(
                               // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Text(model.items[index].outputs[i].defaultUnitValue
                                      .toString()),
                                  SizedBox(width: 4,),
                                  Text(model.items[index].outputs[i].defaultUnit
                                      .toString()),
                                  SizedBox(width: 4,),
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
        });
  }


}

