import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart' as t;
import '../../../../core/widgets/BaseTextField.dart';
class UsernameTextField extends StatelessWidget {

  final TextEditingController textEditingController;
  final TextInputAction action;

  const UsernameTextField({Key key, this.textEditingController, this.action}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BaseTextField(
      textDirection: TextDirection.ltr,
      controller: textEditingController,
      action: action,
      labelText: "username".tr(),
      suffixIcon: Icon(Icons.person),
    );
  }
}
