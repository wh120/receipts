import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:receipts/core/widgets/forms/RoundedTextField.dart';

import '../../../../core/API/http/api_urls.dart';
import '/features/App/domain/cubit/application_cubit.dart';
import '/features/App/presentation/widgets/ChangeLanguage.dart';
import '/features/User/domain/cubit/user_cubit.dart';
import '/features/User/presentation/pages/LoginPage.dart';
import 'package:easy_localization/easy_localization.dart' as e;

import 'package:flutter_icons/flutter_icons.dart';
import '../../../../core/utils/SharedPreferences/SharedPreferencesHelper.dart';
enum Menu { changeLanguage, logOut, update , changeURL}

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
        else if(result == Menu.changeURL){
          changeURL(context);

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
        PopupMenuItem<Menu>(
          value: Menu.changeURL,
          child: Text('change URL' ),
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

  changeURL(context){
    showDialog(
        context: context,
        builder: (_)=>SingleChildScrollView(
          child: Align(
            alignment: Alignment.center,
            child: Dialog(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Container(
                       //   height:70.h ,
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: RoundedTextField(


                              hintText: 'server url',

                              initialValue: AppSharedPreferences.baseURL,
                              onChanged: (v){
                                AppSharedPreferences.baseURL=v;

                              },

                            ),
                          )),
                    ],
                  ),
                ) ),
          ),
        ));
  }


}
