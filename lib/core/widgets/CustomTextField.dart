import 'package:flutter/material.dart';
import '../constants/AppColors.dart';
import 'BaseTextField.dart';



class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final   ValueChanged<String> onChanged;
  final String label;
  final  TextInputType keyboardType;
  final bool readOnly;
  final String initialValue;
  final FormFieldValidator<String> validator;
  final GestureTapCallback onTap;
  final String hintText;

  CustomTextField({
    this.controller,
    this.onChanged,
    this.label,
    this.keyboardType,
    this.readOnly=false,
    this.initialValue,
    this.validator,
    this.onTap,
    this.hintText
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BaseTextField(


        onTap: onTap,
        initialValue: initialValue,
        readOnly: readOnly,
        controller: controller,
        onChanged: onChanged,
        keyboardType: keyboardType,
        validator: validator,
        decoration: new InputDecoration(
          hintText: hintText,
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
