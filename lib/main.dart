import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hadaf/ui/views/SplashScreen.dart';

void main() {
  runApp(
      EasyLocalization(
        child:  MyApp(),
        supportedLocales: [
          const Locale('en', 'US'), // English
          const Locale('ar', 'SA'), // Arabic
        ],
        path: 'assets/lang',
        saveLocale: true,
        startLocale:  const Locale('ar', 'SA'),
      )
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    log(EasyLocalization.of(context).locale.toString(),
        name: '${this} # locale');
    log('title'.tr().toString(), name: '${this} # locale');
    return GestureDetector(
      onTap: (){
        FocusScopeNode scope = FocusScope.of(context);
        if(!scope.hasPrimaryFocus)
          FocusScope.of(context).requestFocus(new FocusNode());

      },
      child: MaterialApp(
        title: 'title'.tr(),
        localizationsDelegates:EasyLocalization.of(context).delegates,
        supportedLocales: EasyLocalization.of(context).supportedLocales,
        locale: EasyLocalization.of(context).locale,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: "Cairo",
        ),
        home: SplashScreen(),
      ),

    );
  }
}
