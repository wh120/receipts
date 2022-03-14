import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/AppColors.dart';
import '../../../core/widgets/forms/SelectDropDown.dart';





class DropDown2Page extends StatefulWidget {
  const DropDown2Page({Key key}) : super(key: key);

  @override
  State<DropDown2Page> createState() => _DropDown2PageState();
}

class _DropDown2PageState extends State<DropDown2Page> {
  ObjectDropDownItem selectedValue;
  List<ObjectDropDownItem> items = [
    null,
    ObjectDropDownItem(id: 1 , name: "s1"),
    ObjectDropDownItem(id: 2 , name: "s2"),
    ObjectDropDownItem(id: 3 , name: "s3"),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(
            child: ObjectDropDown<ObjectDropDownItem>(
              items: items,
              selectedValue:  ObjectDropDownItem(id: 3 , name: "s3"),
              onChanged: (value) => selectedValue = value ,
            ),
          ),
          ElevatedButton(onPressed: (){
            print(selectedValue?.name);
          }, child: Text('w'))
        ],

      ),
    );

  }
}

