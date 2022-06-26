import 'package:flutter/material.dart';
import 'package:receipts/core/API/CoreModels/empty_model.dart';
import 'package:receipts/core/Boilerplate/CreateModel/cubits/create_model_cubit.dart';
import 'package:receipts/core/utils/Navigation/Navigation.dart';
import 'package:receipts/core/widgets/forms/RoundedTextField.dart';

import '../../../../core/Boilerplate/CreateModel/widgets/CreateModel.dart';
import '../../../../core/constants/AppColors.dart';
import 'package:flutter_icons/flutter_icons.dart';

import '../../../User/domain/repo/UserRepository.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({Key key}) : super(key: key);

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  CreateModelCubit cubit;

  TextEditingController oldPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmedPassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(),
    );
  }
  Widget getBody() {
    var size = MediaQuery.of(context).size;


    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(color: AppColors.white, boxShadow: [
                BoxShadow(
                  color: AppColors.grey.withOpacity(0.01),
                  spreadRadius: 10,
                  blurRadius: 3,
                  // changes position of shadow
                ),
              ]),
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 60, right: 20, left: 20, bottom: 25),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "تغيير كلمة السر",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppColors.black),
                        ),

                      ],
                    ),
                    SizedBox(
                      height: 25,
                    ),


                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            RoundedTextField(
              hintText: 'كلمة السر القديمة',
              controller: oldPassword,
            ),
            RoundedTextField(
              hintText: 'كلمة السر الجديدة',
              controller: newPassword,
            ),
            RoundedTextField(
              hintText: 'تأكيد كلمة السر الجديدة',
              controller: confirmedPassword,
            ),
            CreateModel<EmptyModel>(
              repositoryCallBack: (data) => UserRepository.changePassword(oldPassword.text, newPassword.text),
              onSuccess: (model) {

                Navigation.pop();
              },
               onCubitCreated: (c){cubit=c;},
              child: ElevatedButton(
                  onPressed: (){
                    if(confirmedPassword.text.isNotEmpty&&
                      oldPassword.text.isNotEmpty &&
                    newPassword.text.isNotEmpty &&
                    newPassword.text == confirmedPassword.text
                    )

                    cubit.createModel(null);
                  },
                  child: Text('تغيير كلمة المرور')),
            )

          ],
        ),
      ),
    );
  }
}
