import 'package:flutter/material.dart';
import '../constants/app_styles.dart';

class MyAppBar  {

  static PreferredSizeWidget build(String title) {
    return AppBar(
      centerTitle: true,
      title: Text(title,  style: TextStyle(color: Colors.white),),
      shape: AppStyles.appBarShape,
    );
  }

}
