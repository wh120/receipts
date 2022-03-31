import '../../../../core/constants/AppColors.dart';
import '../../../../core/constants/Validators.dart';
import '../../../../core/constants/app_styles.dart';
import '../../../../core/widgets/SectionTitle.dart';
import '../../../../core/widgets/forms/RoundedNumberField.dart';
import '../../../../core/widgets/forms/RoundedTextField.dart';
import '/features/App/presentation/widgets/ChangeLanguage.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart' as t;
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../AppSettings.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {


    return Scaffold(

      appBar: AppBar(
        title: Text('Settings'.tr()),
      ),
      body: _buildBody(context),
    );
  }

  _buildBody(context) {

    return Padding(
      padding:  AppStyles.horizontalPadding,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SectionTitle(title: 'General Settings'.tr(),),

            changeLanguageTile(context),

            SizedBox(height: 10,),
            changePhoneTile(),
            SectionTitle(title: 'App Settings'.tr(),),
            updateAppTile()
          ],
        ),
      ),
    );
  }

  ClipRRect changeLanguageTile(context) {
    return ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(50)),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: ListTile(
            tileColor: AppColors.grey,
            leading: Icon(Icons.language),
            trailing: Icon(
                Icons.arrow_forward_ios
            ),
            title: Text("Change Language".tr()),
            onTap: (){
              showDialog(
                context: context,
                builder: (BuildContext context) => ChangeLanguage(),
              );
            },
          ),
        );
  }




  bool isExpanded = false;
  Widget changePhoneTile() {
    return ExpansionPanelList(

      expansionCallback: (int index, bool isExpanded1) {
        setState(() {

          isExpanded = !isExpanded1;
        });
      },
      children: [
        ExpansionPanel(
          backgroundColor: AppColors.grey,
          headerBuilder: (BuildContext context, bool isExpanded1) {
            return ListTile(
               leading: Icon(Icons.phone ),
              // trailing: Icon(
              //     Icons.arrow_forward_ios
              // ),
              title: Text("Change Phone Number".tr()),
              onTap: (){
                 setState(() {
                   isExpanded = !isExpanded;
                 });
              },
            );
          },
          body: buildChangeNumberForm(),
          isExpanded:  isExpanded,
        )
      ]
    );
  }
  buildChangeNumberForm(){

    return Form(
      key: _formKey,
      child: Column (
        children: [
          RoundedNumberField(hintText: 'New Phone Number'.tr(),validator: Validators.validatePhoneNumber ,),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(

              onPressed: () {
                if (_formKey.currentState .validate()) {

                  setState(() {
                    isExpanded=false;
                  });

                }

              },
              //  textColor: Colors.white,

              child: Align(
                alignment: Alignment.center,
                child: Text(
                    'Change Phone Number'.tr()

                ),
              ),
            ),
          ),


        ],
      ),
    );
  }

  updateAppTile(){

    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(50)),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: ListTile(
        tileColor: AppColors.grey,
        leading: Icon(Icons.update),
        trailing: Icon(
            Icons.arrow_forward_ios
        ),
        title: Text('Update'.tr()),
        onTap: (){
          AppSettings.upgradeFromUrl();
        },
      ),
    );
  }
}
