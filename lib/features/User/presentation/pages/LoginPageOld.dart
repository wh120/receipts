// import 'package:clinic_patients/adaptive.dart';
// import '/core/constants/AppColors.dart';
// import '/core/utils/Navigation/Navigation.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import '/core/widgets/snackbar.dart';
// import '/features/App/presentation/pages/HomeApp.dart';
//  import '/features/User/domain/cubit/user_cubit.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:easy_localization/easy_localization.dart' as t;
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '/features/User/presentation/widgets/Footer.dart';
// import 'package:easy_localization/easy_localization.dart' as t;
//
// class LoginPage extends StatefulWidget {
//   static const routeName = '/LoginPage';
//
//   @override
//   _LoginPageState createState() => _LoginPageState();
// }
//
// class _LoginPageState extends State<LoginPage> {
//   TextEditingController _usernameController = new TextEditingController();
//
//   TextEditingController _passwordController = new TextEditingController();
//
//   final _formKey = GlobalKey<FormState>();
//
//   @override
//   void initState() {
//     context.read<UserCubit>().loginWithToken();
//     super.initState();
//   }
//   @override
//   Widget build(BuildContext context) {
//
//     _usernameController = new TextEditingController(text: 'admin');
//     _passwordController = new TextEditingController(text: '123qwe');
//
//     assert(() {
//
//
//       return true;
//
//     }());
//
//     return buildScaffold(context);
//   }
//
//
//
//   Scaffold buildScaffold(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Colors.white,
//         body: NotificationListener<OverscrollIndicatorNotification>(
//           onNotification: (overscroll) {
//             overscroll.disallowGlow();
//             return false;
//           },
//           child: SingleChildScrollView(
//             child: Container(
//               child: Column(
//                 children: [
//                   buildTopContainer(context),
//                   buildButtonContainer(),
//                 //  buildCreateAccount(),
//                 ],
//               ),
//             ),
//           ),
//         ));
//   }
//
//   Container buildButtonContainer() {
//     return Container(
//                   margin:  EdgeInsets.only(
//                     top: 12.0.h,
//                     left: 2.0.h,
//                     right: 2.0.h,
//                   ),
//                   child: _buildConsumer() ,
//                 );
//   }
//
//   Container buildTopContainer(BuildContext context) {
//
//     return Container(
//
//   //    height: 50.h,
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           begin: Alignment(-1.0, 0.0),
//           end: Alignment(1.0, 0.0),
//           colors: [
//             Theme.of(context).primaryColorLight,
//             Theme.of(context).primaryColorDark,
//           ],
//         ),
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.end,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Container(
//             margin: EdgeInsets.only(
//               top: 10.0.h,
//             ),
//             child: Text(
//               'My Health'.tr(),
//               style: AppTheme.headline1,
//             ),
//           ),
//           Container(
//             child: Padding(
//               padding: const EdgeInsets.only(
//                 top: 15.0,
//                 left: 40.0,
//                 right: 40.0,
//               ),
//               child: Text(
//                 'sign_in'.tr(),
//                 textAlign: TextAlign.center,
//                 style: AppTheme.headline2,
//               ),
//             ),
//           ),
//           Container(
//             transform: Matrix4.translationValues(0.0, 10.0.h, 0.0),
//             margin: const EdgeInsets.only(
//               left: 20.0,
//               right: 20.0,
//             ),
//             width: double.infinity,
//             decoration: new BoxDecoration(
//               borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(25),
//                 topRight: Radius.circular(25),
//                 bottomLeft: Radius.circular(25),
//                 bottomRight: Radius.circular(25),
//               ),
//               color: Color(0xFFFFFFFF),
//               boxShadow: [
//                 new BoxShadow(
//                   color: Colors.black12,
//                   blurRadius: 50.0,
//                   offset: Offset(0, 0),
//                 ),
//               ],
//             ),
//             child: buildForm(context),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget buildForm(BuildContext context) {
//     return Form(
//       key: _formKey,
//       child: Column(
//         children: [
//           SizedBox(height: 3.0.h,),
//
//           UserNameTextFiled( ),
//        //   PasswordTextFiled(passwordController: _passwordController),
//           SizedBox(height: 5.0.h,)
//         ],
//       ),
//     );
//   }
//
//   _buildConsumer()
//   {
//     //  return _buildButton();
//     return BlocConsumer<UserCubit,UserState>(
//       // cubit: userCubit,
//         listener: (context, state) {
//
//           if(state is LoginError){
//             showSnackBar(state.message.toString());
//             //ScaffoldMessenger.of(context).showSnackBar(snackBar(state.message.toString()));
//           }
//
//
//           else if(state is LoginSuccessfully) {
//             Navigation.pushReplacement(HomeApp());
//
//           }
//         },
//         builder: (context, state) {
//
//           if(state is LoginLoading)
//             return Center(child: CupertinoActivityIndicator());
//           else
//             return buildSignInButton(context);
//         }
//     );
//
//   }
//
//   Container buildSignInButton(BuildContext context) {
//     return Container(
//
//       child: ElevatedButton(
//
//         onPressed: () {
//           if(_formKey.currentState.validate())
//           Navigation.push(PinPutView(onSubmit: (S){
//             _onPressLoginButton(context);
//           },));
//        //   _onPressLoginButton(context);
//         },
//       //  textColor: Colors.white,
//
//         child: Align(
//           alignment: Alignment.center,
//           child: Text(
//             'sign_in'.tr(),
//
//           ),
//         ),
//       ),
//     );
//   }
//
//
//   Container buildCreateAccount() {
//     return Container(
//       margin: const EdgeInsets.only(
//         top: 20.0,
//         left: 20.0,
//         right: 20.0,
//
//       ),
//       child: TextButton(
//         child: Text(
//           'Need an account? Create one instead.'.tr(),
//         ),
//         onPressed: (){
//
//         },
//       ),
//     );
//   }
//
//
//
//
//
//   _buildFooter(){
//     return Hero(
//         child: IconFooter(),
//       tag: 'Footer',
//     );
//   }
//
//
//
//
//
//   _onPressLoginButton(BuildContext context) {
//
//     if(_formKey.currentState.validate()){
//        context.read<UserCubit>().login(_usernameController.text, _passwordController.text);
//     }
//   }
//
//
// }
//
// class PasswordTextFiled extends StatelessWidget {
//   const PasswordTextFiled({
//     Key key,
//     @required TextEditingController passwordController,
//   }) : _passwordController = passwordController, super(key: key);
//
//   final TextEditingController _passwordController;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.only(
//         left: 20.0,
//         right: 20.0,
//         bottom: 20.0,
//       ),
//       child: TextFormField(
//         keyboardType: TextInputType.visiblePassword,
//         validator: (val) {
//           return val.length >= 6
//               ? null
//               : "Please_enter_a_longer_x".tr(args: ['password'.tr() ]);
//         },
//         controller: _passwordController,
//         obscureText: true,
//         decoration: InputDecoration(
//           hintText: 'password'.tr(),
//           hintStyle: TextStyle(
//             color: Color(0xFFb1b2c4),
//           ),
//           border: new OutlineInputBorder(
//             borderSide: BorderSide.none,
//             borderRadius: BorderRadius.circular(60),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderSide: BorderSide(color: Theme.of(context).primaryColor),
//             borderRadius: BorderRadius.circular(60),
//           ),
//           filled: true,
//           fillColor: Colors.black.withOpacity(0.05),
//           prefixIcon: Icon(
//             Icons.lock_outline,
//
//           ),
//           //
//         ),
//       ),
//     );
//   }
// }
//
// class UserNameTextFiled extends StatelessWidget {
//   const UserNameTextFiled({
//     Key key,
//     @required TextEditingController usernameController,
//   }) : _usernameController = usernameController, super(key: key);
//
//   final TextEditingController _usernameController;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.all(20.0),
//       child: TextFormField(
//         keyboardType: TextInputType.numberWithOptions(),
//         validator: (val) {
//           if( val.length == 10) return null;
//           else if (val.length < 10)
//             return "Please_enter_a_longer_x".tr(args: ['Phone Number'.tr()]);
//           else return "x_must_not_be_longer_than_y_characters".tr(args: ['Phone Number'.tr() ,'10']);
//         },
//         controller: _usernameController,
//         textCapitalization: TextCapitalization.none,
//         decoration: InputDecoration(
//           hintText: 'Phone Number'.tr(),
//           hintStyle: TextStyle(
//             color: Color(0xFFb1b2c4),
//           ),
//           border: new OutlineInputBorder(
//             borderSide: BorderSide.none,
//             borderRadius: BorderRadius.circular(60),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderSide: BorderSide(color: Theme.of(context).primaryColor),
//             borderRadius: BorderRadius.circular(60),
//           ),
//           filled: true,
//           fillColor: Colors.black.withOpacity(0.05),
//           prefixIcon: Icon(
//             Icons.account_circle,
//
//           ),
//           //
//         ),
//       ),
//     );
//   }
// }
//
//
//
//
