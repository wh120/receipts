
import '/core/constants/AppColors.dart';
import '/core/constants/AppTheme.dart';
import '/core/utils/Navigation/Navigation.dart';
import '/core/widgets/snackbar.dart';
import '/features/App/presentation/pages/HomeApp.dart';
import '/features/User/domain/cubit/user_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:easy_localization/easy_localization.dart' as t;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'StopWatch.dart';




class PinCode extends StatefulWidget {
  final String phone;

  const PinCode({Key key, this.phone}) : super(key: key);
  @override
  PinCodeState createState() => PinCodeState();
}

class PinCodeState extends State<PinCode> {
  final _formKey = GlobalKey<FormState>();
  final _pinPutController = TextEditingController();
  final _pinPutFocusNode = FocusNode();




  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body:  Container(
        height: 100.0.h,
        color: AppColors.primary[10],
        padding:   EdgeInsets.all(5.0.r),
        child: onlySelectedBorderPinPut(),
      ),
    );
  }


  Widget onlySelectedBorderPinPut() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [

          Padding(
            padding:   EdgeInsets.only(bottom: 2.0.h),
            child: Text('Enter 6 digits verification code sent to your number'.tr(),
              //   style: AppTheme.headline3,
            ),
          ),
          StopWatch(time: 10,),
          Padding(
              padding:   EdgeInsets.only(bottom: 4.0.h),
              child:_buildConsumer()
          ),

          //  SizedBox(height: 50),
          Expanded(

            child: Container(
              child: Align(
                alignment: Alignment.center,
                child: Directionality(
                  textDirection: TextDirection.ltr,
                  child: Container(
                    // padding:   EdgeInsets.only(left: 15.r,right: 15.r),
                    child: AspectRatio(
                      aspectRatio: 2/3,
                      child: Center(
                        child: GridView.count(

                          //childAspectRatio: 1.5,
                          crossAxisCount: 3,
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          crossAxisSpacing: 1.r,
                          mainAxisSpacing: 2.r,
                          //   padding: const EdgeInsets.all(10),
                          // physics: NeverScrollableScrollPhysics(),
                          children: [
                            ...[1, 2, 3, 4, 5, 6, 7, 8, 9].map((e) {
                              return RoundedButton(
                                title: '$e',
                                onTap: () {
                                  _pinPutController.text = '${_pinPutController.text}$e';
                                },
                              );
                            }),
                            RoundedButton(
                              title: "Cancel".tr(),
                              isNumber: false,
                              onTap: () {
                                Navigation.pop();
                              },
                            ),
                            RoundedButton(
                              title: "0",
                              onTap: () {
                                _pinPutController.text = '${_pinPutController.text}0';
                              },
                            ),
                            RoundedButton(
                              title: "Clear".tr(),
                              isNumber: false,
                              onTap: () {
                                if (_pinPutController.text.isNotEmpty) {
                                  _pinPutController.text = _pinPutController.text
                                      .substring(0, _pinPutController.text.length - 1);
                                }
                              },
                            ),

                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Row(
          //   children: [
          //     TextButton(onPressed: (){}, child: Text('Clear'.tr()))
          //   ],
          // )
        ],
      ),
    );
  }

  _buildConsumer()
  {
    //  return _buildButton();
    return BlocConsumer<UserCubit,UserState>(
      // cubit: userCubit,
        listener: (context, state) {

          if(state is LoginError){
            showSnackBar(state.message.toString());
            Navigation.pop();
            //ScaffoldMessenger.of(context).showSnackBar(snackBar(state.message.toString()));
          }
          else if(state is LoginSuccessfully) {
            Navigation.pushReplacement(HomeApp());
             context.read<UserCubit>().emit(UserInitial());
          }

          else if(state is OtpSuccessfully) {
            showSnackBar(state.code.toString());

          }

        },
        builder: (context, state) {

          if(state is LoginLoading)
            return Center(child: CupertinoActivityIndicator());
          else
            return _buildPinPut( );
        }
    );

  }

  _buildPinPut() {
    final BoxDecoration pinPutDecoration = BoxDecoration(
      color: AppColors.primary[500],


      borderRadius: BorderRadius.circular(2.0.r),
    );

    return Directionality(
      textDirection: TextDirection.ltr  ,
      child: PinPut(


        useNativeKeyboard: false,
        // autovalidateMode: AutovalidateMode.onUserInteraction,
        withCursor: true,
        fieldsCount: 6,
        fieldsAlignment: MainAxisAlignment.spaceAround,
        textStyle: const TextStyle(fontSize: 25.0, color: Colors.white),
        eachFieldMargin: EdgeInsets.all(0),
        eachFieldWidth: 10.0.w,
        eachFieldHeight: 7.0.h,
        eachFieldPadding: EdgeInsets.all(0),
        onSubmit: (s)async{
       //   context.read<UserCubit>().verifyLogin(widget.phone,s);
       //   await Future.delayed(Duration(milliseconds: 90), () => false);
          _pinPutController.clear();
        },
        focusNode: _pinPutFocusNode,
        controller: _pinPutController,
        submittedFieldDecoration: pinPutDecoration,
        selectedFieldDecoration: pinPutDecoration.copyWith(
          color: Colors.white,
          border: Border.all(
            width: 2,
            color: AppColors.primary,
          ),
        ),
        followingFieldDecoration: pinPutDecoration,
        pinAnimationType: PinAnimationType.fade,
      ),
    );
  }


}

class RoundedButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  final bool isNumber;

  RoundedButton({this.title, this.onTap, this.icon, this.isNumber=true});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: ConstrainedBox(

        constraints:BoxConstraints(
            maxWidth:80,
            maxHeight:80
        ),
        child: TextButton(
          onPressed: onTap,
          style: ButtonStyle(
            //  maximumSize: MaterialStateProperty.all<Size>(Size.fromRadius(35)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.r ),
                      side: BorderSide(color: AppColors.primary)
                  )
              )
          ),

          // width: 25.w,
          // height: 25.w,
          // decoration: BoxDecoration(
          //
          //   shape: BoxShape.circle,
          // border: Border.all(color: AppColors.primary)
          // //  color: AppColors.primary,
          //
          // ),

          //color: Colors.red,
          //    alignment: Alignment.center,
          child: Center(
            child: Text(
              '$title',
              style:isNumber?
              AppTheme.headline2.copyWith(color: AppColors.primary):
              AppTheme.headline4.copyWith(color: AppColors.secondary[700])
              ,

            ),
          ),
        ),
      ),
    );
  }
}

