

import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:receipts/features/RootApp/pages/root_app.dart';


import 'StartUp.dart';
import 'core/constants/AppColors.dart';
import 'core/constants/Keys.dart';
import 'core/constants/constants.dart';
import 'core/utils/SharedPreferences/SharedPreferencesHelper.dart';
import 'features/App/presentation/pages/HomeApp.dart';
import 'core/constants/AppTheme.dart';

import 'features/User/domain/cubit/user_cubit.dart';
//import 'features/User/presentation/pages/LoginPage.dart';
import 'features/User/presentation/pages/LoginPage.dart';

void main() async {


  WidgetsFlutterBinding.ensureInitialized();

//   SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
//     statusBarColor: Colors.transparent,
//     systemNavigationBarColor: Colors.white,
//     systemNavigationBarIconBrightness: Brightness.dark,
//   ));


  await StartUp.setup();

  String lang = AppSharedPreferences.lang;
  Locale startLocale;
  if(lang ==null){
    AppSharedPreferences.lang = DEFAULT_LANGUAGE;
    startLocale =LANGUAGES[DEFAULT_LANGUAGE];
  }
  else
    startLocale =LANGUAGES[lang];

  runApp(
    EasyLocalization(
        startLocale:startLocale,
        supportedLocales: LANGUAGES.values.toList(),
        path: "assets/lang",
        child:Phoenix(
          child: _blocProvider(),
        )
    ),
  );
}

_blocProvider()
{
  return MultiBlocProvider(
    providers: [
      BlocProvider<UserCubit>(
        create: (BuildContext context) => UserCubit(),
      ),
    ],
    child: Responsive(),
  );

}

class Responsive extends StatelessWidget {
  const Responsive({Key key }) : super(key: key);
  @override
  Widget build(BuildContext context) {

    return ScreenUtilInit(
      designSize: Size(100, 100),
      builder: () => MyApp(),
    );

    // return Sizer(
    //   builder: (context, orientation, deviceType) {
    //     return  MyApp();
    //   },
    // );
  }
}
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      scrollBehavior: MyCustomScrollBehavior(),


      navigatorKey: Keys.navigatorKey,
      debugShowCheckedModeBanner: false,
      title: APP_NAME.tr(),
      theme: AppTheme.theme,
      home:  _buildHome(context),


      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,


    );
  }

  Widget _buildHome(BuildContext context){
    HttpOverrides.global = MyHttpOverrides();
    if (AppSharedPreferences.firstTime) {
      AppSharedPreferences.firstTime= false;
      return LoginPage();
    } else if(AppSharedPreferences.hasAccessToken) {

      return RootApp();
    }
    else{
      return  LoginPage();
    }
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
    // etc.
  };
}
class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}
