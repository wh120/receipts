import 'package:flutter/material.dart';
import 'AppColors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTheme
{

  static ThemeData theme=ThemeData(
    scaffoldBackgroundColor:  AppColors.primary[1],

    highlightColor: AppColors.secondary[50],
    primaryColor: AppColors.primary,
    primaryColorDark: AppColors.primary[900],
    primaryColorLight:AppColors.primary[400] ,
    primarySwatch: AppColors.primary,
    canvasColor: Colors.white,
    accentColor: AppColors.secondary,
    buttonColor: AppColors.primary,
    unselectedWidgetColor: Colors.grey,


    textTheme: textTheme,
    appBarTheme: appBarTheme,
    primaryTextTheme: textTheme,

    accentIconTheme: IconThemeData(color: AppColors.secondary[700],size: 5.0.r),
    iconTheme: IconThemeData(color: AppColors.secondary[700],size: 5.0.r),
    primaryIconTheme: IconThemeData(color: AppColors.white ,size: 5.0.r),
    elevatedButtonTheme: elevatedButtonThemeData(),
    textButtonTheme: textButtonThemeData(),
   // snackBarTheme: SnackBarThemeData( contentTextStyle: bodyText2 ),

    visualDensity: VisualDensity.adaptivePlatformDensity,
  );

  static TextButtonThemeData textButtonThemeData() {
    return TextButtonThemeData(
    style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(15)),
        foregroundColor: MaterialStateProperty.all<Color>(AppColors.primary[200]),
        textStyle: MaterialStateProperty.all<TextStyle>(subtitle2),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
                side: BorderSide(color: AppColors.primary[200])
            )
        )
    )
  );
  }

  static ElevatedButtonThemeData elevatedButtonThemeData() {
    return ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor:MaterialStateProperty.all<Color>( AppColors.primary),
        //textStyle: MaterialStateProperty.all<TextStyle>(button),
        elevation: MaterialStateProperty.all<double>(10),
          padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(20)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              )
          )
      )
  );
  }

  static const AppBarTheme appBarTheme = AppBarTheme(
      color: AppColors.primary,
  //    brightness: Brightness.light,

  );

  static  TextTheme textTheme = TextTheme(

    headline1:headline1 ,
    headline2:headline2 ,
    headline3:headline3 ,
    headline4: headline4,
    headline5: headline5,
    headline6: headline6,
    subtitle1: subtitle1,
    subtitle2: subtitle2,
    bodyText2: bodyText2,
    bodyText1: bodyText1,
   button: button,

  //  button: headline1,
    caption: caption,
    overline: overLine,

  );
  static const String fontRoboto = 'Roboto';
  static const String fontDroidKufi = 'DroidKufi-Regular';

  static const String fontTajawal = 'Tajawal';
  static const String fontHarmattan = 'Harmattan';
  static const String fontCairo = 'Cairo';


  static const String fontRegular =  fontCairo;


  static  TextStyle overLine = TextStyle(
    fontFamily: fontRegular,
    fontWeight: FontWeight.bold,
    fontSize: 6.0.sp,
    letterSpacing: 0.4,
    height: 0.9,
    color: AppColors.darkText.withOpacity(0.5),
  );

  static  TextStyle button = TextStyle(
    fontFamily: fontRegular,
    fontWeight: FontWeight.w700,
    fontSize: 4.0.sp,
    letterSpacing: 0.4,
    height: 0.9,
    color: AppColors.primary,
  );


  static  TextStyle headline1 = TextStyle(
    fontFamily: fontRegular,
    fontWeight: FontWeight.bold,
    fontSize: 10.0.sp,
    letterSpacing: 0.4,
    height: 0.9,
  //  color: AppColors.white,
  );

  static  TextStyle headline2 = TextStyle(
    fontFamily: fontRegular,
    fontWeight: FontWeight.bold,
    fontSize: 7.5.sp,
    letterSpacing: 0.4,
    height: 0.9,
   // color: AppColors.white,
  );
  static  TextStyle headline3 = TextStyle(
    fontFamily: fontRegular,
    fontWeight: FontWeight.w400,
    fontSize: 6.0.sp,
    letterSpacing: 0.4,
    height: 0.9,
    color: AppColors.secondary[700],
  );

  static  TextStyle headline4 = TextStyle(
    fontFamily: fontRegular,
   /// fontWeight: FontWeight.bold,
    fontSize: 5.0.sp,
    letterSpacing: 0.4,
    height: 0.9,
   // color: AppColors.white,
  );

  static  TextStyle headline5 = TextStyle(
    fontFamily: fontRegular,
 //   fontWeight: FontWeight.bold,
    fontSize: 4.0.sp,
    letterSpacing: 0.4,
    height: 0.9,
    color: AppColors.primary[400],
  );

  //appbar title
  static  TextStyle headline6 = TextStyle(
    fontFamily: fontRegular,
    fontWeight: FontWeight.bold,
    fontSize: 4.0.sp,
    letterSpacing: 0.18,
  //  color: AppColors.white,
  );

  static  TextStyle subtitle1 = TextStyle(
    fontFamily: fontRegular,
    fontWeight: FontWeight.w400,
    fontSize: 4.0.sp,
    letterSpacing: -0.04,
    color: AppColors.darkText,
  );

  static  TextStyle subtitle2 = TextStyle(
    fontFamily: fontRegular,
    fontWeight: FontWeight.w400,
    fontSize: 4.0.sp,
    letterSpacing: -0.04,
    color: AppColors.primary[200],
  );

  //default Text
  static  TextStyle bodyText2 = TextStyle(
    fontFamily: fontRegular,
    fontWeight: FontWeight.w400,
    fontSize: 3.5.sp,
//    letterSpacing: 0.2,
    color: AppColors.darkText,
  );

  static  TextStyle bodyText1 = TextStyle(
    fontFamily: fontRegular,
    fontWeight: FontWeight.w400,
    fontSize: 5.0.sp,
    letterSpacing: -0.05,
    color: AppColors.primary[200],
  );

  //Validator Error message
  static  TextStyle caption = TextStyle(
    fontFamily: fontRegular,
    fontWeight: FontWeight.w400,
    fontSize: 3.2.sp,
    letterSpacing: 0.2,
    color: AppColors.lightText, // was lightText
  );




}