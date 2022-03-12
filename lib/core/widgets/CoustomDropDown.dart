import 'package:flutter/material.dart';
import '../constants/AppColors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CoustomDropDown extends StatefulWidget {
  final Function(String) onValueSelected;
  final List<String> list;
  CoustomDropDown({this.onValueSelected , this.list});
  @override
  _CoustomDropDownState createState() => _CoustomDropDownState();
}

class _CoustomDropDownState extends State<CoustomDropDown> {
  String dropdownValue = 'One';
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 25.0.w,
        height: 12.0.w,
        decoration: BoxDecoration(
          border: Border.all(width: 3.0, color: AppColors.primary),
        ),
        child: Center(
            child: DropdownButton<String>(
          underline: SizedBox(),
          value: dropdownValue,
          onChanged: (String newValue) {
            setState(() {
              dropdownValue = newValue;
              widget.onValueSelected(newValue);
            });
          },
          items: widget.list
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        )));
  }
}
