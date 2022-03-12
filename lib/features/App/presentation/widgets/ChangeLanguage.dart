import '/core/constants/Keys.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

import '../../../../core/constants/AppTheme.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/utils/SharedPreferences/SharedPreferencesHelper.dart';
import '/features/App/presentation/pages/HomeApp.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/features/User/domain/cubit/user_cubit.dart';
class ChangeLanguage extends StatefulWidget {
  @override
  _ChangeLanguageState createState() => _ChangeLanguageState();
}

class _ChangeLanguageState extends State<ChangeLanguage> {
  String dropdownValue ;

  @override
  void initState() {

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return _buildPopupDialog(context);
  }

  Widget _buildPopupDialog(BuildContext context) {
      dropdownValue = context.locale.toString();

    return new AlertDialog(
      title:  Text(
          "Change Language".tr(),
        style: AppTheme.bodyText1,
      ),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildDrop( ),

        ],
      ),

    );
  }
  _buildDrop(){
    return DropdownButton<String>(
      isExpanded: true,
      value: dropdownValue,
      icon: const Icon(Icons.sort_by_alpha),
      iconSize: 24,
      elevation: 16,

      // underline: Container(
      //   height: 2,
      //   color: Colors.deepPurpleAccent,
      // ),
      onChanged: (String newValue) {
        setState(()async{
          print(newValue);
          dropdownValue = newValue;
          context.setLocale(LANGUAGES[newValue]);
          AppSharedPreferences.lang = newValue;
          await UserCubit.changeLanguage(newValue);

          Phoenix.rebirth(context);
          // Keys.refreshKeys();
          // while(Navigator.canPop(context)) Navigator.pop(context);
          // Navigator.pushReplacement(context, MaterialPageRoute(
          //     builder: (_) =>HomeApp()
          // )
          // );
        });
      },
      items: LANGUAGES.keys.toList()
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value.tr()),
        );
      }).toList(),
    );
  }
}