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

class FillReceiptPage extends StatefulWidget {
  final Receipt receipt;

  const FillReceiptPage({Key key, this.receipt}) : super(key: key);
  @override
  _CreateReceiptPageState createState() => _CreateReceiptPageState();
}

class _CreateReceiptPageState extends State<FillReceiptPage> {
  List<DropdownMenuItem<Item>> items = [];
  bool isNew;
  @override
  void initState() {
    isNew = widget.receipt.id == null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          (isNew ? "إنشاء إيصال :" : "تعديل إيصال :") + '  '+ receipt_type[widget.receipt.receiptTypeId-1]["name"],

        ),
      ),
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
                  top: 30, right: 20, left: 20, bottom: 25),
              child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [

                      Text(
                        'من :',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: AppColors.black),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        widget.receipt?.fromDepartment?.name??'-',
                        style: TextStyle(fontSize: 15, color: AppColors.black),
                      ),

                      SizedBox(
                        width: 10,
                      ),

                      Text(
                        'إلى :',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: AppColors.black),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        widget.receipt?.toDepartment?.name??'-',
                        style: TextStyle(fontSize: 15, color: AppColors.black),
                      ),
                      SizedBox(
                        width: 5,
                      ),

                    ],
                  ),
                  Text(
                    widget.receipt.mustApprovedByRole?.name??'',
                    style: TextStyle(fontSize: 15, color: AppColors.black),
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
                isNew ? buildCreateButton() : buildApproveButton(),
                if (isNew)
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          if(items.length==0)return;
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
                                        if(item!= null)
                                          if(!widget.receipt.items.contains(item))
                                           widget.receipt.items.add(item);
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
          )
        ],
      ),
    );
  }

  CreateModelCubit cubit;
  buildCreateButton() {
    return CreateModel<EmptyModel>(
      repositoryCallBack: (data) => ReceiptRepository.createReceipt(data),
      onSuccess: (model) {
        Navigation.pop();
      },
      onCubitCreated: (c) {
        cubit = c;
      },
      child: ElevatedButton(
          onPressed: () {
            if (cubit != null) {
              cubit.createModel(CreateReceiptRequest(
                description: widget.receipt.description ,
                  mustApprovedByRoleId: widget.receipt.mustApprovedByRole?.id,
                  receiptTypeId: widget.receipt.receiptTypeId,
                  fromDepartmentId: widget.receipt.fromDepartmentId,
                  toDepartmentId: widget.receipt.toDepartmentId,
                  items: List.generate(widget.receipt.items.length, (index) {
                    return ReceiptItem(

                        id: widget.receipt.items[index].id,
                        value0: widget.receipt.items[index].unitValue,
                        value1: widget.receipt.items[index].value1,
                        value2: widget.receipt.items[index].value2,
                    );
                  })));
            }
          },
          child: Text('إرسال')),
    );
  }

  buildApproveButton() {
    return CreateModel<EmptyModel>(
      repositoryCallBack: (data) => ReceiptRepository.approveReceipt(data),
      onSuccess: (model) {
        Navigation.pop();
      },
      onCubitCreated: (c) {
        cubit = c;
      },
      child: ElevatedButton(
          onPressed: () {
            if (cubit != null) {
              cubit.createModel(widget.receipt.id);
            }
          },
          child: Text(isNew ? 'إرسال' : 'موافقة')),
    );
  }

  loadTable() {

    return GetModel<ItemListResponseModel>(
      repositoryCallBack: (data) => ReceiptRepository.getItems(),
      modelBuilder: (ItemListResponseModel model) => buildTable(),
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

  buildTable() {




    return WidgetDataTable(
      columns: [
        Text(
          "الرقم",
        ),
        Text(
          "الاسم",
        ),
        Text("الكمية 1"),
        Text("الكمية 2"),
        Text("الكمية 3"),
        Text('الأوامر')
      ],
      rows: List.generate(widget.receipt.items.length, (index) {
        List<Widget> list = [
          Text((index + 1).toString()),
          Text(widget.receipt.items[index].name),
          Text(widget.receipt.items[index].unitValue.toString() +' '+ widget.receipt.items[index].unit),
        ];

        //todo
        for(int i = 0; i < 3;i++) {
          String s = '-';
          if(widget.receipt.items[index].units.tryGet(i) != null)
             s =widget.receipt.items[index].units.tryGet(i).value.toString() + ' ' + widget.receipt.items[index].units.tryGet(i).name;
          list.add(Text(s));
        }

        if (isNew)
          list.add(IconButton(
              onPressed: () {
                widget.receipt.items.removeAt(index);
                setState(() {});
              },
              icon: Icon(Icons.delete)));
        return list;
      }),
    );
  }
}

class SelectItemWidget extends StatefulWidget {
  final List<DropdownMenuItem<Item>> items;
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
                    item = value;
                    // item = Item(
                    //   name: value.name,
                    //   unit: value.unit,
                    //   id: value.id,
                    //   code: value.code,
                    //     units: List.generate(value.units.length,
                    //             (index) => Unit(id: value.units[index].id,conversionFactor: value.units[index].conversionFactor , name: value.units[index].name , ))
                    // );
                   });
                },
                isExpanded: true,
                searchFn: searchForItem),
            if (item != null)
              RoundedNumberField(
                controller: item.controller,
                // controller: TextEditingController(
                //     text: item.unitValue == 0 ? '' : item.unitValue.toString()),
                onChanged: (value) {
                  item.unitValue = double.tryParse(value) ?? 0;
                  item.units.forEach((element) {
                    if(element.isConst){
                      element.value = item.unitValue / element.conversionFactor;
                      element.controller.text = element.value==0?'':element.value.toString();

                    }


                  });
                  setState(() {});
                },
                hintText: item?.unit.toString(),
              ),
            if (item != null && item.units != null)
              Wrap(
                children: List.generate(item.units.length, (i) {
                  return RoundedNumberField(
                    controller: item.units[i].controller,

                    onChanged: (value) {
                      item.units[i].value = double.tryParse(value) ?? 0.0;
                     if(item.units[i].isConst){
                       item.unitValue = item.units[i].value * item.units[i].conversionFactor;
                       item.controller.text = item.unitValue == 0?'':item.unitValue.toString();
                       item.units.forEach((element) {

                         if(item.units[i].id !=element.id) {
                           var r = (item.unitValue / element.conversionFactor).roundToDouble();
                           element.value=r;
                           element.controller.text = r==0?'':r.toString();
                         }
                       });
                     }

                      setState(() {});
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
                        if(item!= null &&item.unitValue>0){
                          Navigation.pop();
                          for(int i = 0 ; i < item.units.length ; i++){
                            switch(i){
                              case 0:
                                item.value1= item.units[i].value;
                                break;
                              case 1:
                                item.value2= item.units[i].value;
                                break;
                            }
                          }


                          widget.onDone(item);
                        }

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
              (
                  item.value.name
                  .toString()
                  .toLowerCase()
                  .contains(k.toLowerCase())
                  ||  item.value.id.toString().contains(k.toLowerCase())
              )
          ) {
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
