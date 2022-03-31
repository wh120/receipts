import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AppColors {



  static const Color white1 = Color(0xffF0F9FE);
  static const Color grey = Color(0xffEDEDED);


  static const Map<int, Color> PrimarySwatch = {

    1: Color(0xFFFAF1F1),
    5: Color(0xFFF6DADB),
    10: Color(0xFFF5C5C7),
    15: Color(0xFFF3B0B2),
    25: Color(0xFFE59C9F),
    50: Color(0xFFE36C70),
    100: Color(0xFFDC5E63),
    200: Color(0xFFE84A50),
    300: Color(0xFFEA575C),
    400: Color(0xFFEA373E),
    500: Color(0xFFED1C24),
    600: Color(0xFFED1C24),
    700: Color(0xFFED1C24),
    800: Color(0xFFED1C24),
    900: Color(0xFFED1C24),
  };

  static const MaterialColor primary = MaterialColor(0xFFED1C24, PrimarySwatch);

  static const Map<int, Color> SecondaryMaterial = {
    1:Color(0xFFF8FFF1),
    5:Color(0xFFF3FFE4),
    10:Color(0xFFECFDD6),
    25:Color(0xFFE6FFCB),
    50: Color(0xFFD7FDB3),
    100: Color(0xFFC6F894),
    200: Color(0xFFBBF582),
    300: Color(0xFFAAE86C),
    400: Color(0xFF91D453),
    500: Color(0xFF7FC241),
    600: Color(0xFF6FBA28),
    700: Color(0xFF5DA719),
    800: Color(0xFF4A8D0D),
    900: Color(0xFF387106),
  };

  static const MaterialColor secondary = MaterialColor(0xFF7FC241, SecondaryMaterial);

  static const Color transparent = Color(0x00000000);


  static const Color white = Colors.white;
  static const Color black = Colors.black;

 // static const Color gray = Color(0xFFBDBDBD);
  static const Color gray1 = Color(0xFFA4A4A4);
  static List<Color> linear = [
    Color(0xFF87D1C6),
    Color(0xFFC5E7E2),
    Color(0xFFE6F4F2)
  ];

  static const Color red1 = Color(0xFFFFF6F4);
  static const Color red = Color(0xFFF78481); //Colors.redAccent[100]



  //Text Theme
  static const Color lightText = Color(0xFF979797);
  static const Color darkText = Color(0xFF4A4A4A);
  static const Color darkerText = Color(0xFF17262A);
  static const Color blackText = Color(0xFF022424);

  static List<Color> randomColor = [
    Color(0xFF87D1C6),
    Color(0xFFF78481),
    Color(0xFF5A78C0),
    Colors.deepOrange,
    Colors.teal,
    Colors.yellow,
    Colors.brown

  ];
}
