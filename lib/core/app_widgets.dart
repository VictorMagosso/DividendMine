import 'package:DividendMine/pages/add_stock_page.dart';
import 'package:DividendMine/pages/home_page.dart';
import 'package:DividendMine/splash/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        supportedLocales: [
          const Locale('pt', 'BR')
        ],
        title: "DividendMine",
        home: SplashScreen(),
        debugShowCheckedModeBanner: false);
  }
}
