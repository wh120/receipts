import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'RoundedTextField.dart';

class RoundedDateTimeField extends StatefulWidget {
  final String hintText;
  final DateEditingController controller;
  final FormFieldValidator<String>  validator;

  const RoundedDateTimeField({Key key, this.hintText, this.controller, this.validator}) : super(key: key);

  @override
  _RoundedDateTimeFieldState createState() => _RoundedDateTimeFieldState();
}

class _RoundedDateTimeFieldState extends State<RoundedDateTimeField> {
  DateTime _dateTime = DateTime.now();
  var controller = TextEditingController();


  @override
  Widget build(BuildContext context) {

    return  RoundedTextField(
      validator: widget.validator,
      hintText: widget.hintText  ,
      readOnly: true ,
      onTap: (){_pickTime();},
      controller: controller,
    );
  }

  _pickTime() async {

    DateTime d = await showDatePicker(
      context: context,
      initialDate: _dateTime,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),


    );
    if (d != null) {
      widget.controller.date = d;
      controller.text = DateFormat.yMMMd() .format(_dateTime);
      setState(() {
        _dateTime = d;
      });
    }
  }
}
class DateEditingController{
  DateTime date;
}

