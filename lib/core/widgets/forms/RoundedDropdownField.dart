import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'RoundedTextField.dart';

class RoundedDropdownField extends StatefulWidget {
  final String hintText;
  final List<String> values;
  final ValueChanged<int> onChanged;
  final FormFieldValidator<String>  validator;


  const RoundedDropdownField({Key key, this.hintText, this.values, this.onChanged, this.validator}) : super(key: key);
  @override
  _RoundedDropdownFieldState createState() => _RoundedDropdownFieldState();
}

class _RoundedDropdownFieldState extends State<RoundedDropdownField> {
  String selectedValue;
  @override
  Widget build(BuildContext context) {

    return RoundedTextField(
      validator: widget.validator,
      hintText: widget.hintText ,
      readOnly: true ,
      onTap: (){ showBottomSheet();},
      controller: TextEditingController(text:selectedValue ),
    );
  }

  showBottomSheet() {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 10,
        enableDrag: true,
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 25.0.h,
            child: _picker(widget.values),
          );
        });
  }

  _picker(List  items) {

    int init = items.indexWhere((element) => element  == selectedValue );

    return InkWell(

      onTap:  () {
        Navigator.pop(context);
      },

      child: CupertinoPicker(
        scrollController: FixedExtentScrollController(initialItem: init),
        onSelectedItemChanged: (value) {
          widget.onChanged(value);
          setState(() {
            selectedValue = items[value];

          });
        },
        itemExtent: 30.0,
        squeeze: 1,

        children: List.generate(items.length, (index) {
          return Text(items[index]);
        }),
      ),
    );
  }

}
