import '../../constants/Keys.dart';
import '/features/User/presentation/pages/LoginPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Navigation{


  static popThenPush(Widget page){
    Navigation.pop();
    Navigation.push(page);
  }

  static push(Widget page){
    Navigator.push(
      Keys.navigatorKey.currentContext,
      CupertinoPageRoute(

          builder: (context) => page

      ),
    );
  }
  static pop({dynamic value}){
    Navigator.pop(Keys.navigatorKey.currentContext,value);
  }


  static pushReplacement(Widget page){
    Navigator.pushReplacement(
      Keys.navigatorKey.currentContext,
      CupertinoPageRoute(
          builder: (context) => page
      ),
    );
  }

  static goToLogin( ){

    Navigator.pushReplacement(
        Keys.navigatorKey.currentContext,
        MaterialPageRoute(builder: (BuildContext context) => LoginPage())
    );


  }

}