import 'package:flutter/material.dart';
import 'package:receipts/core/Boilerplate/GetModel/widgets/GetModel.dart';

import '../../../../core/constants/AppColors.dart';
import '../../../../core/utils/Navigation/Navigation.dart';
import '../../../../core/widgets/ColumnBuilder.dart';
import '../../../../core/widgets/cards/GeneralCard.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        "إدارة الاقسام",
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
                  Navigation.push(AddTransformationPage());
                },
                child: Text('إضافة عملية جديدة')),
          )
        ],
      ),
    );
  }

  getBody() {
    return GetModel<TransformationList>(
      repositoryCallBack: (data) => AdminRepository.getTransformations(),
      modelBuilder: (TransformationList model) => buildBody(model),
    );
  }

  buildBody(TransformationList model) {
    return ListView.builder(
        itemCount: model.items.length,
        itemBuilder: (c, index) {
          return GeneralCard(
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
        });
  }
}

class AddTransformationPage extends StatefulWidget {
  const AddTransformationPage({Key key}) : super(key: key);

  @override
  State<AddTransformationPage> createState() => _AddTransformationPageState();
}

class _AddTransformationPageState extends State<AddTransformationPage> {
  List<DropdownMenuItem<Item>> items = [];
  Transformation transformation = Transformation(inputs: [], outputs: []);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('إضافة عملية جديدة'),
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
                      child: ListView.builder(
                        itemCount: transformation.inputs.length,
                        itemBuilder: (context, index) => Row(
                          children: [
                            Text(transformation.inputs[index].name),
                            Spacer(),
                            Text(transformation.inputs[index].unitValue
                                    .toString() +
                                ' ' +
                                transformation.inputs[index].unit.toString())
                          ],
                        ),
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
                        itemBuilder: (context, index) => Row(
                          children: [
                            Text(transformation.outputs[index].name),
                            Spacer(),
                            Text(transformation.outputs[index].unitValue
                                    .toString() +
                                ' ' +
                                transformation.outputs[index].unit.toString())
                          ],
                        ),
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
                        child: Text('إضافة مادة أخرى')),
                  ],
                ),
              )),
            ],
          ),
        ),
        Expanded(child: Container())
      ],
    );
  }

  buildCreateButton() {
    return ElevatedButton(
        onPressed: () {
          Navigation.push(AddTransformationPage());
        },
        child: Text('إضافة عملية جديدة')
    );
  }
}
