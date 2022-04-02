import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:receipts/core/Boilerplate/CreateModel/widgets/CreateModel.dart';
import 'package:receipts/core/widgets/cards/GeneralCard.dart';
import 'package:receipts/features/admin/data/department_list_response.dart';
import 'package:receipts/features/receipt/data/create_receipt_request.dart';
import 'package:receipts/features/receipt/data/item_list_response.dart';
import 'package:receipts/features/receipt/data/receipt_type_json.dart';
import 'package:receipts/features/receipt/repository/ReceiptRepository.dart';
import 'package:search_choices/search_choices.dart';

import 'package:flutter_icons/flutter_icons.dart';
import '../../../../core/API/CoreModels/empty_model.dart';
import '../../../../core/Boilerplate/CreateModel/cubits/create_model_cubit.dart';
import '../../../../core/Boilerplate/GetModel/widgets/GetModel.dart';
import '../../../../core/widgets/data_table/data_table.dart';
import '/core/constants/AppColors.dart';
import '/core/utils/Navigation/Navigation.dart';
import '/core/widgets/forms/RoundedNumberField.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



class FillReceiptPage extends StatefulWidget {
  final Department department;
  final Roles role;
  final int receiptType;

  const FillReceiptPage({Key key, this.department, this.role, this.receiptType}) : super(key: key);
  @override
  _CreateReceiptPageState createState() => _CreateReceiptPageState();
}

class _CreateReceiptPageState extends State<FillReceiptPage> {
  List<Item> records = [];
  List<DropdownMenuItem<Item>> items = [];
  String selectedValueSingleDialog;

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
                  //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "إنشاء إيصال :",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColors.black),
                      ),

                      SizedBox(width: 5,),
                      Text(
                        receipt_type[widget.receiptType]["name"],
                        style: TextStyle(
                            fontSize: 20,

                            color: AppColors.black),
                      ),
                    ],
                  ),

                  Row(
                   // mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'إلى :',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: AppColors.black),
                      ),
                      SizedBox(width: 5,),
                      Text(
                        widget.department.name,
                        style: TextStyle(
                            fontSize: 15,

                            color: AppColors.black),
                      ),
                      SizedBox(width: 5,),
                      Text(
                        widget.role.name,
                        style: TextStyle(
                            fontSize: 15,

                            color: AppColors.black),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
              child: Padding(
            child: loadTable(),
            padding: const EdgeInsets.all(8.0),
          )),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildCreateButton(),
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        // records.add(Item());
                        showDialog(
                          context: context,
                          useRootNavigator: true,

                          builder: (_){
                            return Center(
                              child: Container(

                                  child: SelectItemWidget(
                                    items: items,
                                    onDone: (Item item){
                                      records.add(item);
                                      setState(() {

                                      });
                                    },
                                  )),
                            );
                          }
                        );
                     //  Navigator.of(context).restorablePush(_dialogBuilder);

                      });
                    },
                    child: Text('إضافة مادة أخرى')),

              ],
            ),
          )
        ],
      ),
    );
  }

  CreateModelCubit cubit;
   buildCreateButton() {

    return CreateModel<EmptyModel>(
      repositoryCallBack: (data) => ReceiptRepository.createReceipt(data),
      onSuccess: (model){
        Navigation.pop();
      },
      onCubitCreated: (c){
        cubit=c;
      },

      child: ElevatedButton(
                    onPressed: () {
                       if(cubit != null){
                         cubit.createModel(CreateReceiptRequest(
                           mustApprovedByRoleId: widget.role.id,
                           receiptTypeId: widget.receiptType+1,
                           items: List.generate(records.length, (index) {
                             return ReceiptItem(
                               id: records[index].id,
                               value: records[index].unitValue

                             );
                           })
                         ));
                       }
                    },
                    child: Text('إرسال')),
    );
  }
  loadTable(){
    return GetModel<ItemListResponseModel>(
      repositoryCallBack: (data) => ReceiptRepository.getItems(),
      modelBuilder: (ItemListResponseModel model)=>buildTable(),
      onSuccess: (model){
        model.items.forEach((element) {
          items.add(DropdownMenuItem<Item>(
            child: Text(element.name),
            value: element,
          ));
        });
      },
    );
  }
  buildTable(){
    List<String> col =[
      "الرقم",
      "الاسم",
      "الكمية 1",

    ];
    int maxUnitCount=0;
    records.forEach((element) {
      if(element.units.length >maxUnitCount) maxUnitCount = element.units.length;
    });
    for(int i = 0 ;i < maxUnitCount ; i++){
      col.add('الكمية ${i+2}');
    }

    return MyDataTable(
      columns: col,
      rows: List.generate(records.length, (index) {
        List<String> list = [
          (index+1).toString(),
          records[index].name ,
          records[index].unitValue.toString() + records[index].unit,
        ];
        records[index].units.forEach((element) {
          list.add(element.value.toString() + element.name) ;
        });
        return list;
      }),
    );
  }

}


class SelectItemWidget extends StatefulWidget {
  final List<DropdownMenuItem<Item>> items ;
  final ModelReceived<Item> onDone;

  const SelectItemWidget({Key key, this.items, this.onDone}) : super(key: key);
  @override
  _SelectItemWidgetState createState() => _SelectItemWidgetState();
}

class _SelectItemWidgetState extends State<SelectItemWidget> {
  Item item;
  @override
  Widget build(BuildContext context) {
    return Container(

      child: GeneralCard(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SearchChoices.single(
                items: widget.items,
                value: item,
                hint: "إختر عنصر",
                searchHint: "إختر عنصر",
                onChanged: (value) {
                  setState(() {
                    item  = value;
                  });
                },
                isExpanded: true,
                searchFn: searchForItem


            ),
            if(item != null  )
              RoundedNumberField(


                controller: TextEditingController(text: item.unitValue==0 ? '':item.unitValue.toString()),
                onChanged: (value) {
                  print(value);
                  item.unitValue = int.tryParse(value)??0;

                  print(item.unitValue);
                  item.units.forEach((element) { 
                    element.value = item.unitValue/element.conversionFactor;
                  });
                  setState(() {

                  });
                },

                hintText: item?.unit.toString(),

              ),
            if(item != null && item.units != null)
              Wrap(
                children: List.generate(
                    item.units.length,
                        (i) {
                      return RoundedNumberField(
                        controller: TextEditingController(text: ( item.unitValue ==0? '':item.unitValue ~/ item.units[i].conversionFactor ).toString() ),
                        onChanged: (value) {
                          item.units[i].value = double.tryParse(value)??0.0;
                          item.unitValue = item.units[i].value.toInt() * item.units[i].conversionFactor;
                          setState(() {

                          });
                        },

                        hintText: item.units[i].name,

                      );
                    }),
              ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        Navigation.pop();
                        widget.onDone(item);

                      },
                      child: Text('موافق')),
                  ElevatedButton(
                      onPressed: () {
                        Navigation.pop();
                      },
                      child: Text('إغلاق')),

                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  searchForItem(String keyword, items) {
                List<int> ret = [];
                if (items != null && keyword.isNotEmpty) {
                  [keyword].forEach((k) {
                    int i = 0;
                    items.forEach((item) {
                      if (!ret.contains(i) &&
                          k.isNotEmpty &&
                          (item.value.name
                              .toString()
                              .toLowerCase()
                              .contains(k.toLowerCase()))) {
                        ret.add(i);
                      }
                      i++;
                    });
                  });
                }
                if (keyword.isEmpty) {
                  ret = Iterable<int>.generate(items.length).toList();
                }
                return (ret);
              }
}


