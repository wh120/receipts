import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:receipts/core/widgets/cards/GeneralCard.dart';
import 'package:search_choices/search_choices.dart';

import 'package:flutter_icons/flutter_icons.dart';
import '../../../core/constants/AppColors.dart';
import '../../../core/utils/Navigation/Navigation.dart';
import '../../../core/widgets/data_table/data_table.dart';
import '../../../core/widgets/forms/RoundedNumberField.dart';
import '../theme/colors.dart';
import 'create_budge_page.dart';


class ReceiptDetailsPage extends StatefulWidget {
  @override
  _ReceiptDetailsPageState createState() => _ReceiptDetailsPageState();
}

class _ReceiptDetailsPageState extends State<ReceiptDetailsPage> {


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
                        "الموافقة على الإيصال",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: black),
                      ),
                      Text('ادخال مواد')
                    ],
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            title: Text('العميل: مدير القسم'),
            trailing: Text('منذ ساعة'),
          ),

          Expanded(
              child: MyDataTable(
                columns: [
                  "الرقم",
                  "الاسم",
                  "الكمية",
                  "الكمية 2",
                ],
                rows: List.generate(25, (index) => [index.toString(),"شراب عمار","12","12"]),
              )
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              
              children: [
                Expanded(
                  child: ElevatedButton(
                      onPressed: () {
                        Navigation.pop();
                      },
                      child: Text('موافق')
                  ),
                ),
                Spacer(),
                Expanded(
                  child: ElevatedButton(
                      onPressed: () {
                        Navigation.pop();
                      },
                      child: Text('رفض')
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  buildItems() {
    return ListView.builder(
        itemCount: 5,
        itemBuilder: (c,index){
          return GeneralCard(
            child: Column(
              children: [
                ListTile(
                  title: Text("شراب عمار"),
                  subtitle: Text("10 كغ"),
                )
              ],
            ),
          );

        });
  }

}

