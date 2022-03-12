import '../constants/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'BaseTextField.dart';



class NumberTextField extends StatelessWidget {
  final TextEditingController controller;
  final   ValueChanged<String> onChanged;
  final String label;
  final bool readOnly;
  final String initialValue;
  final FormFieldValidator<String> validator;

  NumberTextField({this.controller,
    this.onChanged,
    this.label,
    this.readOnly=false,
    this.initialValue, this.validator
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BaseTextField(

        initialValue: initialValue,
        readOnly: readOnly,
        controller: controller,
        onChanged: onChanged,
        keyboardType: TextInputType.number,
        validator:validator,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly,

        ], //


        decoration: new InputDecoration(
          labelText: label,
          enabledBorder: const OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.primary, width: 2.0),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.primary, width: 2.0),
          ),
        ),

      ),
    );
  }
}
