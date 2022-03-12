import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AppColors {



  static const Color white1 = Color(0xffF0F9FE);
  static const Color gray = Color(0xffEDEDED);


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
    1:Color(0xFFFCF4F1),
    5:Color(0xFFFDF4EC),
    10:Color(0xFFFCF2E6),
    25:Color(0xFFFCEAC5),
    50: Color(0xFFFCD38A),
    100: Color(0xFFFCC954),
    200: Color(0xFFFFC947),
    300: Color(0xFFFFC947),
    400: Color(0xFFFFC947),
    500: Color(0xFFFFC947),
    600: Color(0xFFE0A818),
    700: Color(0xFFC48E0A),
    800: Color(0xFF9A6C00),
    900: Color(0xFF503904),
  };

  static const MaterialColor secondary = MaterialColor(0xFFFFC947, SecondaryMaterial);

  static const Color transparent = Color(0x00000000);


  static const Color white = Color(0xFFE5E5E5);

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
