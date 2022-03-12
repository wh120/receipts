import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'RoundedDateTimeField.dart';
import 'RoundedTextField.dart';

class RoundedNumberField extends StatelessWidget {
  final String hintText;
  final FormFieldValidator<String>  validator;
  final TextEditingController controller;

  const RoundedNumberField({Key key, this.hintText, this.validator, this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  RoundedTextField(

      controller: controller,
      hintText: hintText,
      validator: validator,
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
      ],
    );
  }
}
