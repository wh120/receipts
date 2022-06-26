import 'package:flutter/material.dart';
import 'AppColors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTheme
{

  static ThemeData theme=ThemeData(
    scaffoldBackgroundColor:  AppColors.white,

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

  static  AppBarTheme appBarTheme = AppBarTheme(
    iconTheme:  IconThemeData(color: AppColors.secondary[700],size: 5.0.r),
      color: AppColors.transparent,
     elevation: 0,
      titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: AppColors.black)
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

  static const String font =  fontCairo;


  static const String fontRegular =  fontCairo;



  static  TextStyle headline1 = const TextStyle(
    fontFamily: font,
    fontWeight: FontWeight.w700,
    fontSize: 20,
    letterSpacing: 0.4,
    height: 1.9,
    color: AppColors.blackText,
  );

  static  TextStyle headline2 = const TextStyle(
    fontFamily: font,
    fontWeight: FontWeight.w700,
    fontSize: 18,
    letterSpacing: 0.4,
    height: 1.5,
    color: AppColors.blackText,
  );
  static  TextStyle headline3 = const TextStyle(
    fontFamily: font,
    fontWeight: FontWeight.w600,
    fontSize: 14,
    letterSpacing: 0.4,
    height: 1.5,
    color: AppColors.blackText,
  );

  static  TextStyle headline4 = const TextStyle(
    fontFamily: font,
    /// fontWeight: FontWeight.bold,
    fontSize: 12,
    letterSpacing: 0.4,
    height: 1.5,
    color: AppColors.blackText,
  );

  static  TextStyle headline5 = TextStyle(
    fontFamily: font,
    //   fontWeight: FontWeight.bold,
    fontSize: 12,
    letterSpacing: 0.4,
    height: 0.9,
    color: AppColors.black,
  );

  //appbar title
  static  TextStyle headline6 = const TextStyle(
    fontFamily: font,
    fontWeight: FontWeight.bold,
    fontSize: 16,
    letterSpacing: 0.18,
    color: AppColors.blackText,
  );

  static  TextStyle subtitle1 = const TextStyle(
    fontFamily: AppTheme.font,
    height: 2,
    fontSize: 12,
    //letterSpacing: -0.04,
    color: AppColors.greyText,
  );

  static  TextStyle subtitle2 = TextStyle(
    fontFamily: font,
    fontWeight: FontWeight.w600,
    fontSize: 12,
    letterSpacing: -0.04,
    color: AppColors.black,
  );

  //default Text
  static  TextStyle bodyText2 = const TextStyle(
    fontFamily: font,
    fontWeight: FontWeight.w600,
    fontSize: 10,
//    letterSpacing: 0.2,
    color: AppColors.blackText,
  );

  static  TextStyle bodyText1 = TextStyle(
    fontFamily: font,
    fontWeight: FontWeight.w400,
    fontSize: 12,
    // letterSpacing: -0.05,
    color: AppColors.blackText,
  );

  //Validator Error message
  static  TextStyle caption = const TextStyle(
    fontFamily: font,
    fontWeight: FontWeight.w400,
    fontSize: 8,
    letterSpacing: 0.2,
    color: AppColors.lightText, // was lightText
  );


  static  TextStyle overLine = TextStyle(
    fontFamily: font,
    fontWeight: FontWeight.bold,
    fontSize: 6.0.sp,
    letterSpacing: 0.4,
    height: 0.9,
    color: AppColors.blackText.withOpacity(0.5),
  );

  static  TextStyle button = TextStyle(
    fontFamily: font,
    fontWeight: FontWeight.w500,
    fontSize: 12,
    letterSpacing: 0.4,
    height: 0.9,
    color: AppColors.white,
  );


}