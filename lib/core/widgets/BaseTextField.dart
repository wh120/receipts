import '../constants/AppTheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../constants/AppColors.dart';
import 'package:easy_localization/easy_localization.dart' as t;

class BaseTextField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputAction action;
  final InputDecoration decoration;
  final String labelText;
  final Widget suffixIcon;
  final obscureText ;
  final  TextInputType keyboardType;
  final   ValueChanged<String> onChanged;
  final bool readOnly  ;
  final  String initialValue;
  final    List<TextInputFormatter> inputFormatters;
  final FormFieldValidator<String> validator;
  final GestureTapCallback onTap;
  final TextDirection textDirection;

    BaseTextField({
    Key key,
    this.controller,
    this.action,
    this.decoration,
    this.labelText,
    this.suffixIcon,
    this.obscureText = false,
    this.onChanged,
    this.keyboardType,
    this.readOnly = false,
    this.initialValue,
    this.inputFormatters,
    this.validator,
    this.onTap,
    this.textDirection
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);

    return TextFormField(
      readOnly: readOnly,

      textDirection: textDirection,
      onTap: onTap,
      initialValue: initialValue,
      obscureText: obscureText,
      controller: controller,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      textInputAction: action,
      onEditingComplete: () {
        if ( action == TextInputAction.next)
          node.nextFocus();
        else
          node.unfocus();
      },

      cursorColor: AppColors.primary,

      decoration: decoration==null?inputDecoration(context):decoration
      ,
      validator: validator,
      autovalidateMode: validator!=null?AutovalidateMode.onUserInteraction:null ,
      onChanged: onChanged,
    );



  }

  validate(value) {
    if (value.length < 5) {
      return 'Please_enter_a_longer_x'.tr(args: [labelText]);
    } else if (value.length > 32) {
      return 'x_must_not_be_longer_than_y_characters'.tr(args: [labelText, '32']);
    }
    return null;
  }

  inputDecoration(BuildContext context)
  {
    return InputDecoration(
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.gray)),
        labelText: labelText,
        labelStyle: AppTheme.bodyText1,
        suffixIcon: suffixIcon,

      // border: OutlineInputBorder(
      //     borderRadius: BorderRadius.circular(7.0)),
    );
  }

}



