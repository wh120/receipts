import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'RoundedDateTimeField.dart';
import 'RoundedTextField.dart';

class RoundedNumberField extends StatelessWidget {
  final String hintText;
  final FormFieldValidator<String>  validator;
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  const RoundedNumberField({Key key, this.hintText, this.validator, this.controller, this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  RoundedTextField(


      // onTap: (){
      //   if(controller != null){
      //     if(double.tryParse(controller.text) != null){
      //       if(double.tryParse(controller.text) == 0.0){
      //         controller.text='';
      //       }
      //     }
      //   }
      // },


      onChanged: onChanged,
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
