import 'package:flutter/material.dart';
import 'package:receipts/core/Boilerplate/CreateModel/cubits/create_model_cubit.dart';
import 'package:receipts/features/RootApp/pages/root_app.dart';
import 'package:receipts/features/User/data/LoginResponseModel.dart';
import 'package:receipts/features/User/domain/repo/UserRepository.dart';

import '../../../../core/Boilerplate/CreateModel/widgets/CreateModel.dart';
import '../../../../core/constants/AppColors.dart';
import '../../../../core/utils/Navigation/Navigation.dart';
import '../../../../core/utils/SharedPreferences/SharedPreferencesHelper.dart';
import '../../../App/presentation/widgets/PopupMenu.dart';
import '../../data/LoginRequestModel.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// -------------------------------
//  This project written by : Thalisonh on Github.com
//  You can find this class and all its components
//  on this Repo  : https://github.com/Thalisonh/minimalist-flutter
// -------------------------------

class LoginPage extends StatefulWidget {
  static const routeName = '/LoginPage1';
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [AppColors.primary, AppColors.primary[100]]),
        ),

        /// -------------------------------
        /// Building main content with list view
        /// -------------------------------

        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                Row(children: <Widget>[


                  /// ---------------------------------------------------------------------------
                  /// Vertical Text widget that is build with RotatedBox widget  build in flutter
                  /// ---------------------------------------------------------------------------
                  VerticalText(),


                  /// ---------------------------------------------------------------------------
                  /// TextLogin widget that is build with Container widget  build in flutter
                  /// ---------------------------------------------------------------------------
                  TextLogin(),

                  Expanded(child: PopupMenu())
                ]),

                /// ---------------------------------------------------------------------------
                /// InputEmail widget that is build with TextField widget  build in flutter and response size
                /// ---------------------------------------------------------------------------
                InputEmail(
                  controller: emailController,
                ),

                /// ---------------------------------------------------------------------------
                /// PasswordInput widget that is build with TextField widget  build in flutter and response size
                /// ---------------------------------------------------------------------------
                PasswordInput(
                  controller: passwordController
                  ,
                ),

                /// ---------------------------------------------------------------------------
                /// ButtonLogin widget that is build with StatefulWidget and FlatButton widget build in flutter and response size
                /// ---------------------------------------------------------------------------
                ButtonLogin(
                  emailController: emailController,
                  passwordController: passwordController,
                ),

                /// ---------------------------------------------------------------------------
                /// FirstTime widget that is build with StatefulWidget, Text and FlatButton widget build in flutter and response size
                /// ---------------------------------------------------------------------------
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// ---------------------------------------------------------------------------
/// ButtonLogin widget that is build with StatefulWidget and FlatButton widget build in flutter and response size
/// ---------------------------------------------------------------------------

class ButtonLogin extends StatefulWidget {
  final TextEditingController emailController  ;
  final TextEditingController passwordController  ;

  const ButtonLogin({Key key, this.emailController, this.passwordController}) : super(key: key);
  @override
  _ButtonLoginState createState() => _ButtonLoginState();
}

class _ButtonLoginState extends State<ButtonLogin> {
  CreateModelCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:   EdgeInsets.all(5.r),
      child: CreateModel<LoginResponseModel>(
        repositoryCallBack: (data) => UserRepository.login(data),
        onCubitCreated: (c) {
          cubit = c;
        },
        onSuccess: (LoginResponseModel model) {
          AppSharedPreferences.accessToken = model.accessToken;
          AppSharedPreferences.isAdmin = model.isAdmin;
          Navigation.pushReplacement(RootApp());
        },
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: AppColors.white
          ),
          onPressed: () {
            if (cubit != null)
              cubit.createModel(LoginRequestModel(
                  email: widget.emailController.text, password: widget.passwordController.text));
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'تسجيل الدخول ',
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Icon(
                Icons.arrow_forward,
                color: AppColors.primary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// ---------------------------------------------------------------------------
/// InputEmail widget that is build with TextField widget  build in flutter and response size
/// ---------------------------------------------------------------------------

class InputEmail extends StatefulWidget {
  final TextEditingController controller;

  const InputEmail({Key key, this.controller}) : super(key: key);
  @override
  _InputEmailState createState() => _InputEmailState();
}

class _InputEmailState extends State<InputEmail> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50, left: 50, right: 50),
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width,
        child: TextField(
          controller: widget.controller,
          style: TextStyle(
            color: Colors.white,
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            fillColor: Colors.lightBlueAccent,
            labelText: 'اسم المستخدم',
            labelStyle: TextStyle(
              color: Colors.white70,
            ),
          ),
        ),
      ),
    );
  }
}

/// ---------------------------------------------------------------------------
/// PasswordInput widget that is build with TextField widget  build in flutter and response size
/// ---------------------------------------------------------------------------

class PasswordInput extends StatefulWidget {
  final TextEditingController controller;

  const PasswordInput({Key key, this.controller}) : super(key: key);
  @override
  _PasswordInputState createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 50, right: 50),
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width,
        child: TextField(
          controller: widget.controller,
          style: TextStyle(
            color: Colors.white,
          ),
          obscureText: true,
          decoration: InputDecoration(
            border: InputBorder.none,
            labelText: 'كلمة المرور',
            labelStyle: TextStyle(
              color: Colors.white70,
            ),
          ),
        ),
      ),
    );
  }
}

/// ---------------------------------------------------------------------------
/// TextLogin widget that is build with Container widget  build in flutter
/// ---------------------------------------------------------------------------

class TextLogin extends StatefulWidget {
  @override
  _TextLoginState createState() => _TextLoginState();
}

class _TextLoginState extends State<TextLogin> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30.0, left: 10.0),
      child: Container(
        //color: Colors.green,
        height: 200,
        width: 200,
        child: Column(
          children: <Widget>[
            Container(
              height: 60,
            ),
            Center(
              child: Text(
                'أهلاً وسهلاً',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// ---------------------------------------------------------------------------
/// Vertical Text widget that is build with RotatedBox widget  build in flutter
/// ---------------------------------------------------------------------------

class VerticalText extends StatefulWidget {
  @override
  _VerticalTextState createState() => _VerticalTextState();
}

class _VerticalTextState extends State<VerticalText> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 60, left: 10),
      child: RotatedBox(
          quarterTurns: -1,
          child: Text(
            'Sing in',
            style: TextStyle(
              color: Colors.white,
              fontSize: 38,
              fontWeight: FontWeight.w900,
            ),
          )),
    );
  }
}
