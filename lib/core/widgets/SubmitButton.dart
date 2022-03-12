import 'package:flutter/material.dart';
import '../constants/AppColors.dart';

class SubmitButton extends StatelessWidget {
  final Function onPressed;
  final String text ;
  SubmitButton({this.onPressed, this.text});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: RaisedButton(
        onPressed: onPressed,
        color: AppColors.primary,
        child: Text(
          text,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
