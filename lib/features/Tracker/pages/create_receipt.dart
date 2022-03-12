import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:receipts/core/widgets/cards/GeneralCard.dart';
import 'package:search_choices/search_choices.dart';

import 'package:flutter_icons/flutter_icons.dart';
import '../../../core/constants/AppColors.dart';
import '../../../core/utils/Navigation/Navigation.dart';
import '../../../core/widgets/forms/RoundedNumberField.dart';
import '../theme/colors.dart';
import 'create_budge_page.dart';

class Item {
  TextEditingController count1 = TextEditingController();
  TextEditingController count2 = TextEditingController();
  String name;

  Item({this.count1, this.count2, this.name});
}

class CreateReceiptPage extends StatefulWidget {
  @override
  _CreateReceiptPageState createState() => _CreateReceiptPageState();
}

class _CreateReceiptPageState extends State<CreateReceiptPage> {
  List<Item> records = [Item()];
  List<DropdownMenuItem> items = [];
  String selectedValueSingleDialog;
  final List<String> categories = [

    "شراب برتقال",
    "شراب فريز",
    "شراب برتقال",
    "شراب وينر ظرف 9غ",
    "شراب عمار ظرف 35 غ اصبع",
    "شراب عمار ظرف 35 غ مربع",
    "شراب عمار 650 غ",
    "شراب عمار 2 كغ علبة بلاستيك",
    "شراب محلى وينر دكما",
    "شراب عادي عمار دكما",
    "شراب عمار 10غ غير محلى",
    "ميلو وينر",
    "ميلو الفائز علة بلاستيك 205غ",
    "ميلو الفائز ظرف 20غ",
    "ميلو الفائز ظرف 20غ ** 12 علبة",
    "ميلو الفائز دكما",
  ];

  @override
  void initState() {
    categories.forEach((element) {
      items.add(DropdownMenuItem(
        child: Text(element),
        value: element,
      ));
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.grey[100],
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(color: white, boxShadow: [
              BoxShadow(
                color: grey.withOpacity(0.01),
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
                            color: black),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
              child: Padding(
            child: buildItems(),
            padding: const EdgeInsets.all(8.0),
          )),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                    onPressed: () {
                      Navigation.pop();
                    },
                    child: Text('إرسال')),
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        records.add(Item());
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

  buildItems() {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
              itemCount: records.length,
              itemBuilder: (c, index) {
                return GeneralCard(
                  child: Column(
                    children: [
                      SearchChoices.single(
                        items: items,
                        value: records[index].name,
                        hint: "Select one",
                        searchHint: "Select one",
                        onChanged: (value) {
                          setState(() {
                            records[index].name = value;
                          });
                        },
                        isExpanded: true,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: RoundedNumberField(
                              // onChanged: (value) {
                              //   records[index].count1 = int.parse(value);
                              // },

                              controller: records[index].count1,
                              hintText: 'كغ',
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: RoundedNumberField(
                              // onChanged: (value) {
                              //   records[index].count2 = int.parse(value);
                              // },
                              controller: records[index].count2,
                              hintText: 'طرد',
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                          color: AppColors.primary,
                          onPressed: () {
                            if (records.length == 1) return;
                            records.removeAt(index);
                            setState(() {});
                          },
                          icon: Icon(Icons.close))
                    ],
                  ),
                );
              }),
        ),
      ],
    );
  }
}

class MYCard extends StatelessWidget {
  final Widget child;

  const MYCard({Key key, this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return card();
  }

  card() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 10,
      ),
      child: Container(
        margin: EdgeInsets.only(
          left: 10,
        ),
        decoration: BoxDecoration(
            color: white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: grey.withOpacity(0.01),
                spreadRadius: 10,
                blurRadius: 3,
                // changes position of shadow
              ),
            ]),
        child: child,
      ),
    );
  }
}
