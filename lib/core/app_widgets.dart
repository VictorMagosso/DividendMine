import 'package:DividendMine/controller/stock_controller.dart';
import 'package:DividendMine/pages/add_stock_page.dart';
import 'package:DividendMine/pages/home_page.dart';
import 'package:DividendMine/splash/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<StockController>.value(value: StockController())
      ],
      child: MaterialApp(
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate
          ],
          supportedLocales: [
            const Locale('pt', 'BR')
          ],
          title: "DividendMine",
          home: SplashScreen(),
          debugShowCheckedModeBanner: false),
    );
  }
}
