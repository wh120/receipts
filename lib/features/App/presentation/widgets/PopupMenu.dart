import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '/features/App/domain/cubit/application_cubit.dart';
import '/features/App/presentation/widgets/ChangeLanguage.dart';
import '/features/User/domain/cubit/user_cubit.dart';
import '/features/User/presentation/pages/LoginPage.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter_icons/flutter_icons.dart';
import '../../../../core/utils/SharedPreferences/SharedPreferencesHelper.dart';
enum Menu { changeLanguage, logOut, update}

class PopupMenu extends StatelessWidget {
  Menu _selection;

  @override
  Widget build(BuildContext context) {
    return _buildMenu(context);
  }
  _buildMenu(BuildContext context) {

    return PopupMenuButton<Menu>(
      icon: Icon(
        AntDesign.setting,),
      onSelected: (Menu result)async {
        if(result == Menu.changeLanguage)
        {
          showDialog(
            context: context,
            builder: (BuildContext context) => ChangeLanguage(),
          );
        }
        else if(result == Menu.logOut)
        {
          await logOut(context);
        }
        else if(result == Menu.update){
        // AppSettings.upgradeFromUrl();
          //AppSharedPreferences.accessToken = 'ss';
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<Menu>>[
         PopupMenuItem<Menu>(
          value: Menu.changeLanguage,
          child: Text("Change Language".tr()),
        ),
          PopupMenuItem<Menu>(
          value: Menu.logOut,
          child: Text('Log out'.tr()),
        ),
        PopupMenuItem<Menu>(
          value: Menu.update,
          child: Text('Update'.tr()),
        ),


      ],
    );
  }

  Future logOut(BuildContext context) async {
     bool result = await UserCubit().logout();
    if(result){
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (BuildContext context) => LoginPage())
      );
    }
    else{
      //todo
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (BuildContext context) => LoginPage())
      );
    }
  }


}
