import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart' as t;
import '../../../../core/widgets/BaseTextField.dart';
class PasswordTextField extends StatefulWidget {
  final TextEditingController textEditingController;
  final TextInputAction action;
  const PasswordTextField({Key key, this.textEditingController, this.action}) : super(key: key);

  @override
  _PasswordTextFieldState createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    return BaseTextField(
      textDirection: TextDirection.ltr,
      obscureText: !_showPassword,
      controller: widget.textEditingController,
      action:  widget.action,
      labelText: "password".tr(),
      suffixIcon: _suffixIcon() ,
    );
  }
  _suffixIcon()
  {
    return IconButton(
      icon: Icon(
        _showPassword
            ? Icons.visibility
            : Icons.visibility_off,
        color: Colors.blueGrey,
      ),
      onPressed: () =>
          setState(() {
            _showPassword = !_showPassword;
          }),
    );
  }
}